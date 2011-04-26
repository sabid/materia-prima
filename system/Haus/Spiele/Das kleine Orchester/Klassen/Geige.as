package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.media.*;
	import flash.utils.*;
	
	public class Geige extends MovieClip 
	{
		private var vater = null;
		private var index = 0;
		
		public function Geige(vaterIn, indexIn)
		{
			vater = vaterIn;
			index = indexIn;
			
			addEventListener(MouseEvent.CLICK, auswahl);
		}
		
		function auswahl(e)
		{
			vater.lösen("Geige", index, this);
		}
		
		function deaktivieren()
		{
			removeEventListener(MouseEvent.CLICK, auswahl);
			this.gotoAndStop(2);
		}
	}
}