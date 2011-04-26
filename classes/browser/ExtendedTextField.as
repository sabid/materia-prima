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
	
	
	// Later this solution will be replaced by embedded fonts, maybe made with flex
	public class ExtendedTextField extends TextField
	{
    	// ---variables---
		
		private var main:Main;
		
        private var format:TextFormat;
		
		private var metrics:TextLineMetrics;
		
		private var auto:Boolean = true;
            
		
		
		// ---constructor---
      	
		public function ExtendedTextField(mainIn:Main)
   		{
			main = mainIn;
			
			format = new TextFormat();
			format.font = "Frutiger LT Std 55 Roman";
			format.color = main.getIconColor();
			format.size = main.getFontSize();
			
			this.addEventListener(Event.ADDED_TO_STAGE, define);
   	  	}
		
		private function define(e)
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, define);
			
			this.embedFonts = true;
			this.selectable = false;
			this.mouseEnabled = false;
			this.antiAliasType = AntiAliasType.ADVANCED;
			this.autoSize = TextFieldAutoSize.LEFT;
			this.wordWrap = false;
			
			this.defaultTextFormat = format;
			this.setTextFormat(format);
		}
		
		public function add(contentIn:String):void
		{
			this.text = contentIn;
			
			this.reFresh();
		}
		
		public function changeFontColor(colorIn:uint):void
		{
			format.color = colorIn;
			
			this.defaultTextFormat = format;
			this.setTextFormat(format);
		}
		
		public function changeFontSize(sizeIn:int):void
		{
			format.size = sizeIn;
			
			this.defaultTextFormat = format;
			this.setTextFormat(format);
		}
		
		public function reFresh():void
		{
			format.font = "Frutiger LT Std 55 Roman";
			format.color = main.getIconColor();
			format.size = main.getFontSize();
						
			this.defaultTextFormat = format;
			this.setTextFormat(format);
			
			if(auto == true)
			{
				this.autosize();
			}
		}
		
		private function autosize():void
		{
			metrics = this.getLineMetrics(0);
			this.width =  metrics.width + 100;
		}
		
		public function setAutosize(boolIn:Boolean):void
		{
			this.auto = boolIn;
		}
	}
}
