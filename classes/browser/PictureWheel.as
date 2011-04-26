package browser
{
	import flash.display.*;
    import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	import flash.filesystem.*;

	import flash.ui.Mouse;
	import flash.ui.Keyboard;

	import fl.motion.easing.*;
	
	import browser.*
	import browser.items.*



	public class PictureWheel extends StandardWheel
	{
    	// ---variables---
		
		
		
		// ---constructor---
      	
		public function PictureWheel(browserIn:Filebrowser, iconIn:WheelItem, typeIn:String)
   		{
	  		super(browserIn, iconIn, typeIn);
   	  	}
		
		override public function countFiles():void
		{
			for (var k:uint = 0; k < contents.length; k++)
			{
				if(contents[k].isDirectory)
				{
					itemCount++;
				}
				if(contents[k].extension == "JPG")
				{
					itemCount++;
				}
			}
			
			super.calculateAngles(itemCount);
		}
		
		override protected function displayItem(objectIn):void
		{
			if(contents[j].isDirectory)
			{
				var theIcon:StandardItem;
				var type:String = "PictureWheel";
				
				theIcon = new StandardItem(contents[j], type, null)
				theIcon.setWheel(this);
				
				j++;
				this.positioning(theIcon)
			}
			else if(contents[j].extension == "JPG")
			{
				var pictureIcon:PictureItem;
				
				pictureIcon = new PictureItem(contents[j])
				pictureIcon.setWheel(this);
				
				j++;
				this.positioning(pictureIcon)
			}
			else
			{
				j++;
				this.loadNextItem(objectIn);
			}
		}
	}
}
