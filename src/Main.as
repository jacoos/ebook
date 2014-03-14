package src 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import src.pageflip.PageFlipClass;
	import src.pageflip.PageFlipSingle;
	
	/**
	 * ...
	 * @author SJ  jacoos@126.com
	 */
	public class Main extends MovieClip 
	{
		private var mypageflip:PageFlipClass = new PageFlipClass();
		private var totalpage:int;
		private var initpage:int = 0;
		private var bookContainer:MovieClip;
		private var bookWidth:Number;
		private var bookHeight:Number;
		private var xml:XML;
		private var loader:URLLoader;
		
		private var mypageflipSg:PageFlipSingle = new PageFlipSingle();
		private var totalpageSg:int;
		private var initpageSg:int = 0;
		private var bookContainerSg:MovieClip;
		private var xmlSg:XML;
		
		public var btnSwitch:SimpleButton;
		private var booSwitch:Boolean = true;
		
		public function Main() 
		{
			if (stage) init();
			else this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event = null):void
		{
			loader = new URLLoader(new URLRequest("assets/pages.xml"));
			loader.addEventListener(Event.COMPLETE, onLoaded);
		}
		private function onLoaded(e:Event):void
		{
			xml = XML(loader.data);
			loader.removeEventListener(Event.COMPLETE, onLoaded);
			totalpage = xml.child("page").length();
			
			bookWidth = xml.attribute("width");
			bookHeight = xml.attribute("height");
			bookContainer = new MovieClip();
			this.addChild(bookContainer);
			bookContainer.x = (stage.stageWidth - 2*bookWidth) * 0.5;
			bookContainer.y = (stage.stageHeight - bookHeight) * 0.5;
			
			mypageflip.myXML = xml;
			mypageflip.book_totalpage = totalpage;
			mypageflip.book_root = bookContainer;
			mypageflip.book_TimerNum = 20;
			mypageflip.book_initpage = initpage;
			mypageflip.onLoadinit=onLoadinit;
			mypageflip.onLoading=onLoading;
			mypageflip.onLoadEnd=onLoadEnd;
			mypageflip.onPageEnd=onPageEnd;
			
			mypageflip.InitBook();
			
			//------single page-----------------
			xmlSg = XML(loader.data);
			for (var i:int = 0; i <totalpage; i++)
			{
				xmlSg.insertChildBefore(xmlSg.child("page")[i*2+1], xmlSg.child("pageblack").child("page"));
			}
			
			totalpageSg = xmlSg.child("page").length();
			trace(totalpageSg);
			bookContainerSg = new MovieClip();
			this.addChild(bookContainerSg);
			bookContainerSg.x = (stage.stageWidth - 3*bookWidth) * 0.5;
			bookContainerSg.y = (stage.stageHeight - bookHeight) * 0.5;
			
			mypageflipSg.myXML = xmlSg;
			mypageflipSg.book_totalpage = totalpageSg;
			mypageflipSg.book_root = bookContainerSg;
			mypageflipSg.book_TimerNum = 20;
			mypageflipSg.book_initpage = initpage;
			mypageflipSg.onLoadinit=onLoadinit;
			mypageflipSg.onLoading=onLoading;
			mypageflipSg.onLoadEnd=onLoadEnd;
			mypageflipSg.onPageEnd=onPageEnd;
			
			mypageflipSg.InitBook();
			
			initBtns();
			
		}
		private function initBtns():void
		{
			btnSwitch.addEventListener(MouseEvent.CLICK, onSwitch);
		}
		private function onSwitch(e:MouseEvent):void
		{
			bookContainer.visible = booSwitch;
			bookContainerSg.visible = !booSwitch;
			booSwitch = !booSwitch;
		}
		
		private function onLoadinit($page:MovieClip):void
		{
			//$page.addChild(loading);
		}
		private function onLoading($page:MovieClip,$loadedPercent:Number):void
		{
			//show $loadpercent
			trace($loadedPercent);
		}
		private function onLoadEnd($page:MovieClip):void
		{
			//$page.removeChild(loading);
			trace("loadend....");
		}
		private function onPageEnd():void
		{
			
		}
		
	}

}