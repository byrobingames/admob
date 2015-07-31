/*
 *
 * Created by Robin Schaafsma
 * www.byrobingames.com
 *
 */

#include <AdMobEx.h>
#import <UIKit/UIKit.h>
#import "GoogleMobileAds/GADBannerView.h"
#import "GoogleMobileAds/GADBannerViewDelegate.h"
#import "GoogleMobileAds/GADInterstitial.h"

using namespace admobex;

@interface AdmobController : UIViewController <GADBannerViewDelegate, GADInterstitialDelegate>
{
    GADBannerView *bannerView;
    GADInterstitial *interstitial;
    UIViewController *root;
    
    BOOL bottom;
    BOOL bannerLoaded;
    BOOL bannerFailToLoad;
    BOOL bannerIsClicked;
    
    BOOL interstitialLoaded;
    BOOL interstitialFailToLoad;
    BOOL interstitialClosed;
    BOOL interstitialIsClicked;
}

@property (nonatomic, assign) BOOL bottom;
@property (nonatomic, assign) BOOL bannerLoaded;
@property (nonatomic, assign) BOOL bannerFailToLoad;
@property (nonatomic, assign) BOOL bannerIsClicked;
@property (nonatomic, assign) BOOL interstitialLoaded;
@property (nonatomic, assign) BOOL interstitialFailToLoad;
@property (nonatomic, assign) BOOL interstitialClosed;
@property (nonatomic, assign) BOOL interstitialIsClicked;

@end

@implementation AdmobController

@synthesize bottom;
@synthesize bannerLoaded;
@synthesize bannerFailToLoad;
@synthesize bannerIsClicked;
@synthesize interstitialLoaded;
@synthesize interstitialFailToLoad;
@synthesize interstitialClosed;
@synthesize interstitialIsClicked;

- (id)initWithID:(NSString*)ID
{
    self = [super init];
    NSLog(@"AdMob Init");
    if(!self) return nil;
    interstitial = [[GADInterstitial alloc] initWithAdUnitID:ID];
    interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID ];
    [interstitial performSelector:@selector(loadRequest:) withObject:request afterDelay:1];
    return self;
}

- (void)show
{
    if (interstitial != nil && interstitial.isReady) {
        [interstitial presentFromRootViewController:[[[UIApplication sharedApplication] keyWindow] rootViewController]];
    }
}

/// Called when an interstitial ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    
    interstitialLoaded = YES;
    interstitialFailToLoad = NO;
    NSLog(@"interstitialDidReceiveAd");
}

/// Called when an interstitial ad request failed.
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error
{
    interstitialFailToLoad = YES;
    interstitialLoaded = NO;
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Called just before presenting an interstitial.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad
{
    NSLog(@"interstitialWillPresentScreen");
}

/// Called before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad
{
    NSLog(@"interstitialWillDismissScreen");
}

/// Called just after dismissing an interstitial and it has animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad
{
    interstitialClosed = YES;
    NSLog(@"interstitialDidDismissScreen");
}

/// Called just before the application will background or terminate because the user clicked on an
/// ad that will launch another application (such as the App Store).
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad
{
    interstitialIsClicked = YES;
    NSLog(@"interstitialWillLeaveApplication");
}

-(void)initWithBannerID:(NSString*)bannerID withGravity:(NSString*)GMODE
{
    
    root = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    if( [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft ||
       [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight )
    {
        bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerLandscape];
    }else{
        bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    }
    
    bannerView.adUnitID = bannerID;
    bannerView.rootViewController = root;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID ];
    [bannerView loadRequest:request];
    [root.view addSubview:bannerView];
    
    [bannerView setDelegate:self];
    
    bannerView.hidden=true;
    // set bannerposition
    [self setPosition:GMODE];
    
}

-(void)setPosition:(NSString*)position
{
    
    bottom=[position isEqualToString:@"BOTTOM"];
    
    if (bottom) // Reposition the adView to the bottom of the screen
    {
        CGRect frame = bannerView.frame;
        frame.origin.y = root.view.bounds.size.height - frame.size.height;
        bannerView.frame=frame;
        
    }else // Reposition the adView to the top of the screen
    {
        CGRect frame = bannerView.frame;
        frame.origin.y = 0;
        bannerView.frame=frame;
    }
}

-(void)showBannerAd
{
    bannerView.hidden=false;
}

-(void)hideBannerAd
{
    bannerView.hidden=true;
}

-(void)reloadBanner
{
    [bannerView loadRequest:[GADRequest request]];
}

/// Called when an banner ad request succeeded.
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    bannerLoaded = YES;
    bannerFailToLoad = NO;
    NSLog(@"AdMob: banner ad successfully loaded!");
}

