package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.media.*;
	import flash.utils.*;
	
	public class Klavier extends MovieClip 
	{
		private var vater = null;
		private var index = 0;
		
		public function Klavier(vaterIn, indexIn)
		{
			vater = vaterIn;
			index = indexIn;
			
			this.addEventListener(MouseEvent.CLICK, auswahl);
		}
		
		function auswahl(e)
		{
			vater.lösen("Klavier", index, this);
		}
		
		function deaktivieren()
		{
			this.removeEventListener(MouseEvent.CLICK, auswahl);
			this.gotoAndStop(2);
		}
	}
}