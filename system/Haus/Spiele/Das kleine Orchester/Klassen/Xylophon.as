package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.media.*;
	import flash.utils.*;
	
	public class Xylophon extends MovieClip 
	{
		private var vater = null;
		private var index = 0;
		
		public function Xylophon(vaterIn, indexIn)
		{
			vater = vaterIn;
			index = indexIn;
			
			this.addEventListener(MouseEvent.CLICK, auswahl);
		}
		
		function auswahl(e)
		{
			vater.lösen("Xylophon", index, this);
		}
		
		function deaktivieren()
		{
			this.removeEventListener(MouseEvent.CLICK, auswahl);
			this.gotoAndStop(2);
		}
	}
}