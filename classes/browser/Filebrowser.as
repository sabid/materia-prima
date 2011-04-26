package browser
{
	import flash.display.*;
    import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.geom.*

	import flash.filesystem.*;

	import browser.items.*;
	import browser.items.controls.*;
	


	public class Filebrowser extends MovieClip
	{
    	//---variables---
		private var main:Main;
		private var dir:File;
		
		private var wg:Sprite;
		private var bg:Sprite;

		private var userInput:UserInput;
		
		private var infobox:Infobox;

		private var folder:FolderObject;
		private var wheel:Wheel;
		

		// the currently selected item
		private var crntItem:WheelItem;
		
				
		
		// ---constructor---
      	public function Filebrowser(mainIn, dirIn)
   		{
	  		main = mainIn;
			dir = dirIn;
			
			this.addEventListener(Event.ADDED_TO_STAGE, define);
   	  	}
		
		function define(e):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, define);
			
			userInput = new UserInput(this.main);
			
			folder = new FolderObject;
			this.addChild(folder);
			
			this.showBG();
			
			this.startBrowserAt(dir);
		}
		
		// --- Functions ---
		
		private function showBG()
		{
			bg = new Sprite();
			bg.graphics.lineStyle(NaN);
			
			this.addChild(bg);
		}
		
		private function startBrowserAt(dirIn):void
		{
			var home:StandardItem = new StandardItem(dirIn, "RegularWheel", null);

			wheel = new StandardWheel(this, home, "RegularWheel");
//			wheel.setCenter( new Point(stage.stageWidth/2, stage.stageWidth/2) );
//			wheel.setRadius(stage.stageHeight/4);
							
			home.setWheel(wheel);

			folder.currentFiles.push(home);
			wheel.addChild(home);
			folder.addChild(wheel);

			this.addExitIcon();

			userInput.setActiveObject(wheel);
			this.addChild(userInput);
			
			infobox = new Infobox(this, wheel.getCenter().x, wheel.getCenter().y, wheel.getRadius(), wheel.getRadius() );
			this.addChild(infobox);
			this.setChildIndex(infobox, 0);
			
			home.firstStart();
		}
		
		private function addExitIcon()
		{
			var exitFile = File.applicationDirectory;
			exitFile = exitFile.resolvePath("system/icons/exit");
			
			var exit = new ExitItem(exitFile);
			exit.setWheel(wheel);
			folder.currentPath.push(exit);
			
			wheel.addChild(exit)
		}
		
		public function openFolder(itemIn):void
		{			

			if(itemIn.type == "WheelOfChoice")
			{
				var item = itemIn as ControlItem;
				
				var woc:WheelOfChoice = new WheelOfChoice(this, item, item.type, item.getValArray() );
				
				var tempFolder:FolderObject = new FolderObject();
				this.addChild(tempFolder);
				tempFolder.addChild(woc);
				
				woc.listItems();
				
				this.userInput.setActiveObject(woc);
			}
			else
			{
				folder.actualizePath(itemIn);
				this.closeFolder();

				if(itemIn.type != wheel.type)
				{
					wheel.selfDestruct();
						
					if(itemIn.type == "RegularWheel")
					{
						wheel = new StandardWheel(this, itemIn, itemIn.type);
					}
					else if(itemIn.type == "PictureWheel")
					{
						wheel = new PictureWheel(this, itemIn, itemIn.type);
						
					}
					else if(itemIn.type == "MusicWheel")
					{
						wheel = new MusicWheel(this, itemIn, itemIn.type);
					}
					else
					{
						throw Error("Wheel type " + itemIn.type + " was not expected.");
					}
					
					folder.addChild(wheel);
						
					for(var p1p = folder.currentPath.length; p1p > 0; p1p--)
					{
						folder.currentPath[p1p-1].setWheel(wheel);
						wheel.addChild(folder.currentPath[p1p-1]);
					}
				}
				else
				{
					wheel.setMotherItem(itemIn);
					wheel.setDir(folder.currentPath[folder.currentPath.length-1].getDir());
				}
				
				userInput.setActiveObject(wheel);
				wheel.listItems();
			}
				
		}
				
		public function addText(textIn):ExtendedTextField
		{
			var tf = new ExtendedTextField(main);
			
			tf.add(textIn)
			
			return tf;
		}
		
		public function showInformation(itemIn:WheelItem, xIn:Number, yIn:Number)
		{
			var infoTxt:String = itemIn.getInfoText();

			if(infoTxt.length > 0)
			{
				infobox.displayText(infoTxt);
			}
		}
		
		public function closeFolder()
		{
			for(var testf = folder.currentFiles.length; testf > 0; testf --)
			{
				var object = folder.currentFiles[testf-1];
				
				if(folder.currentPath.indexOf(object) == -1) 
				{
					folder.currentFiles.splice(testf-1, 1);
					object.selfDestruct();
				}
			}
		}
		
		public function reFresh()
		{
			this.reFreshBG();

			for(var ref = folder.currentFiles.length; ref > 0; ref --)
			{
				var objectf = folder.currentFiles[ref-1];
				
				objectf.reFresh();
			}
			
			for(var rep = folder.currentPath.length-1; rep > 0; rep --)
			{
				var objectp = folder.currentPath[rep-1];
				
				objectp.reFresh();
			}
			
			wheel.reFresh();
			infobox.reFresh();
			userInput.reFresh();
		}
		
		private function reFreshBG():void
		{
			bg.graphics.clear();
			bg.graphics.beginFill( main.getDiscColor(), 1 );
			bg.graphics.drawRect(this.globalToLocal(new Point(0, 0)).x, this.globalToLocal(new Point(0, 0)).y, stage.stageWidth, stage.stageHeight);
			bg.graphics.beginFill( 0xffffff, 0.7 );
			bg.graphics.drawRect(this.globalToLocal(new Point(0, 0)).x, this.globalToLocal(new Point(0, 0)).y, stage.stageWidth, stage.stageHeight);
			
			this.setChildIndex(bg, 0);
		}
		
		public function getMain()
		{
			return this.main;
		}
		
		public function getActiveObject()
		{
			return userInput.getActiveObject();
		}
		
		public function getCrntItem():WheelItem
		{
			return crntItem;
		}
		
		public function setCrntItem(itemIn:WheelItem):void
		{
			crntItem = itemIn;
		}
		
		public function setActiveObject(objectIn):void
		{
			userInput.setActiveObject(objectIn);
		}
		
		public function selfDestruct()
		{
		}
	}
}
