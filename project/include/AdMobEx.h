#ifndef ADMOBEX_H
#define ADMOBEX_H


namespace admobex {
	
	
	void init(const char *BannerID, const char *InterstitialID, const char *gravityMode, bool testingAds);
    void setBannerPosition(const char *gravityMode);
	void showBanner();
	void hideBanner();
	void refreshBanner();
	void showInterstitial();
    
    bool bannerLoaded();
    bool bannerFailToLoad();
    bool bannerIsClicked();
    bool interstitialLoaded();
    bool interstitialFailToLoad();
    bool interstitialClosed();
    bool interstitialIsClicked();
    
}


#endif