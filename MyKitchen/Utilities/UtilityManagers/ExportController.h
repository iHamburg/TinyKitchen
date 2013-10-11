//
//  ExportController.h
//  FirstThings_Uni
//
//  Created by  on 12.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <Twitter/Twitter.h>
#import "Utilities.h"
#import "Flurry.h"
#import "LoadingView.h"

@interface ExportController : NSObject<MFMailComposeViewControllerDelegate, UIAlertViewDelegate>{
	MFMailComposeViewController *mailPicker;
    TWTweetComposeViewController *tweetViewController;
}


+(id)sharedInstance;

- (void)sendEmail:(NSDictionary *)info;
- (void)sendTweetWithText:(NSString*)text image:(UIImage*)image;

- (void)toRate;
- (void)showRateAlert;

- (void)linkToAppStoreWithID:(NSString*)appID;
@end
