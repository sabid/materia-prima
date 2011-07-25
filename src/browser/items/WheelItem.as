package browser.items
{
	import flash.display.*;
	
    import flash.events.*;
	
	import flash.net.*;
	import flash.utils.*;
	import flash.filesystem.*;
	import flash.geom.*;
	
	import fl.transitions.*;	
	import fl.motion.easing.*;
	
	import flash.media.*;
	
	import com.greensock.TweenMax;
	import com.greensock.OverwriteManager;
	import com.greensock.plugins.*;

	import flash.filters.DropShadowFilter;

	import browser.Filebrowser;
	import browser.FolderObject;
	import browser.wheels.*;
	//import browser.text.ExtendedTextField;
	import browser.text.ExtendedLabel;
	
	

	public class WheelItem extends MovieClip
	{
  		// ---variables---
		protected var main:Main;
		protected var filebrowser:Filebrowser;
  	   	protected var wheel:Wheel;
		
		protected var dir:File;
		
		public var type:String;
		
		private var xPos:int;
		private var yPos:int;
		
		protected var wid:int;
		protected var hei:int;
		protected var xRel:Number = 1;
		protected var yRel:Number = 1;

		private var dShadow:DropShadowFilter;
		protected var shadowTween:TweenMax;
		
		// These variables will hold the links.xml-file. It contains "links" to other folders, "my pictures" for example
		private var infoLoader:URLLoader;
		protected var infos:XML = new XML();
		
		protected var audio:Sound = new Sound();
		protected var channel1:SoundChannel = new SoundChannel();
		
		protected var loadComplete:Boolean = false;

		protected var infoFile:File;
		protected var audioFile:File;
		protected var iconFile:File;
		
		protected var id3Tag:ID3Info;
		
		protected var txt:ExtendedLabel;
		
		protected var sel:Boolean;
		
		
		
		// ---constructor---
		
      	public function WheelItem(fileIn:File, typeIn:String):void
   		{
	  		type = typeIn;
			dir = fileIn;
			
			OverwriteManager.init(OverwriteManager.AUTO);
			TweenPlugin.activate([DropShadowFilterPlugin]);
			
			this.addEventListener(Event.ADDED_TO_STAGE, define);
   	  	}
		
		protected function define(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, define);
			
			wid = main.getItemSize() * xRel;
			hei = main.getItemSize() * yRel;
			
			this.createSprite();
			this.drawShadow();
			
			//OverwriteManager.init(OverwriteManager.NONE); 
			if(dir != null)
			{
				if(infoFile == null)
				{
					infoFile = dir.resolvePath(dir.name+".xml");
				}
				
				if(audioFile == null)
				{
					audioFile = dir.resolvePath(dir.name+".mp3");
				}
				

				if(infoFile.exists)
				{
					this.loadInfos();
				}
				else
				{
					if(audioFile.exists)
					{
						this.loadAudio();
					}
					else
					{
						if(iconFile.exists)
						{
							this.loadIcon();
						}
						else
						{
							this.onLoadComplete();
						}
					}
				}
			}
			else
			{
				if(iconFile.exists)
				{
					var filename:String = new String();
					
					if(this.infoFile != null)
					{
						filename = infoFile.name;
					} 
					else if(this.iconFile != null)
					{
						filename = iconFile.name;
					}
					
					var extensionIndex:Number = filename.lastIndexOf( '.' );
					var extensionless:String = filename.substr( 0, extensionIndex );

					audioFile = this.getDir().resolvePath(extensionless + ".mp3");

					if(audioFile.exists)
					{
						this.loadAudio();
					}
					else
					{
						this.loadIcon();
					}
				}
				else
				{
					this.onLoadComplete();
				}
			}
		}
 		
		protected function createSprite():void
		{
		}
		
		function drawShadow():void
		{
			dShadow = new DropShadowFilter();
			dShadow.distance = 0;
			dShadow.blurX = 15;
			dShadow.blurY = 15;
			dShadow.alpha = .85;
			dShadow.quality = 3;
			
			this.filters = [dShadow];
		}
		
		protected function loadInfos():void
		{
			infoLoader = new URLLoader()
			infoLoader.addEventListener(Event.COMPLETE, infoLoadComplete);
			infoLoader.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			infoLoader.load(new URLRequest(infoFile.url));
		}
		
		private function infoLoadComplete(event:Event):void
		{
			infoLoader.removeEventListener(Event.COMPLETE, onLoadProgress);
			infoLoader.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			
			infos = new XML(event.target.data);
			infos.ignoreWhite = true;
	  		
			if(audioFile.exists)
			{
				this.loadAudio();
			}
			else
			{
				if(iconFile.exists)
				{
					this.loadIcon();
				}
				else
				{
					this.onLoadComplete();
				}
			}
		}
		
		protected function loadAudio():void
		{
			audio = new Sound();
			audio.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			audio.addEventListener(Event.COMPLETE, audioLoadComplete);
			audio.load(new URLRequest(audioFile.url));

			if(this.type == "MusicWheel")
			{
				audio.addEventListener(Event.ID3, loadID3);
			}
		}
		
		private function loadID3(event:Event):void
		{
			id3Tag = event.target.id3;
			
			if(id3Tag.songName != null)
			{
				this.changeText(id3Tag.songName);
			}
		}
		
		protected function audioLoadComplete(event:Event):void
		{
			audio.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			audio.removeEventListener(Event.COMPLETE, audioLoadComplete);
			
			if(iconFile.exists)
			{
				this.loadIcon();
			}
			else
			{
				this.onLoadComplete();
			}
		}
		
		protected function loadIcon():void
		{
			// override
		}
		
		protected function onLoadProgress(event:ProgressEvent) 
		{
		   // ENTERFRAME ?
		   var loadedPercent:uint = Math.round(event.bytesLoaded / event.bytesTotal * 100);
		   
		   return(loadedPercent);
		}

		protected function onLoadComplete():void
		{
			this.loadComplete = true;
			
			
				// adding the Name-Label to the icon
				var txt = new ExtendedLabel(main);
				
				var margin:Number = 1.75;
				
				
				if(this.x > stage.stageWidth/2)
				{
					txt.setXPos(margin * main.getItemSize());   
				}
				else
				{
					txt.setXPos(-margin * main.getItemSize()); 
				}
				
				if(this.y > stage.stageHeight/2)
				{
					txt.setYPos(   int(  margin * main.getItemSize() * (1-(stage.stageHeight/2) / this.y)  )   );
				}
				else
				{
					txt.setYPos(   int(-(margin/2)*( main.getItemSize() * ((stage.stageHeight/2) / (this.y+stage.stageHeight/2)) ))   );
				}
				
				
				txt.add( this.getName() )
				
					
				this.addChild(txt);

			
			wheel.loadNextItem(this.dir);
		}
		
		public function firstStart():void
		{
			this.addEventListener(Event.ENTER_FRAME, checkReady);
		}
		
		private function checkReady(e)
		{
			if(this.loadComplete == true)
			{
				this.removeEventListener(Event.ENTER_FRAME, checkReady);
				this.released();
			}
		}
		
		function defineSpecific()
		{
			// override
		}
		
		
		// ---functions---
		
		public function setWheel(wheelIn:Wheel)
		{
			wheel = wheelIn;
			filebrowser = wheel.getFilebrowser();
			main = filebrowser.getMain();
			
			txt = new ExtendedLabel(main);
			
			if(main.getControlMode() == 4 || main.getControlMode() == 5)
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN, onPressEvent);
				this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			}
		}
		
		protected function onMouseOver(e:Event):void
		{
			if(filebrowser.getActiveObject() == wheel)
			{
				this.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				
				var folder =  wheel.parent as FolderObject;
				
				if( folder.currentFiles.indexOf(this) > -1)
				{
					wheel.select(this);
				}
			}
		}
		
		protected function onMouseOut(e:Event):void
		{
			if(filebrowser.getActiveObject() == wheel)
			{
				this.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			}
		}
		
		protected function onPressEvent(e):void
		{
			this.removeEventListener(MouseEvent.MOUSE_UP, onPressEvent);
			this.addEventListener(MouseEvent.MOUSE_UP, onReleaseEvent);

			if(filebrowser.getActiveObject() == wheel)
			{
				this.pressed();
			}
		}
		
		public function pressed():void
		{
			this.scaleItem( 95, 1 );
		}
		
		protected function onReleaseEvent(event:Event):void
		{
			this.removeEventListener(MouseEvent.MOUSE_UP, onReleaseEvent);

			if(filebrowser.getActiveObject() == wheel)
			{
				this.released();
			}
		}
		
		public function released():void
		{
			filebrowser.openFolder(this);
		}
		
		public function select():void
		{
			if(sel == true)
			{
				return;
			}
			
			sel = true;
			
			channel1.stop();
			
			if(audio.bytesTotal > 0)
			{
				channel1 = audio.play();
			}
		}
		
		public function deselect():void
		{
			sel = false;
			
			channel1.stop();
		}
		
		public function scaleItem(percentIn:Number, alphaIn:Number):void
		{
		}
		
		public function scaleShadow(alphaIn:Number, blurIn:Number, colorIn:Number)
		{
			var alphaVal = alphaIn;
			var blur:Number = blurIn;
			var color:Number = colorIn;

			shadowTween = new TweenMax(this, 0.5, {dropShadowFilter:{blurX:blur, blurY:blur, alpha:alphaVal, color:color, overwrite:5}});
		}
		
		
