package browser.items
{
	import flash.display.*;
    import flash.events.*;
	
	
	
	public class ExitItem extends StandardItem
	{
  		public function ExitItem(fileIn)
		{ 
            super(fileIn, "regularWheel", null); 
        } 
        override public function released():void
		{
			main.applicationExit();
		}
	}
}