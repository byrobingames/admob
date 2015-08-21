package;

import openfl.Lib;

class AdMob {

	private static var initialized:Bool=false;
	private static var testingAds:Bool=false;
	private static var gravityMode:String;

	///////////////////////////////////////////////////////////////////////////
	
	private static var __init:String->String->String->Bool->Void = function(bannerId:String, interstitialId:String, gravityMode:String, testingAds:Bool){};
	private static var __showBanner:Void->Void = function(){};
	private static var __hideBanner:Void->Void = function(){};
	private static var __showInterstitial:Void->Void = function(){};
	private static var __onResize:Void->Void = function(){};
	private static var __refresh:Void->Void = function(){};
	private static var __setBannerPosition:String->Void = function(gravityMode:String){};
	
	private static var __bannerLoaded:Dynamic;
	private static var __bannerFailedToLoad:Dynamic;
	private static var __bannerClicked:Dynamic;
	
	private static var __interstitialLoaded:Dynamic;
	private static var __interstitialFailedToLoad:Dynamic;
	private static var __interstitialClosed:Dynamic;
	private static var __interstitialClicked:Dynamic;


	////////////////////////////////////////////////////////////////////////////

	private static var lastTimeInterstitial:Int = -60*1000;
	private static var displayCallsCounter:Int = 0;
	
	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////

	public static function showInterstitial(minInterval:Int=60, minCallsBeforeDisplay:Int=0) {
		displayCallsCounter++;
		if( (Lib.getTimer()-lastTimeInterstitial)<(minInterval*1000) ) return;
		if( minCallsBeforeDisplay > displayCallsCounter ) return;
		displayCallsCounter = 0;
		lastTimeInterstitial = Lib.getTimer();
		try{
			__showInterstitial();
		}catch(e:Dynamic){
			trace("ShowInterstitial Exception: "+e);
		}
	}
	
