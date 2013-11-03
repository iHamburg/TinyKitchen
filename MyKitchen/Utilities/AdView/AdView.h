//
//  AdView.h
//  MyeCard
//
//  Created by AppDevelopper on 02.02.13.
//
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "GADBannerView.h"

#define kKeyPathAdDisplaying @"isAdDisplaying"

extern NSString *const NotificationAdChanged;

@interface AdView : UIView<GADBannerViewDelegate,ADBannerViewDelegate, UIGestureRecognizerDelegate>{
	
	ADBannerView *_iadView;
	GADBannerView *_gadView;
    UIView *gateV;
}

+(id)sharedInstance;
+(void)releaseSharedInstance;

@property (nonatomic, assign) BOOL isAdDisplaying;


@end

