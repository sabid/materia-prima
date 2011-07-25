package browser.text
{
	import flash.display.*;
	
	import flash.text.*;
    
	import flash.events.Event;
	
	import browser.Filebrowser;
	
	
	
	import com.flashartofwar.fcss.applicators.StyleApplicator;
	import com.flashartofwar.fcss.applicators.TextFieldApplicator;
	import com.flashartofwar.fcss.factories.TextFieldFactory;
	import com.flashartofwar.fcss.managers.SingletonManager;
	import com.flashartofwar.fcss.styles.IStyle;
	import com.flashartofwar.fcss.stylesheets.FStyleSheet;
	import com.flashartofwar.fcss.stylesheets.IStyleSheet;
	import com.flashartofwar.fcss.stylesheets.IStyleSheetCollection;
	import com.flashartofwar.fcss.stylesheets.StyleSheetCollection;
	
	//[Embed(source = 'G:/000 Bachelorarbeit/materia prima 0.1/system/fonts/FrutigerLTStd-Roman.otf', fontName = 'FrutigerRoman', fontFamily = 'Frutiger', mimeType="application/x-font")] 
	//public static var FrutigerRoman:Class;
	//Font.registerFont(FrutigerRoman);

	public class Infobox extends MovieClip
	{
    	// ---variables---
		
  		private var filebrowser:Filebrowser;
		private var main:Main;
		
		private var tff:TextFieldFactory;
		private var infotext:TextField;
		
		private var theWidth:int;
		private var theHeight:int;
		
		
		
		// ---constructor---
      	
		public function Infobox(browserIn:Filebrowser, xIn:int, yIn:int, widIn:int, heiIn:int):void
   		{
			this.filebrowser = browserIn;
			this.main = filebrowser.getMain();
			
			
			infotext = new TextField();
			
			
			theWidth = widIn * 1.45;
			theHeight = heiIn * 1.45;

			this.x = xIn - theWidth/2;
			this.y = yIn - theHeight/2;
			
			this.addEventListener(Event.ADDED_TO_STAGE, define);
   	  	}
		
		private function define(e):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, define);
			
			this.prepareStyleSheetStuff();
		}
		
		
		
		
		
		private function prepareStyleSheetStuff():void
		{
			var styleSheet:IStyleSheet = main.getStyleSheet();
			var style:IStyle = styleSheet.getStyle(".TextField", "#demoStyle2");
			
			var tfApplicator:TextFieldApplicator = new TextFieldApplicator();
			tfApplicator.applyStyle(infotext, style);
			
			var styleSheetCollection:IStyleSheetCollection = SingletonManager.getClassReference(StyleSheetCollection) as IStyleSheetCollection;
			styleSheetCollection.addStyleSheet(styleSheet, "defaultSheet");
			
			tff = new TextFieldFactory(tfApplicator, styleSheetCollection);
			
			this.setupTextField();
		}

		private function setupTextField():void
		{
			infotext = tff.createTextField("demoInlineStyleSheet");
			
			infotext.mouseEnabled = false;
			infotext.selectable = false;
			//this.embedFonts = true;
			infotext.antiAliasType = AntiAliasType.ADVANCED;
			infotext.wordWrap = true;	
			
			this.addChild( infotext );
		}
		
		public function displayText(contentIn:String):void
		{
			infotext.x = 0;
			infotext.y = 0;
						
			infotext.width = this.theWidth;
			infotext.height = this.theHeight;
			
			//infotext.autoSize = TextFieldAutoSize.NONE;
			//infotext.wordWrap = true;
			
			infotext.htmlText = contentIn;
			
			//infotext.add(contentIn);
		}
		
		public function setPosition(xIn:uint, yIn:uint):void
		{
			this.x = xIn - infotext.width/2;
			this.y = yIn - infotext.height/2;
		}
		
		public function changeFontColor(colorIn:uint):void
		{
			//this.styleSheet = main.getStyle();
			
		}
		
		public function changeFontSize(sizeIn:int):void
		{
			//this.styleSheet = main.getStyle();
			
		}
		public function reFresh():void
		{
			//infotext.reFresh();
		}
	}
}
