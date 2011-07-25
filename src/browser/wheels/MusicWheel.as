package browser.wheels
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



	public class MusicWheel extends StandardWheel
	{
    	// ---variables---
		
		
		
		// ---constructor---
      	
		public function MusicWheel(browserIn:Filebrowser, iconIn:WheelItem, typeIn:String)
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
				if(contents[k].extension == "mp3")
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
				var theIcon:AlbumItem;
				
				theIcon = new AlbumItem(contents[j], "MusicWheel")
				theIcon.setWheel(this);

				j++;
				this.positioning(theIcon)
			}
			else if(contents[j].extension == "mp3")
			{
				var musicItem:MusicItem;
				
				musicItem = new MusicItem(contents[j])
				musicItem.setWheel(this);
				
				j++;
				this.positioning(musicItem)
			}
			else
			{
				j++;
				this.loadNextItem(objectIn);
			}
		}
	}
}
