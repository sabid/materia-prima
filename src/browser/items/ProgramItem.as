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
			parent.setChildIndex(this, parent.numChildren - 1);
			filebrowser.setActiveObject(this);
			
			bg = new Sprite();
			bg.graphics.lineStyle(NaN);
			bg.graphics.beginFill(0x555555, 0.5);
			bg.graphics.drawRect(this.globalToLocal(new Point(0, 0)).x,this.globalToLocal(new Point(0, 0)).y, stage.stageWidth, stage.stageHeight);
			this.addChild(bg);
			bg.graphics.endFill();
			
			
			var progWidth = progLoader.contentLoaderInfo.width;
			var progHeight = progLoader.contentLoaderInfo.height;
			var progX = this.globalToLocal(new Point((stage.stageWidth - progWidth)/2,0)).x;
			var progY = this.globalToLocal(new Point(0, (stage.stageHeight - progHeight)/2)).y;
			
			progLoader.x = progX;
			progLoader.y = progY;
			
			
			var gameMask : Shape = new Shape;
			gameMask.graphics.beginFill(0xffcc00);
			gameMask.graphics.drawRect((stage.stageWidth-progWidth)/2, (stage.stageHeight-progHeight)/2, progWidth, progHeight);
			progLoader.mask = gameMask;
			
			this.addChild(progLoader);
			
			trace(progLoader.content);
			//Drawing a border around the swf-loader
			border = new Sprite();
			border.graphics.lineStyle(1, 0xffffff);
			
			border.graphics.moveTo(progX, progY);
			border.graphics.lineTo(progWidth + progX, progY);
			border.graphics.lineTo(progWidth + progX, progHeight + progY);
			border.graphics.lineTo(progX, progHeight + progY);
			border.graphics.lineTo(progX, progY);
			
			border.graphics.endFill();
			this.addChild(border);
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