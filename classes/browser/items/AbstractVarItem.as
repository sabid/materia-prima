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

	
	
	public class AbstractVarItem extends StandardItem
	{
  		// ---variables---
		
		protected var val:uint;
		
		protected var mother:ControlItem;
		
				
		
		// ---constructor---
		
      	public function AbstractVarItem(fileIn:File, typeIn:String, valIn:uint)
   		{
			super(fileIn, typeIn, null);

			val = valIn;
			
			xRel = 0.5;	
			yRel = 0.5;
   	  	}
		
		override protected function define(e:Event):void
		{
			mother = ControlItem ( wheel.getMotherItem() );

			iconFile = mother.getDir().resolvePath(val.toString()+".png");

			super.define(e);

//			circle.graphics.lineStyle(2, main.getIconColor() );
//			circle.graphics.beginFill( main.getDiscColor() );
//			circle.graphics.drawCircle(0, 0, size/2);
//			this.addChild(circle);
//			circle.graphics.endFill();
		}
 		
		
		
		// ---functions---
		
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