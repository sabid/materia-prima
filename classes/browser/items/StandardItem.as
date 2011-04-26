package browser.items
{
	import flash.display.*;
    import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.filesystem.*;
	
	import fl.transitions.*;	
	import com.greensock.TweenMax;
	import com.greensock.OverwriteManager;
	import com.greensock.plugins.*;

	import fl.motion.easing.*;

	import flash.filters.DropShadowFilter;

	
	
	public class StandardItem extends LoadingItem
	{
  		// ---variables---
		
		// The "Disc" on which the icons are placed
		protected var sprite:Sprite = new Sprite();
		protected var spriteTween:TweenMax;
		
		protected var sWid:int;
		protected var sHei:int;
		
		private var loops:int = 0;
		
		
		
		// ---constructor---
      	public function StandardItem(fileIn:File, typeIn:String, iconIn:File)
   		{
			iconFile = iconIn;
			
			super(fileIn, typeIn);
   	  	}
		
		override protected function define(event:Event):void
		{
			if(iconFile == null)
			{
				iconFile = new File();
				
				if(dir.resolvePath(dir.name+".png").exists)
				{
					iconFile = dir.resolvePath(dir.name+".png");

				}
				else
				{
					iconFile = File.applicationDirectory;
					iconFile = iconFile.resolvePath("system/icons/folder.png");
				}
			}
			
			if(infoFile != null && infoFile.exists)
			{
				loops++;
			}
			if(audioFile != null && audioFile.exists)
			{
				loops++;
			}
			if(iconFile != null && iconFile.exists)
			{
				loops++;
			}
			
			super.define(event);
		}
 		
		
		
		// ---functions---
		
		override protected function createSprite():void
		{
			this.drawSprite();
			
			sprite.alpha = 0;
			this.addChild(sprite);
		}
		
		protected function drawSprite():void
		{
			sprite.graphics.clear();
			sprite.graphics.lineStyle(NaN);
			sprite.graphics.beginFill( main.getDiscColor() );
			sprite.graphics.drawCircle(0, 0, wid/2);
			
			sprite.alpha = 1;
			
			sWid = wid;
			sHei = hei;
		}
		
		override protected function onLoadProgress(event:ProgressEvent)
		{
			sprite.alpha = ( super.onLoadProgress(event) / (100) ) / loops;
		}
		
		override protected function onLoadComplete():void
		{
			sprite.alpha = 1;
			
			super.onLoadComplete();
		}
		
		override public function scaleItem(percentIn:Number, alphaIn:Number):void
		{
			var percent:Number = percentIn;
			var alphaVal = alphaIn;
			
			spriteTween = new TweenMax(sprite, 0.5, {width:sWid/100 * percent, height: sHei/100 * percent, x: 0, y: 0, alpha:alphaVal});

			super.scaleItem(percent, alphaVal);
		}
		
		override public function bigBoy():void
		{
			super.bigBoy();
			
			sprite.graphics.clear();
		}
		
		override public function reFresh():void
		{
			super.reFresh();

			this.drawSprite();
		}
	}
}