//		function hittesting(e)
//		{
//			if(this.hitTestObject(mother.myCursor))
//			{
//				mother.myCursor.visible = true;
//				this.onMouseOver();
//			}
//		}
		
		public function changeText(textIn:String):void
		{
			txt.add(textIn);
		}
		
		public function bigBoy():void
		{
			//scaling = false;
		}
		
		public function hideText():void
		{
			txt.alpha = 0;
		}
		
		public function reFresh():void
		{
			wid = main.getItemSize() * xRel;
			hei = main.getItemSize() * yRel;
			
			if(main.getControlMode() == 4 || main.getControlMode() == 5)
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN, onPressEvent);
				this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			}
			else
			{
				this.removeEventListener(MouseEvent.MOUSE_DOWN, onPressEvent);
				this.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			}
			
			txt.reFresh();
			txt.alpha = 1;
		}
		
		public function getSelect():Boolean
		{
			return sel;
		}
		
		public function getSize():Point
		{
			return new Point(wid, hei);
		}
	
//		public function setItemSize(sizeIn:Point)
//		{
//			wid = sizeIn.x;
//			hei = sizeIn.y;
//		}
	
		public function getName():String
		{
			var filename:String = new String;
			
			if(this.dir != null)
			{
				return this.dir.name;
			}
			else if(this.infoFile != null)
			{
				filename = infoFile.name;
			} 
			else if(this.audioFile != null)
			{
				filename = audioFile.name;
			}
			else if(this.iconFile != null)
			{
				filename = iconFile.name;
			}
			else
			{
				
			}
			
			var extensionIndex:Number = filename.lastIndexOf( '.' );
			var extensionless:String = filename.substr( 0, extensionIndex );

			return extensionless;
		}
		
		public function getDir():File
		{
			if(this.dir != null)
			{
				return this.dir;
			}
			else if(this.iconFile != null)
			{
				return this.iconFile.parent;
			}
			else if(this.infoFile != null)
			{
				return this.infoFile.parent;
			}
			else if(this.audioFile != null)
			{
				return this.audioFile.parent;
			}
			else
			{
				return null;
			}
		}
	
		public function getInfoFile():XML
		{
			return this.infos;
		}
		
		public function getInfoText():String
		{
			if(infos.TEXT.length() > 0)
			{
				return this.infos.TEXT;
			}
			else
			{
				return "<p> Für diesen Punkt gibt es keine Beschreibung. </p>";
			}
		}
		
		
		
		public function selfDestruct()
		{
			TweenMax.to(this, 0.7, {alpha:0, onComplete:finish});
		}
		
		protected function finish():void
		{
			for(var test:uint = this.numChildren-1; test > 0; test--)
			{
				var object;
				object = this.getChildAt(test);
				this.removeChild(object);
			}
			
			this.removeEventListener(MouseEvent.CLICK, onReleaseEvent);
			this.removeEventListener(MouseEvent.CLICK, onMouseOver);
			
			parent.removeChild(this);
		}
	}
}