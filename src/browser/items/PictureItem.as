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



	public class PictureItem extends StandardItem
	{
  		// ---variables---
		
		private var full:Bitmap;
		
		private var bmd:BitmapData;
		private var bigBMD:BitmapData;
		private var smallBMD:BitmapData;

		// The background and border of the lightbox
		private var lightbox:Sprite;
		
		
		
		// ---constructor---
		
      	public function PictureItem(fileIn:File)
   		{
			super(fileIn, null, fileIn);
   	  	}
		
		override protected function define(event:Event):void
		{
			xRel = 1.6;
			yRel = 1.2;
			
			if(iconFile == null)
			{
				iconFile = dir;
			}
			
			super.define(event);
		}
 
 
 
		// ---functions---

		override protected function createSprite():void
		{
			this.drawSprite();
			
			sprite.alpha = 0;

			this.addChild(sprite);
		}
		
		override protected function drawSprite():void
		{
			var thick:int = main.getItemSize()/10;
			
			sprite.graphics.lineStyle(NaN);
			sprite.graphics.beginFill( main.getDiscColor() );
			
			sprite.graphics.drawRect( (-wid-thick)/2, (-hei-thick)/2, wid+thick, hei+thick );
			
			sWid = sprite.width;
			sHei = sprite.height;
		}
		
		override protected function iconLoadingComplete(e:Event):void
		{
			bmd = Bitmap(LoaderInfo(e.target).content).bitmapData;
		
			var scalX:Number = wid/bmd.width;
						
			var matrix:Matrix = new Matrix();
			matrix.scale(scalX, scalX);
			
			smallBMD = new BitmapData(wid, hei, true, 0x000000);
			smallBMD.draw(bmd, matrix, null, null, null, true);
			
			iconLoader = new Bitmap(smallBMD, PixelSnapping.NEVER, true);
			iconLoader.x = -wid/2;
			iconLoader.y = -hei/2;
			
			this.addChild(iconLoader);
			
			this.onLoadComplete();
		}
		
		override protected function onReleaseEvent(event:Event):void
		{
			if(filebrowser.getActiveObject() == wheel)
			{
				this.released();
			}
			else
			{
				this.closeFullImage();
			}
		}
		
		override public function released():void
		{
			this.displayFullImage();
		}
		
		function displayFullImage():void
		{
			filebrowser.setActiveObject(this);
			
			var imageBorder = stage.stageHeight/8;
			
			var bigHei = stage.stageHeight-imageBorder*2;
			var bigWid = bmd.width/(bmd.height/bigHei);
			
			var scaleWid:Number = bigWid/bmd.width;
			var scaleHei:Number = bigHei/bmd.height;
			
			var matrix:Matrix = new Matrix();
			matrix.scale(scaleWid, scaleHei);
			
			bigBMD = new BitmapData(bigWid, bigHei, true, 0x000000);
			bigBMD.draw(bmd, matrix, null, null, null, true);
			
			var fullX = this.globalToLocal(new Point((stage.stageWidth-bigWid)/2,0)).x;
			var fullY = this.globalToLocal(new Point(0, imageBorder)).y;
			
			full = new Bitmap(bigBMD, PixelSnapping.NEVER, true);
			full.x = fullX;
			full.y = fullY;
			
			
			
			//Drawing the background of the lightbox
			lightbox = new Sprite();
			lightbox.graphics.lineStyle(NaN);
			lightbox.graphics.beginFill(0x555555);
			lightbox.graphics.drawRect(this.globalToLocal(new Point(0, 0)).x,this.globalToLocal(new Point(0, 0)).y, stage.stageWidth, stage.stageHeight);
			
			
			//Drawing a border around the big image
			var vars = full.getBounds(this.parent);
			
			lightbox.graphics.lineStyle(3, 0xffffff);
			lightbox.graphics.moveTo(fullX, fullY);
 			lightbox.graphics.lineTo(vars.width + fullX, fullY);
			lightbox.graphics.lineTo(vars.width + fullX, vars.height + fullY);
			lightbox.graphics.lineTo(fullX, vars.height + fullY);
			lightbox.graphics.lineTo(fullX, fullY);
			lightbox.graphics.endFill();
			
			
			
			this.addChild(lightbox);
			this.addChild(full);
			parent.setChildIndex(this, parent.numChildren-1);

			//full.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.closeFullImage());
			
						
//			//total of images in chosen category
//			var totalImages = myGallery[curCat]["image"].length;
//			curImage_txt.text = Number(_root.curImage+1)+" of "+totalImages;
		
//			enableImageNav(true);
		
			
//			if(bigWid > 710) 
//			{
//				full.maxWidth = 710;
//				var newSize = imageHolder.resizeToFit();
//				imageHolder.tween(["_width", "_height"], [newSize.newWidth, newSize.newHeight], 0.5, undefined);
//				var bigWid = newSize.newWidth;
//				var bigHei = newSize.newHeight;
//			}
			
//			var xCenter = (transBG_mc.fake_btn._width/2) - (Number(mcW+imageBorder)/2);
//			var yCenter = (transBG_mc.fake_btn._height/2) - (Number(mcH+imageBorder)/2);
//			
//			// center the image
//			transBG_mc.picBG_mc.slideTo(xCenter, yCenter, 0.5);
//			// resize the background
//			transBG_mc.picBG_mc.bg_mc.tween(["_width", "_height"], [mcW+imageBorder, mcH+imageBorder], 0.5, undefined, 0, function() {  });
//			transBG_mc.picBG_mc.bg_mc.alphaTo(100, 0.5, "linear", 0, function() { imageHolder.alphaTo(100, 2); });
//		
//			
//			var descMC = _root.transBG_mc.desc_mc;
//			
//			// put description
//			descMC.desc_txt.text = desc;
			
			
//			// resize textfield
//			var padding = 30;
//			var myFormat_fmt = new TextFormat();
//			var textDimension = myFormat_fmt.getTextExtent(desc, 200);
//			var tWidth = textDimension.textFieldWidth;
//			var tHeight = textDimension.textFieldHeight+20; // used 20 to prevent it from text get cut off at the end //////////////////////////
//			
//			descMC.desc_txt._width = tWidth;
//			descMC.desc_txt._height = tHeight;
//			// reposition textfield
//			descMC.desc_txt._x = padding/2;
//			descMC.desc_txt._y = padding/2;
//			descMC.descBG_mc._width = tWidth+padding;
//			descMC.descBG_mc._height = tHeight+padding;
//			descMC._alpha = 0;
			
//			imageHolder.onRollOver = function() 
//			{
//				descMC.alphaTo(100, 1);
//			}
//			imageHolder.onRollOut = function() 
//			{
//				descMC.alphaTo(0, 1);
//			}
			
//			// center image description mc
//			var xDescCenter = ((transBG_mc.fake_btn._width+imageBorder)/2) - ((descMC._width+imageBorder)/2);
//			var yDescCenter = ((transBG_mc.fake_btn._height+imageBorder)/2) - ((descMC._height+imageBorder)/2);
//			
//			descMC.slideTo(xDescCenter, yDescCenter, 0.5);
			
//			// hide full view
//			exit_mc.onRelease = function() {
//				var DisappearW = mcW;
//				var DisappearH = mcH;
//				var DisappearXCenter = (transBG_mc.fake_btn._width/2) - (Number(DisappearW+imageBorder/2)/2);
//				var DisappearYCenter = (transBG_mc.fake_btn._height/2) - (Number(DisappearH+imageBorder/2)/2);
//				
//				imageHolder.alphaTo(0, 0.2, "linear", 0, function() { imageHolder.unloadMovie() });
//				//transBG_mc.picBG_mc.slideTo(DisappearXCenter, DisappearYCenter, 0.5, undefined, 0.5);
//				//transBG_mc.picBG_mc.bg_mc.tween(["_width", "_height"], [DisappearW, DisappearH], 0.5, undefined, 0.5);
//				transBG_mc.picBG_mc.bg_mc.alphaTo(0, 0.5, "linear", undefined);
//				transBG_mc.alphaTo(0, 0.5, "linear", undefined, function() { transBG_mc._visible = false;});
//				
//				
//				// disable image nav 
//				enableImageNav(false);
//				
//				this.btnRollOut();
//				
//				// stop the timer
//				myTimer.pause();
//			}
			
			
			
//			exit_mc.onRollOver = function() 
//			{
//				this.btnRollOver();
//			}
//			exit_mc.onRollOut = function() {
//				this.btnRollOut();
//			}
//			
//			next_mc.onRelease = function() {
//				// turn off timer only if autoSlide is true
//				if(autoSlide) {
//					timerToggle();
//				}
//				showNextImage(imageHolder);
//			}
//			next_mc.onRollOver = function() {
//				this.btnRollOver();
//			}
//			next_mc.onRollOut = function() {
//				this.btnRollOut();
//			}
//			
//			prev_mc.onRelease = function() {
//				// turn off timer only if autoSlide is true
//				if(autoSlide) {
//					timerToggle();
//				}
//				showPrevImage(imageHolder);
//			}
//			prev_mc.onRollOver = function() {
//				this.btnRollOver();
//			}
//			prev_mc.onRollOut = function() {
//				this.btnRollOut();
	//		}
		}
		
		private function closeFullImage()
		{
			//full.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.closeFullImage());
			
			this.removeChild(lightbox);
			this.removeChild(full);
			
			filebrowser.setActiveObject(wheel);
		}
		
		public function keyDownEvent(commandIn:Number)
		{
			var command = commandIn;
			 
			switch(command) 
			{
				default :
				break;
			}
		}
		
		public function keyUpEvent(commandIn:Number)
		{
			var command = commandIn;
			 
			switch(command) 
			{
				case Keyboard.ESCAPE :
					this.closeFullImage();
				break;
				
				case Keyboard.ENTER :
					this.closeFullImage();
				break;
					
				default :
				break;
			}
		}
	}
}