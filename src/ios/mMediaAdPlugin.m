//
//  mMediaAdPlugin.m
//  TestAdMobCombo
//
//  Created by Xie Liming on 14-11-10.
//
//

#import "mMediaAdPlugin.h"

#import <MillennialMedia/MMAdView.h>
#import <MillennialMedia/MMInterstitial.h>

#define TEST_BANNER_ID           @"177365"
#define TEST_INTERSTITIAL_ID     @"177364"

#define MILLENNIAL_IPHONE_AD_VIEW_FRAME CGRectMake(0, 0, 320, 50)
#define MILLENNIAL_IPAD_AD_VIEW_FRAME CGRectMake(0, 0, 728, 90)

@interface mMediaAdPlugin()

@end


@implementation mMediaAdPlugin

- (void)pluginInitialize
{
    [super pluginInitialize];

    // Notification will fire when an ad causes the application to terminate or enter the background
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminateFromAd:)
                                                 name:MillennialMediaAdWillTerminateApplication
                                               object:nil];
    
    // Notification will fire when an ad is tapped.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adWasTapped:)
                                                 name:MillennialMediaAdWasTapped
                                               object:nil];
    
    // Notification will fire when an ad modal will appear.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adModalWillAppear:)
                                                 name:MillennialMediaAdModalWillAppear
                                               object:nil];
    
    // Notification will fire when an ad modal did appear.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adModalDidAppear:)
                                                 name:MillennialMediaAdModalDidAppear
                                               object:nil];
    
    // Notification will fire when an ad modal will dismiss.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adModalWillDismiss:)
                                                 name:MillennialMediaAdModalWillDismiss
                                               object:nil];
    
    // Notification will fire when an ad modal did dismiss.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adModalDidDismiss:)
                                                 name:MillennialMediaAdModalDidDismiss
                                               object:nil];
}

- (void) parseOptions:(NSDictionary *)options
{
    [super parseOptions:options];
    
}

- (NSString*) __getProductShortName
{
    return @"mMedia";
}

- (NSString*) __getTestBannerId
{
    return TEST_BANNER_ID;
}

- (NSString*) __getTestInterstitialId
{
    return TEST_INTERSTITIAL_ID;
}

- (UIView*) __createAdView:(NSString*)adId;
{
    if(self.isTesting) adId = TEST_BANNER_ID;
    
    CGRect rect = MILLENNIAL_IPHONE_AD_VIEW_FRAME;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        rect = MILLENNIAL_IPAD_AD_VIEW_FRAME;
    }
    
    MMAdView* ad = [[MMAdView alloc] initWithFrame:rect
                                              apid:adId
                                rootViewController:[self getViewController]];
    
    
    return ad;
}

- (int) __getAdViewWidth:(UIView*)view
{
    if([view class] == [MMAdView class]) {
        MMAdView* ad = (MMAdView*) view;
        return ad.frame.size.width;
    }
    return 320;
}

- (int) __getAdViewHeight:(UIView*)view
{
    if([view class] == [MMAdView class]) {
        MMAdView* ad = (MMAdView*) view;
        return ad.frame.size.height;
    }
    return 50;
}

- (void) __loadAdView:(UIView*)view
{
    if([view isKindOfClass:[MMAdView class]]) {
        MMAdView* ad = (MMAdView*) view;
        [ad getAd:^(BOOL success, NSError *error) {
            if(success) {
                if((! self.bannerVisible) && self.autoShowBanner) {
                    [self __showBanner:self.adPosition atX:self.posX atY:self.posY];
                }
                [self fireAdEvent:EVENT_AD_LOADED withType:ADTYPE_BANNER];
            } else {
                [self fireAdErrorEvent:EVENT_AD_FAILLOAD withCode:(int)error.code withMsg:[error localizedDescription] withType:ADTYPE_BANNER];
            }
        }];
    }
}

- (void) __pauseAdView:(UIView*)view
{
    if([view isKindOfClass:[MMAdView class]]) {
        //MMAdView* ad = (MMAdView*) view;
        // [ad pause];
    }
}

