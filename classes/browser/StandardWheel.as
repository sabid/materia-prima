package browser
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
	
	import browser.items.*;
	

	
	public class StandardWheel extends Wheel
	{
    	// ---variables---
		
		// The directory that is shown by this wheel
		protected var dir:File;
		
		// Array, that holds the objects in the current folder
		protected var contents:Array;
		
		// XML-File that contains information like linked folders, control elements, ...
		private var infoXML:XML;
		
		protected var j:int;
		
		
		
		// ---constructor---
		
      	public function StandardWheel(browserIn:Filebrowser, itemIn:WheelItem, typeIn:String)
   		{
	  		super(browserIn, itemIn, typeIn);
			
			this.dir = motherItem.getDir();
   	  	}
		

		
		// ---functions---
		
		override public function listItems():void
		{
			dir.getDirectoryListingAsync();
			dir.addEventListener(FileListEvent.DIRECTORY_LISTING, displayDirectory, false, 0, true);
		}
		
		public function displayDirectory(event:FileListEvent):void
		{
			dir.removeEventListener(FileListEvent.DIRECTORY_LISTING, displayDirectory);
			
			contents = event.files;
			
			// itemCount is needed to calculate the position of the icons
			itemCount = 0;

			this.countFiles();
			this.displayCurrentPath();
			this.displayFolderContent();
		}
		
		public function countFiles():void
		{
			for (var k:uint = 0; k < contents.length; k++)
			{
				if(contents[k].isDirectory)
				{
					itemCount++;
				}
				if(contents[k].extension == "swf")
				{
					// is this still working with files that have "SWF"-extension?
					itemCount++;
				}
			}
				
			infoXML = motherItem.getInfoFile();			
				
			// crawling the foldername.xml for links or control elements
			// add linked folders to folder content
				
			var links = infoXML.LINKS;
				
			for (var i:int = 0; i < links.LINK.length()-1; i++)
			{
				if(links.LINK[i].dir == "userDirectory")
				{
					var linkedFile:File = File.userDirectory;
				}
					
				linkedFile = linkedFile.resolvePath(links.LINK[i].path);
															
				if(linkedFile.exists)
				{
					contents.push(linkedFile);
					itemCount++;
				}
			}
				
			// add control elements to the wheel
			for (var j:int = 0; j < infoXML.CONTROLS.CONTROL.length(); j++)
			{
				contents.push(infoXML.CONTROLS.CONTROL[j]);
				itemCount++;
			}
				
			this.calculateAngles(itemCount);
		}
		
		public function displayFolderContent()
		{
			itemCount += 1;
			
			j = 0;

			this.loadNextItem(contents[j]);
			
			
		}
		
		override public function loadNextItem(objectIn):void
		{
			if(contents == null)
			{
				return;
			}
			
			if(j == contents.length)
			{
				return;
			}
			
			if( contents.indexOf(objectIn) != -1 )
			{
				this.displayItem(objectIn);
			}
		}
		
		protected function displayItem(objectIn):void
		{
			if(contents[j] is XML)
			{
			  	var control:ControlItem;
				var cpng:File = dir;
				cpng = cpng.resolvePath(contents[j].iconFile);
						
				control = new ControlItem(contents[j], cpng)
				control.setWheel(this);
				
				j++;
				this.positioning(control)
			}
			else if(contents[j].isDirectory)
			{
				var theIcon:StandardItem;

				// Search the linksfile, for the type of the linked wheel 
				var wheelType:String = type;
				
								
				var links = infoXML.LINKS;
											
				for (var testx:int = 0; testx < links.LINK.length()-1; testx++)
				{
					if(links.LINK[testx].@NAME == contents[j].name)
					{
						wheelType = links.LINK[testx].wheel;
						var png:File = dir.resolvePath(links.LINK[testx].icon);
					}
				}
							
				theIcon = new StandardItem(contents[j], wheelType, png)
				theIcon.setWheel(this);
				j++;
				this.positioning(theIcon)
			}
			else if(contents[j].extension == "swf")
			{
				var starter:ProgramItem;
				starter = new ProgramItem(contents[j])
				starter.setWheel(this);
				j++;
				this.positioning(starter)
			}
			else
			{
				j++;
				this.loadNextItem(objectIn);
			}
		}
		
		public function displayCurrentPath()
		{
			// default selection is the last item in the current Path
			this.select(folder.currentPath[folder.currentPath.length-2]);
			
			// display current Path
			for(var cpTest = folder.currentPath.length; cpTest > 0; cpTest--)
			{
				var object = folder.currentPath[cpTest-1];
				
				this.setChildIndex(object, 0);
				
				// move the last object of the actual path (the current folder) into the middle and make it big
				if(cpTest-1 == folder.currentPath.length-1)
				{
					if(object is AlbumItem)
					{
						TweenMax.to(object, 0.7, {x: middleX, y: middleY - 50 });
					}
					else
					{
						object.scaleItem(300, 0.15)
						object.scaleShadow(0, 0, 000000)
						object.bigBoy();
						
						TweenMax.to(object, 0.7, {x: middleX, y: middleY });
					}
				}
				// Sort the rest, and adjust size
				else 
				{
					object.reFresh();
				
					if(cpTest-1 == folder.currentPath.length-2)
					{
						object.scaleItem( 100, 1 );
					}
					else
					{
						var percent = 100 - (folder.currentPath.length-1-cpTest) * 10;
						object.scaleItem( percent, 1 );
					}

					TweenMax.to(object, 0.7, {x: middleX - ( radius + ( folder.currentPath.length-1-cpTest ) * ( main.getItemSize() ) * (2/3) ), y: middleY });
				}
				
				object.hideText();
			}
		}
		
		override public function setDir(dirIn:File):void
		{
			this.dir = dirIn;
		}
	}
}
