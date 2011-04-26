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

	import flash.filters.DropShadowFilter;
	
	import browser.items.controls.*;



	public class ControlItem extends StandardItem
	{
  		// ---variables---
		
		private var valsOut:Array;
		
		protected var sVar:String;
		
		
		
		// ---constructor---
		
      	public function ControlItem(xmlIn:XML, iconFileIn:File):void
   		{
			super(null, null, iconFileIn);
			
	  		this.infos = xmlIn;
		}
		
		override public function firstStart():void
		{
		}
		
		
		
		// ---functions---
		
		override protected function onLoadProgress(event:ProgressEvent) 
		{
		}
		
		override protected function onLoadComplete():void
		{
			this.loadComplete = true;
			// Schöner machen
			sprite.alpha = 1;
			
			wheel.loadNextItem(this.infos);
		}
		
		override public function released():void
		{
			type = this.infos.controlType;
			sVar = this.infos.switchVar;
			
			switch(type) 
			{
				case "WheelOfChoice": 
				
					var vals:XMLList = this.infos.vals.val;
					valsOut = new Array(vals.length);
					var index:uint = 0;
					
					for each (var val:String in vals)
					{
						valsOut[index++] = val;
					}
					
					filebrowser.openFolder(this);
					
				break;
				
				case "Switch" :
				
					if(this.askVal(sVar) == true)
					{
						// Icon durchstreichen !!!
						this.changeVal(false);
					}
					else
					{
						// Icon normal
						this.changeVal(true);
					}
					
				break;
				
				default :
				break;
			}
			
			
		}
		
		public function decisionMade(valIn)
		{
			filebrowser.setActiveObject(wheel);

			this.changeVal(valIn);
		}
		
		public function changeVal(valIn)
		{
			var newVal = valIn;
			
			if(this.infos.varLocation == "main")
			{
				main.changeConfig(sVar, newVal)
			}
			else if(this.infos.varLocation == "prog")
			{
				// suche config und schreibe was rein
			}
		}
		
		private function askVal(valIn)
		{
			var newVal = valIn;
			
			if(this.infos.varLocation == "main")
			{
				main.getVal(newVal);
			}
			else if(this.infos.varLocation == "prog")
			{
			}
		}
		
		public function getMain()
		{
			return this.main;
		}
		
		override public function getName():String
		{
			return this.infos.@NAME;
		}
		
		override public function getInfoText():String
		{
			return this.infos.infoText;
		}
		
		public function getValArray():Array
		{
			return this.valsOut;
		}
		
		public function getSwitchVar():String
		{
			return this.sVar;
		}
	}
}