## Stencyl Google Admob Advertising Extension (Openfl)

For Stencyl 3.3 Build 8364 and above

Stencyl extension for "Google AdMob" on iOS and Android. This extension allows you to easily integrate Google Admob on your Stencyl game / application. (http://www.stencyl.com)

## Main Features

  * Banners & Interstitial Support.
  * Setup your banners to be on top or on the bottom of the screen.
  * Allows you to specify min amount of time between interstitial displays (to avoid annoying your users).
  * Allows you to specify min amount of calls to interstitial before it actually gets displayed (to avoid annoying your users).

## How to Install
Download zip file on the right of the screen. ![download](http://www.byrobingames.com/stencyl/heyzap/download.png) on this page  https://github.com/byrobingames/admob<br />

Install the zip file: Go to : http://community.stencyl.com/index.php/topic,30432.0.html

If you have already install a previous version (3.3.3 or lower) of admob, you will see two extension in "Settings->Extensions". This is because of the renamed folder you just downloaded from GitHub.
If this is your case, do the following:
- Go to Settings->Extensions
- Enable the Admob Extension thats not enabled (press green button "Enable")
- Disable the Admob Extension thats not disabled (press red button "Disable")
- Close your Game
- Go to "YOURDOCUMENTFOLDER/stencylworks/engine-extensions/" folder
- Delete the folder "admob" and leave the folder "admob-master"(thats the new folder name)
- Open you Game
- You see can in Settings->Extensions, there is now jus one Admob extension.
- The blocks you already used with previous version subsist.

Or for advanced users:(Not recommended)
- Unzip admob-master.zip you just download
- Rename folder from "admob-master" to "admob"
- Copy the admob folder and paste it in "YOURDOCUMENTFOLDER/stencylworks/engine-extensions/"
- You have to do this every time you download a updated version fom GitHub.

## Documentation and Blocks Example

Go to https://github.com/byrobingames/admob/wiki for documentation and blocks examlpes

**Error on compiling:**<br/>
If you get this error on compiling go to: https://github.com/byrobingames/admob/wiki/4.-Error-on-Compiling to resolve this<br/>

    [openfl] clang: error: linker command failed with exit code 1 (use -v to see invocation)<br/>
    [openfl] ld: symbol(s) not found for architecture arm64<br/>
    [openfl] -[AdmobController initWithBannerID:withGravity:] in libadmobex.a(7f1c4f12_AdMobEx.o)<br/>
    [openfl] -[AdmobController initWithID:] in libadmobex.a(7f1c4f12_AdMobEx.o)<br/>
    [openfl] "_kGADSimulatorID", referenced from:<br/>
    [openfl] -[AdmobController initWithBannerID:withGravity:] in libadmobex.a(7f1c4f12_AdMobEx.o)<br/>
    [openfl] "_kGADAdSizeSmartBannerLandscape", referenced from:<br/>
    [openfl] -[AdmobController initWithBannerID:withGravity:] in libadmobex.a(7f1c4f12_AdMobEx.o)<br/>
    [openfl] "_kGADAdSizeSmartBannerPortrait", referenced from:<br/>
    [openfl] objc-class-ref in libadmobex.a(7f1c4f12_AdMobEx.o)<br/>
    [openfl] "_OBJC_CLASS_$_GADRequest", referenced from:<br/>
    [openfl] objc-class-ref in libadmobex.a(7f1c4f12_AdMobEx.o)<br/>
    [openfl] "_OBJC_CLASS_$_GADInterstitial", referenced from:<br/>
    [openfl] objc-class-ref in libadmobex.a(7f1c4f12_AdMobEx.o)<br/>
    [openfl] "_OBJC_CLASS_$_GADBannerView", referenced from:<br/>

## Donate

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HKLGFCAGKBMFL)<br />

## Disclaimer

Google is a registered trademark of Google Inc. http://unibrander.com/united-states/140279US/google.html

AdMob is a registrered trademark of Google Inc. http://unibrander.com/united-states/479956US/admob.html

## License
build For OpenFl.<br/>
The MIT License (MIT) - [LICENSE.md](LICENSE.md)

Copyright &copy; 2013 SempaiGames (http://www.sempaigames.com)

Author: Federico Bricker

Make it work for Stencyl Game Engine:<br/>
Copyright © 2014 byRobinGames (http://www.byrobingames.com)

Author: Robin Schaafsma
