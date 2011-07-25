package browser.items
{
	import flash.display.*;
    import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.filesystem.*;
	import flash.geom.*;
	
	import flash.media.*;
	
	import fl.transitions.*;	
	import com.greensock.TweenMax;
	import com.greensock.OverwriteManager;
	import com.greensock.plugins.*;

	import fl.motion.easing.*;



	public class MusicItem extends StandardItem
	{
  		// ---variables---
		
		private var pPoint:Number =0.00;
		private var isPlaying:Boolean = false;
		
		
		
		// ---constructor---
		
      	public function MusicItem(fileIn:File)
   		{
			super(fileIn, "MusicWheel", null);
   	  	}
		
		override protected function define(event:Event):void
		{
			iconFile = File.applicationDirectory;
			iconFile = iconFile.resolvePath("system/icons/audiofile.png");
					
			if(audioFile == null)
			{
				audioFile = dir;
			}
			
			super.define(event);
		}
 
 
 
		// ---functions---



		override protected function audioLoadComplete(event:Event):void
		{
			super.audioLoadComplete(event);
		}
		
		override public function select():void
		{
			if(sel == true)
			{
				return;
			}
			
			sel = true;
			
			channel1.stop();
			
			if(audio.bytesTotal > 0)
			{
				channel1 = audio.play(0);
				isPlaying = true;
			}
		}
		
		override public function deselect():void
		{
			sel = false;
			
			pPoint = 0.00;
			channel1.stop();
			isPlaying = false;
		}
		
		override public function released():void
		{
			if (isPlaying == true)
			{
				pPoint = channel1.position;
				channel1.stop();
				isPlaying = false;
			}
			else
			{
				channel1 = audio.play(pPoint);
				isPlaying = true;
			}
		}
		
		override public function getInfoText():String
		{
			return "\n\n\n\n\n\n\n\nKünstler: " + id3Tag.artist + "\nAlbum: "+ id3Tag.album  + "\nSong: " + id3Tag.songName;
		}
	}
}