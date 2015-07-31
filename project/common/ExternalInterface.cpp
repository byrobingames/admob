#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif


#include <hx/CFFI.h>
#include "AdMobEx.h"

using namespace admobex;


static value admobex_init(value banner_id,value interstitial_id, value gravity_mode, value testing_ads){
	init(val_string(banner_id),val_string(interstitial_id), val_string(gravity_mode), val_bool(testing_ads));
	return alloc_null();
}
DEFINE_PRIM(admobex_init,4);

static value admobex_banner_show(){
	showBanner();
	return alloc_null();
}
DEFINE_PRIM(admobex_banner_show,0);

static value admobex_banner_hide(){
	hideBanner();
	return alloc_null();
}
DEFINE_PRIM(admobex_banner_hide,0);

static value admobex_banner_refresh(){
	refreshBanner();
	return alloc_null();
}
DEFINE_PRIM(admobex_banner_refresh,0);


extern "C" void admobex_main () {	
	val_int(0); // Fix Neko init
	
}
DEFINE_ENTRY_POINT (admobex_main);


static value admobex_interstitial_show(){
	showInterstitial();
	return alloc_null();
}
DEFINE_PRIM(admobex_interstitial_show,0);

static value admobex_banner_move(value gravity_mode){
    setBannerPosition(val_string(gravity_mode));
    return alloc_null();
}
DEFINE_PRIM(admobex_banner_move,1);

//callbacks
static value admobex_banner_loaded()
{
    if (admobex::bannerLoaded())
        return val_true;
    return val_false;
}
DEFINE_PRIM(admobex_banner_loaded, 0);

static value admobex_banner_failed()
{
    if (admobex::bannerFailToLoad())
        return val_true;
    return val_false;
}
DEFINE_PRIM(admobex_banner_failed, 0);

static value admobex_banner_clicked()
{
    if (admobex::bannerIsClicked())
        return val_true;
    return val_false;
}
DEFINE_PRIM(admobex_banner_clicked, 0);

static value admobex_interstitial_loaded()
{
    if (admobex::interstitialLoaded())
        return val_true;
    return val_false;
}
DEFINE_PRIM(admobex_interstitial_loaded, 0);

static value admobex_interstitial_failed()
{
    if (admobex::interstitialFailToLoad())
        return val_true;
    return val_false;
}
DEFINE_PRIM(admobex_interstitial_failed, 0);

static value admobex_interstitial_closed()
{
    if (admobex::interstitialClosed())
        return val_true;
    return val_false;
}
DEFINE_PRIM(admobex_interstitial_closed, 0);

static value admobex_interstitial_clicked()
{
    if (admobex::interstitialIsClicked())
        return val_true;
    return val_false;
}
DEFINE_PRIM(admobex_interstitial_clicked, 0);



extern "C" int admobex_register_prims () { return 0; }