/// Called when an banner ad request failed.
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
{
    bannerFailToLoad = YES;
    bannerLoaded = NO;
    NSLog(@"AdMob: banner failed to load...");
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView
{
    NSLog(@"AdMob: banner was opened.");
}

/// Called before the banner is to be animated off the screen.
- (void)adViewWillDismissScreen:(GADBannerView *)bannerView
{
    NSLog(@"AdMob: banner was closed.");
}

/// Called just before the application will background or terminate because the user clicked on an
/// ad that will launch another application (such as the App Store).
- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView
{
    bannerIsClicked = YES;
    NSLog(@"AdMob: banner made the user leave the game.");
}


@end

namespace admobex {
	
	static AdmobController *adController;
    static NSString *interstitialID;
    
	void init(const char *__BannerID, const char *__InterstitialID, const char *gravityMode, bool testingAds){
        
        if(adController == NULL)
        {
            adController = [[AdmobController alloc] init];
        }
        
        NSString *GMODE = [NSString stringWithUTF8String:gravityMode];
        NSString *bannerID = [NSString stringWithUTF8String:__BannerID];
        interstitialID = [NSString stringWithUTF8String:__InterstitialID];

        if(testingAds){
            interstitialID = @"ca-app-pub-3940256099942544/4411468910"; // ADMOB GENERIC TESTING INTERSTITIAL
            bannerID = @"ca-app-pub-3940256099942544/2934735716"; // ADMOB GENERIC TESTING BANNER
        }
        
        //Banner
        [adController initWithBannerID:bannerID withGravity:GMODE];
        
        // INTERSTITIAL
        [adController initWithID:interstitialID];
    }
    
    void setBannerPosition(const char *gravityMode)
    {
        if(adController != NULL)
        {
            NSString *GMODE = [NSString stringWithUTF8String:gravityMode];
            
            [adController setPosition:GMODE];
        }
    }
    
    void showBanner()
    {
        if(adController != NULL)
        {
            [adController showBannerAd];
        }
        
    }
    
    void hideBanner()
    {
        if(adController != NULL)
        {
            [adController hideBannerAd];
        }
    }
    
	void refreshBanner()
    {
        if(adController != NULL)
        {
            [adController reloadBanner];
        }
	}

    void showInterstitial()
    {
        if(adController!=NULL) [adController show];
        [adController initWithID:interstitialID];
    }
    
//Callbacks
    
    bool bannerLoaded()
    {
        if(adController != NULL)
        {
            if (adController.bannerLoaded)
            {
                adController.bannerLoaded = NO;
                return true;
            }
        }
        return false;
    }
    
    bool bannerFailToLoad()
    {
        if(adController != NULL)
        {
            if (adController.bannerFailToLoad)
            {
                adController.bannerFailToLoad = NO;
                return true;
            }
        }
        return false;
    }
    
    bool bannerIsClicked()
    {
        if(adController != NULL)
        {
            if (adController.bannerIsClicked)
            {
                adController.bannerIsClicked = NO;
                return true;
            }
        }
        return false;
    }
                
                
    bool interstitialLoaded()
    {
        if(adController != NULL)
        {
            if (adController.interstitialLoaded)
            {
                adController.interstitialLoaded = NO;
                return true;
            }
        }
        return false;
    }
    
    bool interstitialFailToLoad()
    {
        if(adController != NULL)
        {
            if (adController.interstitialFailToLoad)
            {
                adController.interstitialFailToLoad = NO;
                return true;
            }
        }
        return false;
    }

    bool interstitialClosed()
    {
        if(adController != NULL)
        {
            if (adController.interstitialClosed)
            {
                adController.interstitialClosed = NO;
                return true;
            }
        }
        return false;
    }
    
    bool interstitialIsClicked()
    {
        if(adController != NULL)
        {
            if (adController.interstitialIsClicked)
            {
                adController.interstitialIsClicked = NO;
                return true;
            }
        }
        return false;
    }

    
}
