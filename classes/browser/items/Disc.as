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

	
	
	public class Disc extends WheelItem
	{
  		// ---variables---
		
		protected var sprite:MovieClip = new MovieClip();
		
		protected var spriteTween:TweenMax;
		

		
		// ---constructor---
      	public function Disc(typeIn:String)
   		{
			super(null, typeIn);
   	  	}
		
		override protected function define(e:Event):void
		{
			super.define(e);

			this.addChild(sprite);
		}
 		
		
		
		// ---functions---
		
		override protected function createSprite():void
		{
			wid = main.getItemSize() * xRel;
			
			sprite.graphics.lineStyle(NaN);
			sprite.graphics.beginFill( main.getDiscColor() );
			sprite.graphics.drawCircle(wid/2, wid/2, wid/2);
			sprite.graphics.endFill();
		}
		
		override public function scaleItem(percentIn:Number, alphaIn:Number):void
		{
			var percent:Number = percentIn;
			var alphaVal = alphaIn;
			
			wid = main.getItemSize() * xRel;
			
			spriteTween = new TweenMax(sprite, 0.2, {width:wid/100 * percent, height:wid/100 * percent, x:(100/percent - 1), y:(100/percent - 1), alpha:alphaVal});
		}
		
		override public function select():void
		{
			super.select();
		}
		
		override public function reFresh():void
		{
			this.createSprite();
			
			super.reFresh();
		}
	}
}