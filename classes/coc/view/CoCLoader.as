/**
 * Coded by aimozg on 23.07.2017.
 */
package coc.view {
import classes.internals.LoggerFactory;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.describeType;
import flash.utils.setTimeout;

import mx.core.ByteArrayAsset;

import mx.logging.ILogger;

/**
 *
 */
public class CoCLoader {
	private static const LOGGER:ILogger = LoggerFactory.getLogger(CoCLoader);
	public function CoCLoader() {
	}
	// [path:String]=>String
	private static var TEXT_BUNDLE:Object  = {};

	[Embed(source="../../../res/model.xml", mimeType="application/octet-stream")]
	public static const BUNDLE_RES_MODEL_XML:Class;
	
	public static function bundleText(key:String,c:Class):void {
		if (c) TEXT_BUNDLE[key] = new c();
	}
	
	// [path:String]=>BitmapData
	private static var IMAGE_BUNDLE:Object = {};

//	[Embed(source="../../../res/char1.png", mimeType="image/png")]
//	public static const BUNDLE_RES_CHAR1_PNG:Class;

	[Embed(source="../../../res/charview/body.png", mimeType="image/png")]
	public static const BUNDLE_RES_CHARVIEW_BODY_PNG:Class;

	[Embed(source="../../../res/charview/extra.png", mimeType="image/png")]
	public static const BUNDLE_RES_CHARVIEW_EXTRA_PNG:Class;

	[Embed(source="../../../res/charview/hair.png", mimeType="image/png")]
	public static const BUNDLE_RES_CHARVIEW_HAIR_PNG:Class;

	[Embed(source="../../../res/charview/head.png", mimeType="image/png")]
	public static const BUNDLE_RES_CHARVIEW_HEAD_PNG:Class;

	[Embed(source="../../../res/charview/lewd.png", mimeType="image/png")]
	public static const BUNDLE_RES_CHARVIEW_LEWD_PNG:Class;

	[Embed(source="../../../res/charview/tails.png", mimeType="image/png")]
	public static const BUNDLE_RES_CHARVIEW_TAILS_PNG:Class;

	[Embed(source="../../../res/charview/wings.png", mimeType="image/png")]
	public static const BUNDLE_RES_CHARVIEW_WINGS_PNG:Class;
	
	public static function bundleImage(key:String, c:Class):void {
		var o:BitmapData = c ? ((new c() as Bitmap).bitmapData) : null;
		if (o) IMAGE_BUNDLE[key] = o;
	}
	/**
	 * @param path
	 * @param callback Function (success:Boollean, result:*,event:Event):*
	 * where result is String or Error
	 * @param location "external", "internal"
	 */
	public static function loadText(path:String, callback:Function, location:String = "external"):void {
		function orLocal(e:Event):void {
			if (path in TEXT_BUNDLE) {
				setTimeout(callback, 0,true, TEXT_BUNDLE[path], new Event("complete"));
			} else {
				setTimeout(callback, 0,false, null, e);
			}
		}
		if (path.indexOf("./") == 0) path = path.slice(2);
		switch (location) {
			case "internal":
				LOGGER.info("Loading "+path+" from embed");
				if (path == "res/model.xml")
				{
					var byteArray:ByteArrayAsset = new BUNDLE_RES_MODEL_XML() as ByteArrayAsset;
					var xmlString:String = byteArray.readUTFBytes(byteArray.length);
					TEXT_BUNDLE[path] = xmlString;
					setTimeout(callback, 0, true, xmlString, new Event("complete"));
				}
				else
				{
					orLocal(new ErrorEvent("error", false, false,
							"Internal resource " + path + "not found"));
				}
				break;
			case "external":
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, function (e:Event):void {
					try {
						LOGGER.info("Loaded external "+path);
						TEXT_BUNDLE[path] = loader.data;
					} catch (e:Error) {
						LOGGER.warn(e.name+" loading external "+path+": "+e.message);
						orLocal(new ErrorEvent("error",false,false,e.message));
						return;
					}
					callback(true, loader.data, e);
				});
				var req:URLRequest = new URLRequest(path);
				loader.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void {
					LOGGER.warn(e.type+" loading external "+path+": "+e.toString());
					orLocal(e);
				});
				try {
					loader.load(req);
				} catch (e:Error) {
					LOGGER.warn(e.name+" loading external "+path+": "+e.message);
					orLocal(new ErrorEvent("error",false,false,e.message));
				}
				break;
			default:
				throw new Error("Incorrect location " + location);
		}
		
	}
	/**
	 * @param path
	 * @param callback Function (success:Boollean, result:BitmapData, e:Event):*
	 * @param location "external", "internal"
	 */
	public static function loadImage(path:String, callback:Function, location:String = "external"):void {
		function orLocal(e:Event):void {
			if (path in IMAGE_BUNDLE) {
				setTimeout(callback, 0,true, IMAGE_BUNDLE[path], new Event("complete"));
			} else {
				setTimeout(callback, 0,false, null, e);
			}
		}
		if (path.indexOf("./") == 0) path = path.slice(2);
		switch (location) {
			case "internal":
				LOGGER.info('loading spritemap ' + path + " from embed");
				var spriteImage:Bitmap;
				var recognized:Boolean = false;
				switch(path)
				{
					case "res/charview/body.png":
						spriteImage = new BUNDLE_RES_CHARVIEW_BODY_PNG();
						recognized = true;
						break;
					case "res/charview/extra.png":
						spriteImage = new BUNDLE_RES_CHARVIEW_EXTRA_PNG();
						recognized = true;
						break;
					case "res/charview/hair.png":
						spriteImage = new BUNDLE_RES_CHARVIEW_HAIR_PNG();
						recognized = true;
						break;
					case "res/charview/head.png":
						spriteImage = new BUNDLE_RES_CHARVIEW_HEAD_PNG();
						recognized = true;
						break;
					case "res/charview/lewd.png":
						spriteImage = new BUNDLE_RES_CHARVIEW_LEWD_PNG();
						recognized = true;
						break;
					case "res/charview/tails.png":
						spriteImage = new BUNDLE_RES_CHARVIEW_TAILS_PNG();
						recognized = true;
						break;
					case "res/charview/wings.png":
						spriteImage = new BUNDLE_RES_CHARVIEW_WINGS_PNG();
						recognized = true;
						break;
					default:
						spriteImage = null;
						recognized = false;
						LOGGER.warn('Embedded spritemap ' + path + " not recognized");
						break;
				}
				if (recognized)
				{
					var spritemap:BitmapData = spriteImage.bitmapData;
					IMAGE_BUNDLE[path] = spritemap;
					setTimeout(callback, 0, true, spritemap, new Event("complete"));
				}
				else {
					orLocal(new ErrorEvent("error", false, false,
							"Internal resource " + path + "not found"));
				}
				break;
			case "external":
				var loader:Loader = new Loader();
				var cli:LoaderInfo = loader.contentLoaderInfo;
				cli.addEventListener(Event.COMPLETE, function (e:Event):void {
					var bmp:Bitmap = null;
					try {
						bmp = cli.content as Bitmap;
					} catch (e:Error) {
						LOGGER.warn(e.name+" loading external "+path+": "+e.message);
						orLocal(new ErrorEvent("error",false,false,e.message));
						return;
					}
					if (bmp) {
						LOGGER.info("Loaded external "+path);
						IMAGE_BUNDLE[path] = bmp.bitmapData;
						callback(true, bmp.bitmapData, e);
					} else {
						LOGGER.warn("Not found external "+path);
						callback(false, null, e);
					}
				});
				cli.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void {
					LOGGER.warn(e.type+" loading external "+path+": "+e.toString());
					orLocal(e);
				});
				try {
					loader.load(new URLRequest(path));
				} catch (e:Error) {
					LOGGER.warn(e.name+" loading external "+path+": "+e.message);
					orLocal(new ErrorEvent("error",false,false,e.message));
				}
				break;
			default:
				throw new Error("Incorrect location " + location);
		}
		
	}
	
	private static function bundleResources(CoCLoader:Class):void {
		var dt:XML           = describeType(CoCLoader);
		// <type name="coc.view::CoCLoader" ...
		var classname:String         = String(dt.@name);
		var extraPath:String   = "classes/";
		if (classname.indexOf('::')>=0) {
			var packageName:String = classname.split('::')[0];
			if (packageName) {
				extraPath += packageName.replace(/\./g, '/') + "/";
				// => extraPath = "classes/coc/view/"
			}
		}
		for each (var decl:XML in dt.variable.(@type == "Class")) {
			/*
			<variable name="BUNDLE_RES_MODEL_XML" type="Class">
				<metadata name="Embed">
					<arg key="source" value="../../../res/model.xml"/>
					<arg key="mimeType" value="application/octet-stream"/>
				</metadata>
			</variable>
			 */
			var name:String = decl.@name;
			var meta:XMLList = decl.metadata.(@name == "Embed");
			var src:String = meta.arg.(@key == "source").@value;
			var mime:String = meta.arg.(@key == "mimeType").@value;
			if (name && src) {
				var value:Class = CoCLoader[name];
				src = extraPath + src;
				// src = "classes/coc/view/../../../res/model.xml"
				while(true) {
					var src2:String = src.replace(/[^\/]+\/\.\.\//,'');
					// src  = "classes/coc/view/../../../res/model.xml"
					// src2 = "classes/coc/"+     "../../res/model.xml"
					if (src == src2) break;
					src = src2;
				}
				if (mime.indexOf('image/') == 0) {
					bundleImage(src, value);
				} else {
					bundleText(src, value);
				}
			}
		}
	}
	bundleResources(CoCLoader);
}
}
