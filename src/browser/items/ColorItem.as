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

	
	
	public class ColorItem extends ItemOfChoice
	{
  		// ---variables---
		
		private var iconColor:uint;
		
		
		
		// ---constructor---
      	public function ColorItem(typeIn:String, colorIn:uint)
   		{
			super(typeIn, colorIn);
   	  	}
		
		override protected function define(e:Event):void
		{
			mother = ControlItem ( wheel.getMotherItem() );
			
			wid = main.getItemSize() * xRel;
			
			iconColor = main.getIconColor();
			
			sprite.graphics.lineStyle(2, main.getIconColor() );
			// circle.color = color;
			sprite.graphics.beginFill( val );
			sprite.graphics.drawCircle(0, 0, wid/2);
			this.addChild(sprite);
			sprite.graphics.endFill();
		}
 		
		
		
		// ---functions---
		
		override public function getInfoText():String
		{
			return "Diese Farbe verwenden."
		}
	}
}