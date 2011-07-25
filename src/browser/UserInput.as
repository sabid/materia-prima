package browser
{
	import flash.display.*;
    import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	import flash.ui.Mouse;
	import flash.ui.Keyboard;

	import fl.motion.easing.*;

	import flash.filesystem.*;



	public class UserInput extends MovieClip
	{
    	//---Variables---
		
		private var main;
		
		private var controlMode:int;
		
		private var activeObject:MovieClip;
		
		// We need these variables to allow simultanous key-events
		private var key;
		private var keys:Array;
		
		private var pressedKeys:Object = {};

        private var tDelay:uint = 1200;
        // private var tRepeat:uint = 1;
		private var tComplete:Boolean = true;

		private var dcDelay:uint = 80;
        private var repeat:uint = 10;
		private var secondClick:Boolean = false;
		
		private var timer:Timer;		
		
		
		
		// ---constructor---
      	public function UserInput(mainIn:Main)
   		{
	  		main = mainIn;
			
			controlMode = main.getControlMode();
						
			keys = new Array();
			
			this.addEventListener(Event.ADDED_TO_STAGE, define);
   	  	}
		
		function define(e):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, define);
			
			this.reFresh();
			
			// Erweiterter Mousekram ist in Version 1.15 zu finden, wird später wieder eingebaut

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
		}
		
		private function keyPressed(event:KeyboardEvent):void 
		{
			event.preventDefault();
			event.stopPropagation();
			event.stopImmediatePropagation();
		
			key = event.keyCode
			
			controlMode = main.getControlMode();
			
			if( pressedKeys[ key ] )
			{
				return;
			}
			
			pressedKeys[ key ] = 1;
			
			if(controlMode == 0)
			{
				tComplete = false;
				timer.reset();
				timer.start(); 
			}
			else
			{
				activeObject.keyDownEvent(event.keyCode);
			}
		}
		
		private function keyReleased(event:KeyboardEvent):void 
		{
			key = event.keyCode
			
			delete pressedKeys[ key ];

			if(controlMode == 0)
			{
				 if(tComplete == false)
				 {
					tComplete = true;
					timer.stop();
				 	activeObject.keyUpEvent(Keyboard.RIGHT);
				 }
			}
			else if(controlMode == 1)
			{
				 if(secondClick == false)
				 {
					secondClick = true;
					
					timer.reset();
					timer.start(); 
				 }
				 else
				 {
					secondClick = false;
					
					timer.stop();
				 	activeObject.keyUpEvent(Keyboard.ENTER);
				 }
			}
			else
			{
				activeObject.keyUpEvent(event.keyCode);
			}
		}

		private function timerHandler(e:TimerEvent):void
		{
			repeat--;
        }

        private function onTimerComplete(e:TimerEvent):void 
		{
			if(controlMode == 0)
			{
				tComplete = true;
				activeObject.keyUpEvent(Keyboard.ENTER);
			}
			else if(controlMode == 1)
			{
				secondClick = false;
				
				activeObject.keyUpEvent(Keyboard.RIGHT);
				
				timer.stop();
				timer.reset();
			}
        }
		
		public function setActiveObject(objectIn:MovieClip)
		{
			this.activeObject = objectIn;
		}
		
		public function getActiveObject()
		{
			return this.activeObject;
		}
		
		public function reFresh():void
		{
			this.controlMode = main.getControlMode();
			
			if(controlMode == 0)
			{
				timer = new Timer(tDelay, 1);
				timer.addEventListener(TimerEvent.TIMER, timerHandler);
            	timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			}
			if(controlMode == 1)
			{
				timer = new Timer(dcDelay, repeat);
				timer.addEventListener(TimerEvent.TIMER, timerHandler);
            	timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			}
			else if(controlMode == 4 || controlMode == 5)
			{
				Mouse.show();
				
//				stage.addEventListener(MouseEvent.MOUSE_DOWN, onPressEvent);
//				stage.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			}
			else
			{
				Mouse.hide();
			}
		}
	}
}
