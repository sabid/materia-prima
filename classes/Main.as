package
{
	import flash.display.*;
    import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.geom.*
	
	import flash.desktop.*;
	import flash.filesystem.*;
	
	import browser.*;
	
	
	
	public class Main extends MovieClip
	{
    	// ---variables---
		private var window:NativeWindow;
		
		private var dir:File;
		private var file:File;
		
		private var configLoader:URLLoader;
		private var config:XML;
		
		private var currentUser:String = "default";
		
		private var theBrowser:Filebrowser;
		
		// private var winDisplayStateTimer:Timer;
		
		
		
		// ---constructor---
      	public function Main():void
   		{
	  		dir = File.applicationDirectory;

			this.addEventListener(Event.ADDED_TO_STAGE, define);
   	  	}
		
		private function define(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, define);
			
			this.loadConfig();
		}

 
		// ---functions---
		
		private function loadConfig():void
		{
			
			var file:File = new File;
//			file = new File("app-storage:/configuration.xml");
//			
//			if(file.exists == false)
//			{
//				file = dir.resolvePath("system/configuration.xml");
//			}
			
			file = dir.resolvePath("system/configuration.xml");

			configLoader = new URLLoader()
			configLoader.addEventListener(Event.COMPLETE, configLoaded);
			configLoader.load(new URLRequest(file.url));
		}
		
		private function configLoaded(e:Event):void
		{
			config = new XML(e.target.data);
			config.ignoreWhite=true;
			
			this.createNativeWindow();
			this.displayBrowser();
		}
		
		private function createNativeWindow():void 
		{
			window = this.stage.nativeWindow;

			window.title = "Materia Prima";
			
			window.maximize();
			window.stage.align = StageAlign.TOP_LEFT; 
			window.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
//			winDisplayStateTimer=new Timer(0);
//			winDisplayStateTimer.delay=2000;
//			winDisplayStateTimer.addEventListener(TimerEvent.TIMER,onWinDisplayStateTimerTick);
//			winDisplayStateTimer.start();
		}
		
//		private function onWinDisplayStateTimerTick(evt:TimerEvent):void
//		{
//        	if(stage.displayState != StageDisplayState.FULL_SCREEN_INTERACTIVE)
//			{
//           		stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
//			}
//        }
		 
		private function displayBrowser():void
		{
			theBrowser = new Filebrowser(this, dir.resolvePath("system/Haus"));
			
			this.addChild(theBrowser);
			theBrowser.reFresh();
		}
		
		public function getDifficulty():int
		{
			return config.USER.(@NAME==this.currentUser).difficulty;
		}
		
		public function getControlMode():int
		{
			return config.USER.(@NAME==this.currentUser).controlMode;
		}
		
		public function getFontSize():int
		{
			return config.USER.(@NAME==this.currentUser).fontSize;
		}
		
		
		public function getItemSize():int
		{
			return config.USER.(@NAME==this.currentUser).itemSize;
		}
		
		public function getIconColor():uint
		{
			return config.USER.(@NAME==this.currentUser).iconColor;
		}
		
		public function getDiscColor():uint
		{
			return config.USER.(@NAME==this.currentUser).discColor;
		}
		
		public function getYesColor():uint
		{
			return config.USER.(@NAME=="default").yesColor;
		}
		
		public function getNoColor():uint
		{
			return config.USER.(@NAME=="default").noColor;
		}
		
		public function getUpColor():uint
		{
			return config.USER.(@NAME=="default").upColor;
		}
		
		public function getDownColor():uint
		{
			return config.USER.(@NAME=="default").downColor;
		}
		
		public function getLeftColor():uint
		{
			return config.USER.(@NAME=="default").leftColor;
		}
		
		public function getRightColor():uint
		{
			return config.USER.(@NAME=="default").rightColor;
		}
		
		public function getWindowSize():Point
		{
			return new Point(config.USER.(@NAME=="default").windowX, config.USER.(@NAME=="default").windowY);
		}
		
		public function getVal(varIn)
		{
			var user = config.USER.(@NAME==this.currentUser);
			
			var myArray:Array = [{xmlNodeName:varIn}];

            for each (var item:Object in myArray)
            {
            	return user[item.xmlNodeName];
            }
		}
		
		public function changeConfig(varIn:String, valIn:String):void
		{
			var user = config.USER.(@NAME==this.currentUser);
			
			var myArray:Array = [{xmlNodeName:varIn, value:valIn}];

            for each (var item:Object in myArray)
            {
            	user[item.xmlNodeName] = item.value.toString();
            }
			
			theBrowser.reFresh();
		}

		public function applicationExit():void
		{ 
			var newXMLStr:String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + config.toXMLString();
			
			var file = new File('app-storage:/configuration.xml');
			
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeUTFBytes(newXMLStr);
			fs.close(); 
			
			NativeApplication.nativeApplication.exit()
		}
	}
}