- (void) __resumeAdView:(UIView*)view
{
    if([view isKindOfClass:[MMAdView class]]) {
        //MMAdView* ad = (MMAdView*) view;
        // [ad resume];
    }
}

- (void) __destroyAdView:(UIView*)view
{
    if([view isKindOfClass:[MMAdView class]]) {
        //MMAdView* ad = (MMAdView*) view;
        // [ad destroy];
    }
}

- (NSObject*) __createInterstitial:(NSString*)adId
{
    if(self.isTesting) adId = TEST_INTERSTITIAL_ID;
    
    return adId;
}

- (void) __loadInterstitial:(NSObject*)interstitial
{
    if([interstitial isKindOfClass:[NSString class]]) {
        NSString* adId = (NSString*) interstitial;
        [MMInterstitial fetchWithRequest:[MMRequest request]
                                    apid:adId
                            onCompletion:^(BOOL success, NSError *error) {
            if(success) {
                if(self.autoShowInterstitial) {
                    [self __showInterstitial:interstitial];
                    [self fireAdEvent:EVENT_AD_LOADED withType:ADTYPE_INTERSTITIAL];
                }
            } else {
                [self fireAdErrorEvent:EVENT_AD_FAILLOAD
                              withCode:(int)error.code
                               withMsg:[error localizedDescription]
                              withType:ADTYPE_INTERSTITIAL];
            }
        }];
    }
}

- (void) __showInterstitial:(NSObject*)interstitial
{
    if([interstitial isKindOfClass:[NSString class]]) {
        NSString* adId = (NSString*) interstitial;
        if([MMInterstitial isAdAvailableForApid:adId]) {
            [MMInterstitial displayForApid:adId
                        fromViewController:[self getViewController]
                           withOrientation:MMOverlayOrientationTypeAll
                              onCompletion:^(BOOL success, NSError *error) {
                                  if(success) {
                                      //[self fireAdEvent:EVENT_AD_PRESENT withType:ADTYPE_INTERSTITIAL];
                                  }
                              }];
        }
    }
}

- (void) __destroyInterstitial:(NSObject*)interstitial
{
    if([interstitial isKindOfClass:[NSString class]]) {
        //NSString* adId = (NSString*) interstitial;
        // nothing to do
    }
}

- (void)adWasTapped:(NSNotification *)notification {
    NSString* adType = ([[notification userInfo] objectForKey:MillennialMediaAdObjectKey] == self.banner) ? ADTYPE_BANNER : ADTYPE_INTERSTITIAL;
    [self fireAdEvent:EVENT_AD_LEAVEAPP withType:adType];
}

- (void)applicationWillTerminateFromAd:(NSNotification *)notification {
    NSLog(@"AD WILL OPEN SAFARI");
    // No User Info is passed for this notification
}

- (void)adModalWillDismiss:(NSNotification *)notification {
    NSString* adType = ([[notification userInfo] objectForKey:MillennialMediaAdObjectKey] == self.banner) ? ADTYPE_BANNER : ADTYPE_INTERSTITIAL;
    [self fireAdEvent:EVENT_AD_WILLDISMISS withType:adType];
}

- (void)adModalDidDismiss:(NSNotification *)notification {
    NSString* adType = ([[notification userInfo] objectForKey:MillennialMediaAdObjectKey] == self.banner) ? ADTYPE_BANNER : ADTYPE_INTERSTITIAL;
    [self fireAdEvent:EVENT_AD_DISMISS withType:adType];
}

- (void)adModalWillAppear:(NSNotification *)notification {
    NSString* adType = ([[notification userInfo] objectForKey:MillennialMediaAdObjectKey] == self.banner) ? ADTYPE_BANNER : ADTYPE_INTERSTITIAL;
    [self fireAdEvent:EVENT_AD_WILLPRESENT withType:adType];
}

- (void)adModalDidAppear:(NSNotification *)notification {
    NSString* adType = ([[notification userInfo] objectForKey:MillennialMediaAdObjectKey] == self.banner) ? ADTYPE_BANNER : ADTYPE_INTERSTITIAL;
    [self fireAdEvent:EVENT_AD_PRESENT withType:adType];
}

@end
