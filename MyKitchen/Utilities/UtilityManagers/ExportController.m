//
//  ExportController.m
//  FirstThings_Uni
//
//  Created by  on 12.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "ExportController.h"
#import "TKRootViewController.h"

@implementation ExportController

+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	
	return sharedInstance;
	
}

- (id)init{
	if (self = [super init]) {
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(handleWillEnterForeground)
													 name:UIApplicationWillEnterForegroundNotification
												   object: [UIApplication sharedApplication]];
	}
	return self;
}


#pragma mark - Notification
- (void)handleWillEnterForeground{
//	L();
	int rate = [[NSUserDefaults standardUserDefaults] integerForKey:@"rate"];
	NSLog(@"rate:%d",rate);
	
	if (rate > 1) {
		[self showRateAlert];
	}
	else if (rate != -1) {
		
		[[NSUserDefaults standardUserDefaults] setInteger:rate+1 forKey:@"rate"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
	}
	
}

#pragma mark - Email


- (void)sendEmail:(NSDictionary *)info{
	[[LoadingView sharedLoadingView] removeView];
	
	mailPicker = [[MFMailComposeViewController alloc] init];
	mailPicker.mailComposeDelegate = self;
	
	NSString *emailBody = [info objectForKey:@"emailBody"];
	NSString *subject = [info objectForKey:@"subject"];
	NSArray *toRecipients = [info objectForKey:@"toRecipients"];
	NSArray *ccRecipients = [info objectForKey:@"ccRecipients"];
	NSArray *bccRecipients = [info objectForKey:@"bccRecipients"];
	NSArray *attachment = [info objectForKey:@"attachment"]; //0: nsdata, 1: mimetype, 2: filename
	
	[mailPicker setMessageBody:emailBody isHTML:YES];
	[mailPicker setSubject:subject];
    [mailPicker setToRecipients:toRecipients];
	[mailPicker setCcRecipients:ccRecipients];
	[mailPicker setBccRecipients:bccRecipients];
	
	
	if (!ISEMPTY(attachment)) {
		
		[mailPicker addAttachmentData:[attachment objectAtIndex:0] mimeType:[attachment objectAtIndex:1] fileName:[attachment objectAtIndex:2]];
	}
	
	
	[[TKRootViewController sharedInstance] presentModalViewController:mailPicker animated:NO];
}


- (void)mailComposeController:(MFMailComposeViewController *)controller

		  didFinishWithResult:(MFMailComposeResult)result

						error:(NSError *)error

{
	
	L();
	
    [controller dismissModalViewControllerAnimated:NO];
//	
//	if (result == MFMailComposeResultSent) {
//		if(isPaid())
//			[Flurry logEvent:@"Email Sent"];
//		else 
//			[Flurry logEvent:@"Free Email Sent"];
//		
//		// if already sent 3 email, show rate
//		// if rate = -1->return
//		//           0 - 2, rate++
//		//           3  -> showalert
//		int rate = [[NSUserDefaults standardUserDefaults] integerForKey:@"rate"];
//		//		NSLog(@"rate:%d",rate);
//		
//		if (rate == -1) {
//			return;
//			
//		}
//		else  {
//			[[NSUserDefaults standardUserDefaults] setInteger:rate+1 forKey:@"rate"];
//			[[NSUserDefaults standardUserDefaults] synchronize];
//			
//			return;
//		}
//		
//	}
	
}

#pragma mark - Tweet

- (void)sendTweetWithText:(NSString*)text image:(UIImage*)image{
	[[LoadingView sharedLoadingView]removeView];
	
	// Set up the built-in twitter composition view controller.
	if (!tweetViewController) {
		tweetViewController = [[TWTweetComposeViewController alloc] init];
	}
    
    
	// 如果没有image
//	if (!image) {
//        image = kQRImage;
//    }
//    
	[tweetViewController addImage:image];
	if (!ISEMPTY(text)) {
		[tweetViewController setInitialText:text];
        
	}
	else{
		[tweetViewController setInitialText:@"via Tiny Kitchen"];
        
	}
    
    // Create the completion handler block.
    [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
        //        NSString *output;
        //
        //        switch (result) {
        //            case TWTweetComposeViewControllerResultCancelled:
        //                // The cancel button was tapped.
        //                output = @"Tweet cancelled.";
        //                break;
        //            case TWTweetComposeViewControllerResultDone:
        //                // The tweet was sent.
        //                output = @"Tweet done.";
        //				//				[FlurryAnalytics logEvent:@"Tweet sent"];
        //                break;
        //            default:
        //                break;
        //        }
		
        [[TKRootViewController sharedInstance] dismissModalViewControllerAnimated:YES];
    }];
    
    // Present the tweet composition view controller modally.
    [[TKRootViewController sharedInstance] presentModalViewController:tweetViewController animated:YES];
	
}

#pragma mark - Rate
- (void)toRate{
	
	int appId = isPaid()?540869085:540878802;
	
	NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",  
					 appId];   
	  
	
	//  
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]]; 
}

- (void)showRateAlert{
	
	L();
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:isPad?@"Dear user":nil message:isPad?SRateMsgPad:SRateMsgPhone delegate:self 
											  cancelButtonTitle:@"No, thanks" otherButtonTitles:@"Rate now",@"Remind me later",nil];
	
	
	[alertView show];
	
	
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
	
	//	      NSLog(@"button:%d",buttonIndex);  //cancel:0
	
	if (buttonIndex == 0) { // never
		[[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"rate"];
	}
	else if(buttonIndex == 1){ // rate now
		
		NSLog(@"rate now");
		[[ExportController sharedInstance] toRate];
		[[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"rate"];
		
		
	}
	else if(buttonIndex == 2){ // rate later
		[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"rate"];
	}
	
	[[NSUserDefaults standardUserDefaults] synchronize];
	
}


#pragma mark -

- (void)linkToAppStoreWithID:(NSString*)appID{
    NSString *urlStr =[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?mt=8",appID];
	
	NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [[UIApplication sharedApplication]openURL:url];
}


@end
