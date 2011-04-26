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

	
	
	public class FontSizeItem extends ItemOfChoice
	{
  		// ---variables---
		
		
		
		
		// ---constructor---
      	public function FontSizeItem(typeIn:String, sizeIn:uint)
   		{
			super(typeIn, sizeIn);
   	  	}
		
		override protected function define(e:Event):void
		{
			mother = ControlItem ( wheel.getMotherItem() );
			
			wid = mother.getSize().x * xRel;
			
			sprite.graphics.lineStyle(2, main.getIconColor() );
			sprite.graphics.beginFill( main.getDiscColor() );
			sprite.graphics.drawCircle(0, 0, wid/2);
			this.addChild(sprite);
			sprite.graphics.endFill();
			
			var txt = filebrowser.addText( "A" );
			txt.changeFontSize(val*xRel);
			txt.x = 0-wid/2;
			txt.y = 0-wid/2;
			this.addChild(txt);
		}
 		
		
		
		// ---functions---
		
		override public function reFresh():void
		{
		}
		
		override public function getInfoText():String
		{
			return "Diese Schriftgröße verwenden."
		}
	}
}