package browser
{
	import flash.text.*;
    import flash.display.*;
    import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.geom.*
	
	import flash.desktop.*;
	import flash.filesystem.*;
	
	

	public class Infobox extends MovieClip
	{
    	// ---variables---
		
  		private var filebrowser:Filebrowser;
		private var main:Main;
		
		private var infotext:ExtendedTextField;
		
		private var theWidth:int;
		private var theHeight:int;
		
		
		
		// ---constructor---
      	
		public function Infobox(browserIn:Filebrowser, xIn:int, yIn:int, widIn:int, heiIn:int):void
   		{
			this.filebrowser = browserIn;
			this.main = filebrowser.getMain();
			
			infotext = new ExtendedTextField(main);
			
			theWidth = widIn;
			theHeight = heiIn;

			this.x = xIn - theWidth/2;
			this.y = yIn - theHeight/2;
			
			this.addEventListener(Event.ADDED_TO_STAGE, define);
   	  	}
		
		public function define(e):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, define);
			
			this.addChild( infotext );
		}
		
		public function displayText(contentIn:String):void
		{
			infotext.x = 0;
			infotext.y = 0;
						
			infotext.width = this.theWidth;
			infotext.height = this.theHeight;
			
			infotext.autoSize = TextFieldAutoSize.NONE;
			infotext.wordWrap = true;
			
			infotext.add(contentIn);
		}
		
		public function setPosition(xIn:uint, yIn:uint):void
		{
			this.x = xIn - infotext.width/2;
			this.y = yIn - infotext.height/2;
		}
		
		public function reFresh():void
		{
			infotext.reFresh();
		}
	}
}
