#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define OPT_LICENSE         @"license"
#define OPT_AD_ID           @"adId"
#define OPT_AD_SIZE         @"adSize"
#define OPT_AD_WIDTH        @"width"
#define OPT_AD_HEIGHT       @"height"
#define OPT_POSITION        @"position"
#define OPT_X               @"x"
#define OPT_Y               @"y"

#define OPT_AUTO_SHOW       @"autoShow"

#define OPT_ORIENTATION_RENEW   @"orientationRenew"
#define OPT_OVERLAP             @"overlap"

#define MILLENNIAL_IPHONE_AD_VIEW_FRAME CGRectMake(0, 0, 320, 50)
#define MILLENNIAL_IPAD_AD_VIEW_FRAME CGRectMake(0, 0, 728, 90)

enum {
    POS_NO_CHANGE       = 0,
    POS_TOP_LEFT        = 1,
    POS_TOP_CENTER      = 2,
    POS_TOP_RIGHT       = 3,
    POS_LEFT            = 4,
    POS_CENTER          = 5,
    POS_RIGHT           = 6,
    POS_BOTTOM_LEFT     = 7,
    POS_BOTTOM_CENTER   = 8,
    POS_BOTTOM_RIGHT    = 9,
    POS_XY              = 10
};

@protocol MMediaEventDelegate <NSObject>
@required
-(UIView*) getView;
-(UIViewController*) getViewController;
-(void) onEvent:(NSString*) eventType withData:(NSString*) jsonString;
-(void) evalJs:(NSString*) js;
@end

@interface MMediaAds : NSObject

- (MMediaAds*) init:(id<MMediaEventDelegate>) theDelegate;

- (void) setOptions:(NSDictionary*) options;

- (void) createBanner:(NSString*)adId;
- (void) showBanner:(int)position;
- (void) showBannerAtX:(int)x withY:(int)y;
- (void) hideBanner;
- (void) removeBanner;

- (void) prepareInterstitial:(NSString*)adId;
- (void) showInterstitial;

@end
