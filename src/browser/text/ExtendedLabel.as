package browser.text
{
	import flash.display.*;
	
	import flash.events.Event;
	
	import flash.text.*;

	import fl.controls.Label;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import flash.geom.Point;
	//import mx.controls.Text;
	
	
	
	public class ExtendedLabel extends Label
	{
    	// ---variables---
		
		private var main:Main;
		
        private var format:TextFormat;
		
		private var metrics:TextLineMetrics;
		
		private var auto:Boolean = true;
       	
		
		public var xPos:int;
		public var yPos:int;
		
		
		// ---constructor---
      	
		public function ExtendedLabel(mainIn:Main)
   		{
			main = mainIn;
			
			format = new TextFormat();
			format.font = "Frutiger LT Std 55 Roman";
			format.color = main.getIconColor();
			format.size = main.getFontSize();
			
			//var dyno:Text = new Text();
			
			this.addEventListener(Event.ADDED_TO_STAGE, define);
   	  	}
		
		private function define(e)
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, define);
			
			//this.editable = false;
			
			this.textField.embedFonts = true;
			this.textField.selectable = false;
			this.textField.mouseEnabled = false;
			this.textField.antiAliasType = AntiAliasType.ADVANCED;
			this.textField.wordWrap = false;
			
			this.setStyle("embedFonts", true);
			this.setStyle("textFormat", format);
		}
		
		public function add(contentIn:String):void
		{
			this.textField.text = contentIn;
			
			this.reFresh();
		}
		
		public function changeFontColor(colorIn:uint):void
		{
			format.color = colorIn;
			
			this.setStyle("embedFonts", true);
			this.setStyle("textFormat", format);
		}
		
		public function changeFontSize(sizeIn:int):void
		{
			format.size = sizeIn;
			
			this.setStyle("embedFonts", true);
			this.setStyle("textFormat", format);
		}
		
		public function reFresh():void
		{
			format.font = "Frutiger LT Std 55 Roman";
			format.color = main.getIconColor();
			format.size = main.getFontSize();
			
			this.x = xPos-this.width/2;
			this.y = yPos-this.height/2;
			
			if(this.xPos > 0)
			{
				this.textField.autoSize = TextFieldAutoSize.LEFT;
			}
			else
			{
				this.textField.autoSize = TextFieldAutoSize.RIGHT;				
			}

			
			this.setStyle("embedFonts", true);
			this.setStyle("textFormat", format);
			
			//if(auto == true)
			//{
				//this.autosize();
			//}
		}
		
/*		private function autosize():void
		{
			this.textField.autoSize = TextFieldAutoSize.CENTER;
			metrics = this.textField.getLineMetrics(0);
			
			var labelWid = this.textField.getBounds(textField.parent).x
			var labelHei = this.textField.textHeight + 4;
			
			var bg = new Sprite();
			bg.graphics.lineStyle(NaN);
			bg.graphics.beginFill(0x555555, 0.5);
			bg.graphics.drawRect(0,0, labelWid, labelHei);
			this.addChild(bg);
			bg.graphics.endFill();
			
			this.width = labelWid;
			this.height = labelHei;
		}
		
		public static function getTextFieldBounds( textfield:TextField ):Rectangle
		{
			const margin:int = 35;
			
			const filtersList:Array = cloneFilters(textfield);			
			textfield.filters = [];
			
			const hasBorder:Boolean = textfield.border;
			textfield.border = false;
			
			const hasBackground:Boolean = textfield.background;
			textfield.background = false;
			
			const bitmapdata:BitmapData = new BitmapData(textfield.width + (margin * 2), textfield.height + (margin * 2), true, 0);
			
			const matrix:Matrix = textfield.transform.matrix.clone();
			matrix.tx = margin;
			matrix.ty = margin;		
			
			bitmapdata.draw(textfield, matrix);
			
			var retval:Rectangle = bitmapdata.getColorBoundsRect(0xFFFFFFFF, 0x000000, false);			
			
			retval.x += textfield.x - margin;
			retval.y += textfield.y - margin;
			
			textfield.filters = filtersList;
			
			textfield.border = hasBorder;
			textfield.background = hasBackground;			
			
			return retval;
		}
		
		private static function cloneFilters(obj:DisplayObject):Array
		{
			var retval:Array = [];
			
			for (var i:uint = 0; i < obj.filters.length; ++i) 
			{
				retval.push( obj.filters[i] );
			}
			
			return retval;
		}
		
		
		
		public function setAutosize(boolIn:Boolean):void
		{
			this.auto = boolIn;
		}
*/
		
		public function setXPos(xPosIn:int):void
		{
			this.xPos = xPosIn;
		}
		
		public function setYPos(yPosIn:int):void
		{
			this.yPos = yPosIn;
		}
		
	}
}
