package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.media.*;
	import flash.utils.*;
	
	public class Pauke extends MovieClip 
	{
		private var vater = null;
		private var index = 0;
		
		public function Pauke(vaterIn, indexIn)
		{
			vater = vaterIn;
			index = indexIn;
			
			this.addEventListener(MouseEvent.CLICK, auswahl);
		}
		
		function auswahl(e)
		{
			vater.lösen("Pauke", index, this);
		}
		
		function deaktivieren()
		{
			this.removeEventListener(MouseEvent.CLICK, auswahl);
			this.gotoAndStop(2);
		}
	}
}