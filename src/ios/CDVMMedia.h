#import <Cordova/CDV.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MMediaAds.h"

#pragma mark MMedia Plugin

@interface CDVMMedia : CDVPlugin <MMediaEventDelegate> {
}

- (void) setOptions:(CDVInvokedUrlCommand *)command;

- (void)createBanner:(CDVInvokedUrlCommand *)command;
- (void)showBanner:(CDVInvokedUrlCommand *)command;
- (void)showBannerAtXY:(CDVInvokedUrlCommand *)command;
- (void)hideBanner:(CDVInvokedUrlCommand *)command;
- (void)removeBanner:(CDVInvokedUrlCommand *)command;

- (void)prepareInterstitial:(CDVInvokedUrlCommand *)command;
- (void)showInterstitial:(CDVInvokedUrlCommand *)command;

@end
