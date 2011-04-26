package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.media.*;
	import flash.utils.*;
	
	private class Main extends MovieClip 
	{
		private var sound:Sound = new Sound();
		private var kanal:SoundChannel = new SoundChannel();
		
		private var soundLoader:URLLoader = new URLLoader();
		private var soundListe:XMLList;
		private var soundGesamt:Number;
		
		private var neuesInstrument:int = 0;
		
		private var instrument = null;
		
		private var instrumente:Array = new Array; 
		
		private var geige:Geige = null;
		private var klarinette:Klarinette = null;
		private var trompete:Trompete = null;
		private var pauke:Pauke = null;
		private var xylophon:Xylophon = null;
		private var klavier:Klavier = null;
		
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, initialisieren);
		}
		
		private function initialisieren(e:Event)
		{
			this.soundLoader.load(new URLRequest("Sounds.xml"));
			this.soundLoader.addEventListener(Event.COMPLETE, soundAuslesen);
			
			this.geige = new Geige(this, 0);
			this.addChild(geige);
			this.geige.x = 25;
			this.geige.y = 550;
			
			this.klarinette = new Klarinette(this, 1);
			this.addChild(klarinette);
			this.klarinette.x = 180;
			this.klarinette.y = 550;
			
			this.trompete = new Trompete(this, 4);
			this.addChild(trompete);
			this.trompete.x = 335;
			this.trompete.y = 550;
			
			this.pauke = new Pauke(this, 3);
			this.addChild(pauke);
			this.pauke.x = 490;
			this.pauke.y = 550;
			
			this.xylophon = new Xylophon(this, 5);
			this.addChild(xylophon);
			this.xylophon.x = 645;
			this.xylophon.y = 550;
			
			this.klavier = new Klavier(this, 2);
			this.addChild(klavier);
			this.klavier.x = 800;
			this.klavier.y = 550;
		}
		
		private function soundAuslesen(e:Event)
		{
			var soundXML:XML = new XML(e.target.data);
			this.soundListe = soundXML.SOUND;
			this.soundGesamt = this.soundListe.length();
			this.instrumente.length = this.soundListe.length;
			
			this.soundLoader.removeEventListener(Event.COMPLETE, soundAuslesen);
			this.instrumentWechseln(neuesInstrument);
		}
		
		private function instrumentWechseln(neuesInstrumentIn)
		{
			var soundURL = this.soundListe[neuesInstrumentIn].@URL;
			
			this.instrument = this.soundListe[neuesInstrumentIn].@NAME;
			
			this.kanal.stop();
			this.sound = new Sound();
			
			var soundrequest:URLRequest = new URLRequest(this.soundURL);
			this.sound.load(soundrequest);
			
			this.sound.addEventListener(Event.COMPLETE, abspielen);
		}
		
		private function abspielen(e)
		{
			this.kanal = sound.play(0, 0);
			this.sound.removeEventListener(Event.COMPLETE, abspielen);
		}
		
		private function lösen(instrumentIn, indexIn, auslöserIn)
		{
			var auslöser = auslöserIn;
			
			if(instrumentIn == instrument)
			{
				instrumente[indexIn] = true;
				auslöser.deaktivieren();
			}
			
			var erraten = 0;
			
			for(var i = 0; i < soundGesamt; i++)
			{
				if(instrumente[i] == true)
				{
					erraten ++;
				}
			}
			
			if(erraten >= (soundGesamt))
			{
				this.gewonnen();
			}
			else
			{
			var faktorSound = 100 / (soundGesamt);
			var zufall = Math.random();
			var neuesInstrument = int((zufall*100) / faktorSound);
				
			while(instrumente[neuesInstrument] == true)
			{
				faktorSound = 100 / (soundGesamt);
				zufall = Math.random();
				neuesInstrument = int((zufall*100) / faktorSound);
			}
			
			instrumentWechseln(neuesInstrument);
			}
		}
		
		private function gewonnen()
		{
			this.kanal.stop();
		}
	}
}