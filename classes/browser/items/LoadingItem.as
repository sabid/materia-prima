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
	
	import com.greensock.TweenMax;
	import com.greensock.OverwriteManager;
	import com.greensock.plugins.*;

	import flash.filters.DropShadowFilter;

	import browser.*;
	


	public class LoadingItem extends WheelItem
	{
  		// ---variables---
		
		// The loader, that keeps the icon is the same that keeps the picture-thumbnail, album art ...
		protected var iconLoader;
		private var iconTween:TweenMax;
		
		
		
		// ---constructor---
		
      	public function LoadingItem(fileIn:File, typeIn:String):void
   		{
			iconLoader = new Loader();

			super(fileIn, typeIn);
   	  	}
		
		override protected function define(event:Event):void
		{
			super.define(event);
		}
 		
		
		// --- functions ---
		
		override protected function loadIcon():void
		{
			iconLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			iconLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, iconLoadingComplete);

			iconLoader.load(new URLRequest(iconFile.url));
		}
		
		protected function iconLoadingComplete(event:Event):void
		{
			iconLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			iconLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, iconLoadingComplete);
			
			iconLoader.width = wid;
			iconLoader.height = hei;
			iconLoader.x = - wid/2;
			iconLoader.y = - hei/2;
			
			var myColorTransform:ColorTransform = new ColorTransform();
    		myColorTransform.color = main.getIconColor();
	
			iconLoader.transform.colorTransform = myColorTransform;

			this.addChild(iconLoader);
			this.onLoadComplete();
		}
		
		override public function scaleItem(percentIn:Number, alphaIn:Number):void
		{
			var percent:Number = percentIn;
			var alphaVal = alphaIn;
			
			iconTween = new TweenMax(iconLoader, 0.5, {width:wid/100 * percent, height: hei/100 * percent, x: 0 - (wid/100*percent)/2 , y: 0 - (hei/100*percent)/2, alpha:alphaVal});
			
			super.scaleItem(percent, alphaVal);
		}
		
		override public function reFresh():void
		{
			super.reFresh();

			iconLoader.width = wid;
			iconLoader.height = hei;
			
			iconLoader.x = 0-wid/2;
			iconLoader.y = 0-hei/2;
			
			var myColorTransform:ColorTransform = new ColorTransform();
    		myColorTransform.color = main.getIconColor();
	
			iconLoader.transform.colorTransform = myColorTransform;
		}
		
		override protected function finish():void
		{
			if(iconLoader is Loader)
			{
				iconLoader.unload();
			}
			
			super.finish();
		}
	}
}