	public static function init(bannerId:String, interstitialId:String, position:Int, mode:Int){
	
		if(position == 1)
		{
			gravityMode = "TOP";
		}else
		{
			gravityMode = "BOTTOM";
		}
		if(mode == 1)
		{
			testingAds = true;
		}
	
		#if ios
		if(initialized) return;
		initialized = true;
		try{
			// CPP METHOD LINKING
			__init = cpp.Lib.load("adMobEx","admobex_init",4);
			__showBanner = cpp.Lib.load("adMobEx","admobex_banner_show",0);
			__hideBanner = cpp.Lib.load("adMobEx","admobex_banner_hide",0);
			__showInterstitial = cpp.Lib.load("admobex","admobex_interstitial_show",0);
			__refresh = cpp.Lib.load("adMobEx","admobex_banner_refresh",0);
			__setBannerPosition = cpp.Lib.load("admobex","admobex_banner_move",1);
			__bannerLoaded = cpp.Lib.load("admobex","admobex_banner_loaded",0);
			__bannerFailedToLoad = cpp.Lib.load("admobex","admobex_banner_failed",0);
			__bannerClicked = cpp.Lib.load("admobex","admobex_banner_clicked",0);
			__interstitialLoaded = cpp.Lib.load("admobex","admobex_interstitial_loaded",0);
			__interstitialFailedToLoad = cpp.Lib.load("admobex","admobex_interstitial_failed",0);
			__interstitialClosed = cpp.Lib.load("admobex","admobex_interstitial_closed",0);
			__interstitialClicked = cpp.Lib.load("admobex","admobex_interstitial_clicked",0);

			__init(bannerId,interstitialId,gravityMode,testingAds);
		}catch(e:Dynamic){
			trace("iOS INIT Exception: "+e);
		}
		#end
		
		#if android
		if(initialized) return;
		initialized = true;
		try{
			// JNI METHOD LINKING
			__init = openfl.utils.JNI.createStaticMethod("com/byrobin/admobex/AdMobEx", "init", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V");
			__showBanner = openfl.utils.JNI.createStaticMethod("com/byrobin/admobex/AdMobEx", "showBanner", "()V");
			__hideBanner = openfl.utils.JNI.createStaticMethod("com/byrobin/admobex/AdMobEx", "hideBanner", "()V");
			__showInterstitial = openfl.utils.JNI.createStaticMethod("com/byrobin/admobex/AdMobEx", "showInterstitial", "()V");
			__onResize = openfl.utils.JNI.createStaticMethod("com/byrobin/admobex/AdMobEx", "onResize", "()V");
			__setBannerPosition = openfl.utils.JNI.createStaticMethod("com/byrobin/admobex/AdMobEx", "setBannerPosition", "(Ljava/lang/String;)V");

			__init(bannerId,interstitialId,gravityMode,testingAds);
		}catch(e:Dynamic){
			trace("Android INIT Exception: "+e);
		}
		#end
	}
	
	public static function showBanner() {
		try {
			__showBanner();
		} catch(e:Dynamic) {
			trace("ShowAd Exception: "+e);
		}
	}
	
	public static function hideBanner() {
		try {
			__hideBanner();
		} catch(e:Dynamic) {
			trace("HideAd Exception: "+e);
		}
	}
	
	public static function onResize() {
	
		#if ios
		try{
			__refresh();
		}catch(e:Dynamic){
			trace("onResize Exception: "+e);
		}
		#end
		#if android
		try{
			__onResize();
		}catch(e:Dynamic){
			trace("onResize Exception: "+e);
		}
		#end
	}
	
	public static function setBannerPosition(position:Int) {
	
		if(position == 1)
		{
			gravityMode = "TOP";
		}else
		{
			gravityMode = "BOTTOM";
		}
		
		try{
			__setBannerPosition(gravityMode);
		}catch(e:Dynamic){
			trace("setBannerPosition Exception: "+e);
		}
	}
	
	
	public static function getBannerInfo(info:Int):Bool{
        if (info == 0)
        {
			#if ios
           	 return __bannerLoaded();
            #end
			
			#if android
            	if (__bannerLoaded == null)
            	{
                	__bannerLoaded = openfl.utils.JNI.createStaticMethod("com/byrobin/admobex/AdMobEx", "bannerIsLoaded", "()Z", true);
            	}
            	return __bannerLoaded();
            #end			
	
        }
        else if (info == 1)
        {
			#if ios
           		return __bannerFailedToLoad();
            #end
			
			#if android
            	if (__bannerFailedToLoad == null)
            	{
                	__bannerFailedToLoad = openfl.utils.JNI.createStaticMethod("com/byrobin/admobex/AdMobEx", "bannerFailedToLoad", "()Z", true);
            	}
            	return __bannerFailedToLoad();
            #end
				
        }
        else
        {
			#if ios
           		return __bannerClicked();
            #end
			
			#if android
            	if (__bannerClicked == null)
            	{
                	__bannerClicked = openfl.utils.JNI.createStaticMethod("com/byrobin/admobex/AdMobEx", "bannerClicked", "()Z", true);
            	}
            	return __bannerClicked();
            #end
		}

        return false;
    }
	
	public static function getInterstitialInfo(info:Int):Bool{
        if (info == 0)
        {
			#if ios
           	 return __interstitialLoaded();
            #end
			
			#if android
            	if (__interstitialLoaded == null)
            	{
                	__interstitialLoaded = openfl.utils.JNI.createStaticMethod("com/byrobin/admobex/AdMobEx", "interstitialIsLoaded", "()Z", true);
            	}
            	return __interstitialLoaded();
            #end			
	
        }
        else if (info == 1)
        {
			#if ios
           		return __interstitialFailedToLoad();
            #end
			
			#if android
            	if (__interstitialFailedToLoad == null)
            	{
                	__interstitialFailedToLoad = openfl.utils.JNI.createStaticMethod("com/byrobin/admobex/AdMobEx", "interstitialFailedToLoad", "()Z", true);
            	}
            	return __interstitialFailedToLoad();
            #end
				
        }else if (info == 2)
        {
			#if ios
           		return __interstitialClosed();
            #end
			
			#if android
            	if (__interstitialClosed == null)
            	{
                	__interstitialClosed = openfl.utils.JNI.createStaticMethod("com/byrobin/admobex/AdMobEx", "interstitialClosed", "()Z", true);
            	}
            	return __interstitialClosed();
            #end
		}
        else
        {
			#if ios
           		return __interstitialClicked();
            #end
			
			#if android
            	if (__interstitialClicked == null)
            	{
                	__interstitialClicked = openfl.utils.JNI.createStaticMethod("com/byrobin/admobex/AdMobEx", "interstitialClicked", "()Z", true);
            	}
            	return __interstitialClicked();
            #end
		}

        return false;
    }
	
}
