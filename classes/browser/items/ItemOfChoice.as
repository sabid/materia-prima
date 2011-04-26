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

	
	
	public class ItemOfChoice extends Disc
	{
  		// ---variables---
		
		protected var val:uint;
		
		protected var mother:ControlItem;
		
		
		
		// ---constructor---
      	public function ItemOfChoice(typeIn:String, valIn)
   		{
			super(typeIn);
			
			val = valIn;
			
			xRel = 0.5;
   	  	}
		
		override protected function define(e:Event):void
		{
			mother = ControlItem ( wheel.getMotherItem() );
			
			wid = main.getItemSize() * xRel;
			
			sprite.graphics.beginFill( main.getIconColor() );
			sprite.graphics.drawCircle(0, 0, wid/2);
			
			this.addChild(sprite);
			
			sprite.graphics.endFill();
		}
 		
		
		
		// ---functions---
		
		override protected function loadInfos():void
		{
			infos = null;
		}
		
		override public function released():void
		{
			mother.decisionMade(val);
			
			wheel.selfDestruct();
		}
		
		override public function select():void
		{
			mother.changeVal(val);

			super.select();
		}
		
		override public function reFresh():void
		{
		}
		
		override public function getInfoText():String
		{
			return "Diesen Wert verwenden."
		}
		
		override public function getName():String
		{
			return val.toString();
		}
	}
}