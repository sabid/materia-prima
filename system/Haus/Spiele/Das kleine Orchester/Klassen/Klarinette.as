package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.media.*;
	import flash.utils.*;
	
	public class Klarinette extends MovieClip 
	{
		private var vater = null;
		private var index = 0;
		
		public function Klarinette(vaterIn, indexIn)
		{
			vater = vaterIn;
			index = indexIn;
			
			this.addEventListener(MouseEvent.CLICK, auswahl);
		}
		
		function auswahl(e)
		{
			vater.lösen("Klarinette", index, this);
		}
		
		function deaktivieren()
		{
			this.removeEventListener(MouseEvent.CLICK, auswahl);
			this.gotoAndStop(2);
		}
	}
}