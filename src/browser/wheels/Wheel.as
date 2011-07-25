package browser.wheels
{
	import flash.display.*;
    import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.geom.*;
	import flash.ui.Mouse;
	import flash.ui.Keyboard;
	import flash.filesystem.*;

	import fl.motion.easing.*;

	import com.greensock.TweenMax;
	import com.greensock.OverwriteManager;

	import browser.*;
	import browser.items.*;
	import browser.text.ExtendedLabel;
	

	
	public class Wheel extends MovieClip
	{
    	// ---variables---
		
		// The mainclass and the filebrowser
		protected var main:Main;
		protected var filebrowser:Filebrowser;
		protected var folder:FolderObject;
		
		// The type of this wheel (standard, picture, color, etc)
		public var type:String;
		
		protected var motherItem;
		
		// Number of objects in the folder. Will be used to calculate angles
		protected var itemCount:uint;
		
		// Variables to calculate the angles between the icons
		protected var wheelRadius:Number;
		protected var radius:Number;
		protected var radiusTxt:Number;
		private var degree:Number;
		// These variables will contain the center coordinates of the stage
		protected var middleX:uint;
		protected var middleY:uint;
		
		// index of the selected menu item
		protected var focusedIndex:int;
		
				
		
		// ---constructor---
		
      	public function Wheel(browserIn:Filebrowser, itemIn:WheelItem, typeIn:String)
   		{
	  		filebrowser = browserIn;
			main = filebrowser.getMain();

			this.motherItem = itemIn;
			type = typeIn;
			
			this.addEventListener(Event.ADDED_TO_STAGE, define);
   	  	}
		
		protected function define(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, define);
			
			folder = this.parent as FolderObject;

			focusedIndex = 0;
			
			middleX = stage.stageWidth/2;
			middleY = stage.stageHeight/2;
			wheelRadius = stage.stageHeight/4;
		}
		
		
		
		// ---functions---
		
		public function listItems():void
		{
		}
		
		public function calculateAngles(count)
		{
			degree = 180; // degree is set to 180, so the first icon of the wheel is the left one
			
			radius = wheelRadius + (wheelRadius/50)*count;
			
			
			radiusTxt = main.getItemSize() + (main.getItemSize()/50)*count;
			
			if(radius > (middleY - main.getItemSize()) )
			{
				radius = (middleY - main.getItemSize());
			}
		}
		
		// Calculate position for the item
		protected function positioning(itemIn)
		{
			var theItem = itemIn;
			
			degree += 360/(itemCount);
			
			var radians = degree * (Math.PI/180);
					
			theItem.x = middleX + Math.cos(radians) * radius - theItem.getSize().x/2;
			theItem.y = middleY + Math.sin(radians) * radius - theItem.getSize().y/2; 
			
			this.addChild(theItem);
			folder.currentFiles.push(theItem);
		}
		
		//overridden
		public function loadNextItem(objectIn):void
		{
			
		}
		
		public function keyDownEvent(commandIn:Number)
		{
			var command = commandIn;
			
			switch(command) 
			{
				case Keyboard.ENTER :
					this.pressSelected();
				break;
					
				default :
				break;
			}
		}
		
		public function keyUpEvent(commandIn:Number)
		{
			var command = commandIn;
			
			switch(command) 
			{
				case Keyboard.LEFT :
					this.select(this.getItem(-1));
				break;
					
				case Keyboard.RIGHT :
					this.select(this.getItem(1));
				break;
			
				case Keyboard.ENTER :
					this.chooseSelected();
				break;
					
				case Keyboard.TAB :
					this.select(this.getItem(1));
				break;
					
				case Keyboard.ESCAPE :
					//this.select(exit);
				break;
					
				default :
				break;
			}
		}
		
		public function getItem(itemDelta)
		{
    		if(itemDelta < 0)
			{
				if(focusedIndex + itemDelta < 0)
				{
					return(folder.currentFiles[folder.currentFiles.length + (itemDelta+focusedIndex)]);
				}
				else
				{
					return(folder.currentFiles[focusedIndex + itemDelta]);
				}
			}
			else
			{			
				if(focusedIndex + itemDelta > folder.currentFiles.length-1)
				{
					return(folder.currentFiles[itemDelta - (folder.currentFiles.length - focusedIndex)]);
				}
				else
				{
					return(folder.currentFiles[focusedIndex + itemDelta]);
				}
			}
		}
	
		public function select(itemIn:WheelItem)
		{
			var item = itemIn;
			
			this.deselectLast();
			
			
			this.focusedIndex = folder.currentFiles.indexOf(item);
			
			var topPosition:uint = this.numChildren - 1;
			
			for(var item1 = 1; item1 < focusedIndex; item1++)
			{
				this.setChildIndex(folder.currentFiles[item1], topPosition);
			}
			for(var item2 = folder.currentFiles.length-1; item2 > focusedIndex-1; item2--)
			{
				this.setChildIndex(folder.currentFiles[item2], topPosition);
			}
			
			this.setChildIndex(folder.currentFiles[0], topPosition);
			
			item.scaleItem(125, 0.99);
			item.scaleShadow(0.99, 20, main.getYesColor());
			item.select();
			
			filebrowser.showInformation(item, middleX, middleY);
			
			
//			for(var de:int = 0; de < folder.currentFiles.length-1; de++)
//			{
//				var object = folder.currentFiles[de];
//				
//				if(object != item)
//				{
//					if(object.getSelect() == true)
//					{
//						this.deselect(object);
//					}
//				}
//			}
			
			filebrowser.setCrntItem(item);
		}
		
		public function deselectLast()
		{
			if(filebrowser.getCrntItem() != null)
			{
				this.deselect(filebrowser.getCrntItem() )
			}
		}
		
		public function deselect(itemIn:WheelItem)
		{
			var item = itemIn;
			
			item.scaleItem(100, 0.99);
			item.scaleShadow(0.85, 15, 000000);
			item.deselect();
		}
		
		public function pressSelected():void
		{
			folder.currentFiles[focusedIndex].pressed();
		}
		
		public function chooseSelected():void
		{
			folder.currentFiles[focusedIndex].released();
		}
		
		// empty
		public function reFresh()
		{
			
		}
		
		public function getFilebrowser():Filebrowser
		{
			return this.filebrowser;
		}
		
		public function getCenter():Point
		{
			return new Point(middleX, middleY);
		}
		
		public function getRadius():int
		{
			return this.wheelRadius;
		}
		
		public function getMotherItem():WheelItem
		{
			return this.motherItem;
		}
		
		public function setMotherItem(itemIn):void
		{
			this.motherItem = itemIn;
		}

		public function setDir(dirIn:File):void
		{
		}
		
//		public function setCenter(centerIn:Point):void
//		{
//			middleX = centerIn.x;
//			middleY = centerIn.y;
//		}
		
		public function selfDestruct():void
		{
			for(var search = this.numChildren; search < 0; search--)
			{
				this.removeChild(this.getChildAt(search));
			}
				
			parent.removeChild(this);
		}
	}
}
