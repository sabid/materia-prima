package browser.items.controls
{
	import flash.display.*;
    import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.geom.*;
	import flash.ui.Mouse;
	import flash.ui.Keyboard;

	import com.greensock.TweenMax;
	import com.greensock.OverwriteManager;
	
	import fl.motion.easing.*;

	import flash.filesystem.*;
	
	import browser.*;
	import browser.items.*;
	

	
	public class WheelOfChoice extends Wheel
	{
    	// ---variables---
		
		protected var vals:Array;
		
		private var itemSize:uint;
		
				
		
		// ---constructor---
		
      	public function WheelOfChoice(browserIn:Filebrowser, itemIn:WheelItem, typeIn:String, valsIn:Array):void
   		{
	  		vals = valsIn;
			
			super(browserIn, itemIn, typeIn);
   	  	}
		
		override protected function define(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, define);

			folder = this.parent as FolderObject;
			
			middleX = motherItem.x;
			middleY = motherItem.y;

			wheelRadius = main.getItemSize();
			
			this.focusedIndex = 0;
			
		}
		


		// ---functions---
		
		override public function listItems():void
		{
			this.itemCount = vals.length;

			this.calculateAngles(itemCount);
			this.displayChoices();
		}
		
		protected function displayChoices():void
		{
			for(var i:uint = 0; i < itemCount; i++)
			{
				var item:WheelItem;

				if(motherItem.getSwitchVar() == "iconColor" || motherItem.getSwitchVar() == "discColor")
				{
					item = new ColorItem("ColorItem", vals[i]);
				}
				else if(motherItem.getSwitchVar() == "itemSize")
				{
					item = new SizeItem("SizeItem", vals[i]);
				}
				else if(motherItem.getSwitchVar() == "fontSize")
				{
					item = new FontSizeItem("FontSizeItem", vals[i]);
				}
				else if(motherItem.getSwitchVar() == "controlMode")
				{
					item = new AbstractVarItem(null, "AbstractVarItem", vals[i]);
				}
				
				item.setWheel(this);
				this.positioning(item);
			}
		}
		
		override public function selfDestruct():void
		{
			super.selfDestruct();
		}
	}
}
