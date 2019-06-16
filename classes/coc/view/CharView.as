/**
 * Coded by aimozg on 10.07.2017.
 */
package coc.view {
import classes.internals.LoggerFactory;

import coc.view.charview.CharViewCompiler;
import coc.view.charview.CharViewContext;
import coc.view.charview.CharViewSprite;
import coc.view.charview.Palette;
import coc.view.charview.EvalPaletteProperty;
import coc.view.charview.PaletteProperty;
import coc.view.composite.CompositeImage;
import coc.view.composite.SimpleKeyColorProvider;
import coc.xlogic.Statement;
import coc.xlogic.StmtList;

import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;

import mx.logging.ILogger;

public class CharView extends Sprite {
	private static const LOGGER:ILogger = LoggerFactory.getLogger(CharView);
	private var loading:Boolean;
	private var sprites:Object = {}; // spritesheet/spritemap -> CharViewSprite
	public var composite:CompositeImage;
	private var ss_total:int;
	private var ss_loaded:int;
	private var file_total:int;
	private var file_loaded:int;
	private var _originX:int;
	private var _originY:int;
	private var _width:uint;
	private var _height:uint;
	private var scale:Number;
	private var pendingRedraw:Boolean;
	private var loaderLocation:String;
	private var parts:Statement;
	private var _palette:Palette;
	
	public function get palette():Palette {
		return _palette;
	}
	public function CharView() {
		clearAll();
	}
	/**
	 * @param location "external" or "internal"
	 */
	public function reload(location:String = "internal"):void {
		loaderLocation = location;
		if (loading) return;
		try {
			loading = true;
			clearAll();
			LOGGER.info("loading XML res/model.xml");
			CoCLoader.loadText("res/model.xml", function (success:Boolean, result:String, e:Event):void {
				if (success) {
					init(XML(result));
				} else {
					LOGGER.error("XML file not found: " + e);
					loading = false;
				}
			}, loaderLocation);
		} catch (e:Error) {
			loading = false;
			LOGGER.error("[ERROR]\n" + e.getStackTrace());
		}
	}
	private function clearAll():void {
		this.sprites       = {};
		this.composite     = null;
		this.ss_total      = 0;
		this.ss_loaded     = 0;
		this.file_total    = 0;
		this.file_loaded   = 0;
		this._width        = 180;
		this._height       = 220;
		this.scale         = 1;
		this.pendingRedraw = false;
		this.parts         = new StmtList();
		clearSprite();
	}
	private function clearSprite():void {
		var g:Graphics = graphics;
		g.clear();
		g.beginFill(0, 0);
		g.drawRect(0, 0, _width, _height);
		g.endFill();
	}
	private function init(xml:XML):void {
		_width    = xml.@width;
		_height   = xml.@height;
		_originX  = xml.@originX || 0;
		_originY  = xml.@originY || 0;
		composite = new CompositeImage(_width, _height);
		ss_loaded = 0;
		ss_total  = -1;
		/**/
		loadPalette(xml);
		var compiler:CharViewCompiler = new CharViewCompiler(this);
		this.parts = compiler.compileXMLList(xml.logic.children());
		var n:int  = 0;
		var item:XML;
		for each(item in xml.spritesheet) {
			n++;
			loadSpritesheet(xml, item);
		}
		for each(item in xml.spritemap) {
			n++;
			loadSpritemap(xml, item);
		}
		ss_total = n;
		if (n == 0) loadLayers(xml);
		var g:Graphics = graphics;
		clearSprite();
		scale       = parseFloat(xml.@scale);
		this.scaleX = scale;
		this.scaleY = scale;
		loading     = false;
		if (pendingRedraw) redraw();
	}
	private function loadPalette(xml:XML):void {
		_palette                 = new Palette();
		for each (var xpal:XML in xml.palettes.palette) {
			var lookups:Object = {};
			for each (var color:XML in xpal.color) {
				lookups[color.@name.toString()] = color.text().toString();
			}
			_palette.addLookups(xpal.@name.toString(),lookups);
		}
		for each (var prop:XML in xml.properties.property) {
			var propname:String = prop.@name.toString();
			
			var pp:PaletteProperty;
			var defaultt:uint = Color.convertColor(prop.@default.toString());
			var lookupNames:* = prop.@palette.toString().split(',');
			if ('@src' in prop) {
				pp = new EvalPaletteProperty(_palette,propname,defaultt,lookupNames,prop.@src.toString());
			} else {
				pp = new PaletteProperty(_palette,propname,defaultt,lookupNames);
			}
			_palette.addPaletteProperty(pp);
		}
		for each (var key:XML in xml.colorkeys.key) {
			var src:uint    = Color.convertColor(key.@src.toString());
			var base:String = key.@base.toString();
			var tf:String   = key.@transform.toString() || "";
			_palette.addKeyColor(src, base, tf);
		}
	}
	public function lookupColorValue(layername:String, propname:String, colorname:String):uint {
		return _palette.lookupColor(layername, propname, colorname);
	}
	private function loadLayers(xml:XML):void {
		file_loaded = 0;
		var item:XML;
		var n:int   = 0;
		file_total  = -1;
		for each(item in xml.layers..layer) {
			var lpfx:String = item.@name + "/";
			for (var sname:String in sprites) {
				if (sname.indexOf(lpfx) == 0) {
					var sprite:CharViewSprite = sprites[sname];
					composite.addLayer(sname, sprite.bmp,
							sprite.dx - _originX, sprite.dy - _originY, false);
				}
			}
		}
		file_total = n;
		if (pendingRedraw) redraw();
	}
	private var _character:Object = {};
	public function setCharacter(value:Object):void {
		_character = value;
	}
	public function redraw():void {
		if (file_total == 0 && ss_total == 0 && !loading) {
			reload();
		}
		pendingRedraw = true;
		if (ss_loaded != ss_total || file_loaded != file_total || (ss_total + file_total) == 0) {
			return;
		}
		pendingRedraw = false;
		
		
		// Mark visible layers
		composite.hideAll();
		parts.execute(new CharViewContext(this,_character));
		
		_palette.character   = _character;
		var bd:BitmapData    = composite.draw(_palette);
		var g:Graphics       = graphics;
		g.clear();
		g.beginBitmapFill(bd);
		g.drawRect(0, 0, _width, _height);
		g.endFill();
		this.scaleX = scale;
		this.scaleY = scale;
	}
	private function loadSpritemap(xml:XML, sm:XML):void {
		const filename:String = sm.@file;
		var path:String       = xml.@dir + filename;
		LOGGER.info('loading spritemap ' + path);
		CoCLoader.loadImage(path, function (success:Boolean, result:BitmapData, e:Event):void {
			if (!success) {
				LOGGER.error("Spritemap file not found: " + e);
				ss_loaded++;
				if (pendingRedraw) redraw();
				return;
			}
			for each (var cell:XML in sm.cell) {
				var rect:/*String*/Array = cell.@rect.toString().match(/^(\d+),(\d+),(\d+),(\d+)$/);
				var x:int                = rect ? int(rect[1]) : cell.@x;
				var y:int                = rect ? int(rect[2]) : cell.@y;
				var w:int                = rect ? int(rect[3]) : cell.@w;
				var h:int                = rect ? int(rect[4]) : cell.@h;
				var f:String             = cell.@name;
				var dx:int               = cell.@dx;
				var dy:int               = cell.@dy;
				var bd:BitmapData        = new BitmapData(w, h, true, 0);
				bd.copyPixels(result, new Rectangle(x, y, w, h), new Point(0, 0));
				sprites[f] = new CharViewSprite(bd, dx, dy);
			}
			ss_loaded++;
			if (ss_loaded == ss_total) loadLayers(xml);
		}, loaderLocation);
	}
	private function loadSpritesheet(xml:XML, ss:XML):void {
		const filename:String = ss.@file;
		const cellwidth:int   = ss.@cellwidth;
		const cellheight:int  = ss.@cellheight;
		var path:String       = xml.@dir + filename;
		LOGGER.info('loading spritesheet ' + path);
		CoCLoader.loadImage(path, function (success:Boolean, result:BitmapData, e:Event):void {
			if (!success) {
				LOGGER.error("Spritesheet file not found: " + e);
				ss_loaded++;
				if (pendingRedraw) redraw();
				return;
			}
			var y:int = 0;
			for each (var row:XML in ss.row) {
				var x:int                 = 0;
				var files:/*String*/Array = row.text().toString().split(",");
				for each (var f:String in files) {
					if (f) {
						var bd:BitmapData = new BitmapData(cellwidth, cellheight, true, 0);
						bd.copyPixels(result, new Rectangle(x, y, cellwidth, cellheight), new Point(0, 0));
						sprites[f] = new CharViewSprite(bd, 0, 0);
					}
					x += cellwidth;
				}
				y += cellheight;
			}
			ss_loaded++;
			if (ss_loaded == ss_total) loadLayers(xml);
		}, loaderLocation);
	}
	
}
}

