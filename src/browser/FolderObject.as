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
	

	
	public class FolderObject extends MovieClip
	{
    	// ---variables---
		
		public var currentPath:Array;
		public var currentFiles:Array;
		
					
		
		// ---constructor---
		
      	public function FolderObject()
   		{
	  		currentPath = new Array();
			currentFiles = new Array();
									
   	  	}
		
		// ---functions---
		
		public function actualizePath(iconIn):void
		{
			var theIcon = iconIn;
			
			// if path already contains theIcon, ...
			if(currentPath.indexOf(theIcon) > -1)
			{
				// ...remove everything from iconIn to the end of the path
				for(var testp = currentPath.length; testp > currentPath.indexOf(theIcon)+1; testp --)
				{
					var object = currentPath[testp-1];
					
					// don't forget to remove it from the currentPath-array
					currentPath.splice(testp-1, 1);
					
					// and if necessary from the currentFiles-array
					if(currentFiles.indexOf(object) != -1)
					{
						currentFiles.splice(currentFiles.indexOf(object), 1);
					}
					
					object.selfDestruct();
				}
				
				if(currentFiles.indexOf(currentPath[currentPath.length-1]) != -1)
				{
					currentFiles.splice(   currentFiles.indexOf(currentPath[currentPath.length-1]), 1   );
				}
			}
			// if currentPath doesn't contain theIcon, simply splice it from currentFiles and add it
			else
			{
				currentFiles.splice(currentFiles.indexOf(theIcon), 1);
				currentPath.push(theIcon);
				
				if(currentFiles.indexOf(currentPath[currentPath.length-3]) != -1)
				{
					currentFiles.splice(   currentFiles.indexOf(currentPath[currentPath.length-3]), 1   );
				}
			}
			
			// The icon that leads to the next higher directory has to be part of the path AND of the current Files, so it can be chosen via keyboard/buzzers
			currentFiles.push(currentPath[currentPath.length-2]);
		}
		
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
