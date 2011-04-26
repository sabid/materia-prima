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

	
	
	public class SizeItem extends ItemOfChoice
	{
  		// ---variables---
		
		
		
		
		// ---constructor---
      	public function SizeItem(typeIn:String, sizeIn:uint)
   		{
			super(typeIn, sizeIn);
   	  	}
		
		override protected function define(e:Event):void
		{
			mother = ControlItem ( wheel.getMotherItem() );
			
			wid = val * xRel;
			
			sprite.graphics.lineStyle(2, main.getIconColor() );
			sprite.graphics.beginFill( main.getDiscColor() );
			sprite.graphics.drawCircle(0, 0, wid/2);
			this.addChild(sprite);
			sprite.graphics.endFill();
		}
 		
		
		
		// ---functions---
		
		override public function reFresh():void
		{
		}
		
		override public function scaleItem(percentIn:Number, alphaIn:Number):void
		{
			var percent:Number = percentIn;
			var alphaVal = alphaIn;
			
			wid = val * xRel;
			
			spriteTween = new TweenMax(sprite, 0.2, {width:wid/100 * percent, height:wid/100 * percent, x:(100/percent - 1), y:(100/percent - 1), alpha:alphaVal});
		}
		
		override public function getInfoText():String
		{
			return "Diese Größe verwenden."
		}
	}
}