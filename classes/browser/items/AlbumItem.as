package browser.items
{
	import flash.display.*;
    import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.filesystem.*;
	import flash.geom.*;
	
	import fl.transitions.*;	
	import com.greensock.TweenMax;
	import com.greensock.OverwriteManager;
	import com.greensock.plugins.*;

	import fl.motion.easing.*;



	public class AlbumItem extends StandardItem
	{
  		// ---variables---
		
		private var bmd:BitmapData;
		private var smallBMD:BitmapData;
		
				
		
		// ---constructor---
		
      	public function AlbumItem(fileIn:File, typeIn)
		{
			iconFile = new File;
			iconFile = iconFile.resolvePath(fileIn.url + "/folder.jpg");
			
			iconLoader = new Bitmap();
			
//			if(iconFile.exists == false)
//			{
//				iconFile = new File;
//				fileIn.getDirectoryListingAsync();
//				fileIn.addEventListener(FileListEvent.DIRECTORY_LISTING, searchJPG, false, 0, true);
//			}

			if(iconFile.exists == false)
			{
				iconFile = File.applicationDirectory;
				iconFile = iconFile.resolvePath("system/icons/music.png");
			}
			
			super(fileIn, typeIn, iconFile);
   	  	}
		
//		public function searchJPG(event:FileListEvent):void
//		{
//			event.currentTarget.removeEventListener(FileListEvent.DIRECTORY_LISTING, searchJPG);
//			
//			var contents:Array = event.files;
//			
//			for(var sj:int = 0; sj < contents.length; sj++)
//			{
//				if(contents[sj].extension == ".jpg")
//				{
//					iconFile = contents[sj];
//				}
//			}
//			trace("search " + iconFile.url);
//			if(iconFile.exists == false)
//			{
//				iconFile = File.applicationDirectory;
//				iconFile = iconFile.resolvePath("system/icons/music.png");
//			}
//		}
		
		override protected function define(event:Event):void
		{
			xRel = 1.3;
			yRel = 1.3;
			
			wid = main.getItemSize() * xRel;
			hei = main.getItemSize() * yRel;
			
			super.define(event);
		}
 
 
 
		// ---functions---

		override protected function createSprite():void
		{
			this.drawSprite();
			
			sprite.alpha = 0;

			this.addChild(sprite);
		}
		
		override protected function drawSprite():void
		{
			var linethick:int = wid/20;
			
			var matrix:Matrix = new Matrix();
            matrix.createGradientBox( (wid+linethick), (hei+linethick), 90/(180/Math.PI), (-wid/2)-linethick/2, (-hei/2)-linethick/2 );
            sprite.graphics.beginGradientFill(GradientType.LINEAR, [0xeeeeee, 0xffffff, 0xcdcdcd], [0.8, 0, 0.4], [0x00, 0x88, 0xFF], matrix );
			sprite.graphics.lineStyle(1, 0x6f6f6f);
			sprite.graphics.drawRect( (-wid-linethick)/2, (-hei-linethick)/2, wid+linethick, hei+linethick );
			
			
			
			var sidethick = wid/10;
			
			sprite.graphics.beginGradientFill(GradientType.LINEAR, [0xeeeeee, 0xffffff, 0xcdcdcd], [0.8, 0, 0.4], [0x00, 0x88, 0xFF], matrix );
			sprite.graphics.drawRect( ((-wid)/2) - (sidethick + 1.5*linethick), (-hei-linethick)/2, sidethick + linethick, hei+linethick );
			
			var sidematrix:Matrix = new Matrix();
            sidematrix.createGradientBox( (wid), (hei), (-30)/(180/Math.PI), (-wid/2), (-hei/2) );
            sprite.graphics.beginGradientFill(GradientType.LINEAR, [0x333333, 0x111111], [0.2, 0.5], [0x00, 0xFF], sidematrix );
			sprite.graphics.lineStyle(NaN);
			sprite.graphics.drawRect(  ( (-wid)/2) - (sidethick+linethick), (-hei)/2, sidethick, hei );
			
			sWid = sprite.width;
			sHei = sprite.height;
		}
		
		override protected function iconLoadingComplete(e:Event):void
		{
			bmd = Bitmap(LoaderInfo(e.target).content).bitmapData;

			var scale:Number = wid/bmd.width;
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);
			
			smallBMD = new BitmapData(wid, hei, true, 0x000000);
			smallBMD.draw(bmd, matrix, null, null, null, true);
			
			iconLoader = new Bitmap(smallBMD, PixelSnapping.NEVER, true);
			iconLoader.x = -wid/2;
			iconLoader.y = -hei/2;
			
			sprite.alpha = 1;

			this.addChild(iconLoader);
			
			this.onLoadComplete();
		}
	}
}