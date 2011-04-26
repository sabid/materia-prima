package browser.items
{
	import flash.display.*;
    import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.filesystem.*;
	import flash.geom.*;
	import flash.ui.Keyboard;
	
	import fl.transitions.*;	
	import com.greensock.TweenMax;
	import com.greensock.OverwriteManager;
	import com.greensock.plugins.*;

	import fl.motion.easing.*;



	public class ProgramItem extends StandardItem
	{
  		// ---variables---
		
//		private var wid:Number;
//		private var hei:Number;
//		
//		private var bmpTween:TweenMax;
//		
		// The Background of the "lightbox"
		private var bg:Sprite;
		
		// The border of the full image
		private var border:Sprite;
		
		private var progLoader:Loader;
		
		
		
		// ---constructor---
		
      	public function ProgramItem(fileIn:File)
   		{
			super(fileIn, null, null);
   	  	}
		
//		override protected function define(e:Event):void
//		{
//			super.define();

//			if(iconFile == null)
//			{
//				iconFile = dir;
//			}
//			
//			wid = main.getItemSize()*1.6;
//			hei = main.getItemSize()*1.2;
//			
//			this.loadIcon();
//		}
 
 
 
		// ---functions---

//		override protected function iconLoadingComplete(e:Event):void
//		{
//
//		}
		
		override protected function onReleaseEvent(event:Event):void
		{
			if(filebrowser.getActiveObject() == wheel)
			{
				this.released();
			}
		}
		
		override public function released():void
		{
			this.startProgram();
		}
		
		function startProgram():void
		{
			progLoader = new Loader();
			
			var progRequest:URLRequest = new URLRequest(dir.url);
			progLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, progLoadingComplete);
			progLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progLoading);
			progLoader.load(progRequest);
		}
		
		private function progLoading(e:Event)
		{
		}
		
		private function progLoadingComplete(loadevent:Event):void
		{
			filebrowser.setActiveObject(this);
			
//			var imageBorder = stage.stageHeight/8;
//			
//			var bigHei = stage.stageHeight-imageBorder*2;
//			var bigWid = bmd.width/(bmd.height/bigHei);
//			
//			var fullX = this.globalToLocal(new Point((stage.stageWidth-bigWid)/2,0)).x;
//			var fullY = this.globalToLocal(new Point(0, imageBorder)).y;
			
			bg = new Sprite();
			bg.graphics.lineStyle(NaN);
			bg.graphics.beginFill(0x555555);
			bg.graphics.drawRect(this.globalToLocal(new Point(0, 0)).x,this.globalToLocal(new Point(0, 0)).y, stage.stageWidth, stage.stageHeight);
			this.addChild(bg);
			bg.graphics.endFill();





//			var border = stage.stageHeight/8;
//			
//			var bigHei = stage.stageHeight-border*2;
//			var bigWid = progLoader.width/(progLoader.height/bigHei);
//			
//			var scaleWid:Number = bigWid/progLoader.width;
//			var scaleHei:Number = bigHei/progLoader.height;
//			
//			var matrix:Matrix = new Matrix();
//			matrix.scale(scaleWid, scaleHei);
//			
//			bigBMD = new BitmapData(bigWid, bigHei, true, 0x000000);
//			bigBMD.draw(progLoader, matrix, null, null, null, true);
//			
			
			var progX = this.globalToLocal(new Point((stage.stageWidth - progLoader.width)/2,0)).x;
			var progY = this.globalToLocal(new Point(0, (stage.stageHeight - progLoader.height)/2)).y;
			
			progLoader.x = this.globalToLocal(new Point((stage.stageWidth - progLoader.width)/2,0)).x;
			progLoader.y = this.globalToLocal(new Point(0, (stage.stageHeight - progLoader.height)/2)).y;
			this.addChild(progLoader);

			parent.setChildIndex(this, parent.numChildren - 1);
			
			
			//Drawing a border around the program
			var vars = progLoader.getBounds(this);
			border = new Sprite();
						
			this.addChild(border);
			
			border.graphics.lineStyle(0, 0xffffff);
			
			border.graphics.moveTo(vars.x, vars.y);
 			border.graphics.lineTo(vars.width + vars.x, vars.y);
			border.graphics.lineTo(vars.width + vars.x, vars.height + vars.y);
			border.graphics.lineTo(vars.x, vars.height + vars.y);
			border.graphics.lineTo(vars.x, vars.y);
			border.graphics.endFill();
		}
		
		private function closeProgram()
		{
			this.removeChild(bg);
			this.removeChild(progLoader);
			this.removeChild(border);
			
			filebrowser.setActiveObject(wheel);
		}
		
		public function keyDownEvent(commandIn:Number)
		{
			var command = commandIn;
			  
			switch(command) 
			{
				case Keyboard.ESCAPE :
					this.closeProgram();
				break;
					
				default :
				break;
			}
		}
	}
}