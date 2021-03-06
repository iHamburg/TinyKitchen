//
//  Info2ViewController.m
//  InstaMagazine
//
//  Created by AppDevelopper on 13.10.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "InfoViewController.h"
#import "Utilities.h"
#import "MoreApp.h"
#import "ExportController.h"
#import <QuartzCore/QuartzCore.h>
//#import "FacebookManager.h"

@interface InfoViewController ()

@end

@implementation InfoViewController



- (void)loadView{

		
	self.view = [[UIView alloc] initWithFrame:_r];
	
	
	NSArray *moreAppNames;
	if (isPad) {
		moreAppNames = @[@"myecard",@"tinykitchen",@"nsc"];
	}
	else{
		moreAppNames = @[@"myecard",@"instahat",@"tinykitchen",@"nsc"];
	}

	NSString *moreAppsPlistPath = [[NSBundle mainBundle] pathForResource:@"MoreApps.plist" ofType:nil];
	NSDictionary *moreAppsDict = [NSDictionary dictionaryWithContentsOfFile:moreAppsPlistPath];
	moreApps = [NSMutableArray array];
	for (NSString *name in moreAppNames) {
		MoreApp *app = [[MoreApp alloc]initWithName:name dictionary:moreAppsDict[name]];
		[moreApps addObject:app];
	}
}



- (NSUInteger)supportedInterfaceOrientations{
    
	return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}


- (void)dealloc{
    L();

}

#pragma mark - IBAction
- (IBAction)buttonClicked:(id)sender{
	L();
//	UIButton *b = sender;
//	selectedIndex = [sender tag]-1;
//	
//	MoreApp *app = moreApps[selectedIndex];
//
//	ribbon.frame = CGRectMake(b.center.x-ribbon.width/2, CGRectGetMaxY(b.frame)-(isPad?5:1), ribbon.width, ribbon.height);
//
//	[scrollView insertSubview:ribbon belowSubview:b];
//	
//	textV.text = app.description;
//	otherAppL.text = app.title;
//	[textV setContentOffset:CGPointMake(0, 0)];
}

#pragma mark -

- (void)back{
//	NSLog(@"info # %@",self);
    [_delegate infoVCWillClose:self];
}

- (void)toInstruction{


		instructionVC = [[InstructionViewController alloc]init];
		instructionVC.view.frame = self.view.bounds;
		instructionVC.delegate = self;
	
	[self.view addSubview:instructionVC.view];
}

- (void)rateUs{
    [[ExportController sharedInstance]toRate];
}

- (void)instructionVCWillDismiss:(InstructionViewController *)vc{
	[vc.view removeFromSuperview];
}

- (void)aboutus{
    
    validator = [[ParentalGateValidator alloc] init];
    validator.completionHandler = ^(BOOL completed){
        if (completed) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.xappsoft.de/index.php?lang=en"]];
            
        }
    };
    
    [validator validate];

}
- (void)tweetus{
	


    
    validator = [[ParentalGateValidator alloc] init];
    validator.completionHandler = ^(BOOL completed){
        if (completed) {
            	[[ExportController sharedInstance]sendTweetWithText:STwitter image:nil];
        }
    };
    
    [validator validate];

}

- (void)facebook{
	

//	[[FacebookManager sharedInstance]feed];
}
- (void)email{
	   
    validator = [[ParentalGateValidator alloc] init];
    validator.completionHandler = ^(BOOL completed){
        if (completed) {
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  SRecommendEmailTitle, @"subject",
                                  @"",@"emailBody",
                                  nil];
            
            [[ExportController sharedInstance] sendEmail:dict];
        }
    };
    
    [validator validate];

	
}
- (void)supportEmail{
	

    
    validator = [[ParentalGateValidator alloc] init];
    validator.completionHandler = ^(BOOL completed){
        if (completed) {
            
         	
            NSDictionary *dict2 = @{
                                    @"subject": SSupportEmailTitle,
                                    @"toRecipients": @[@"support@xappsoft.de"]
                                    };
            
            
            [[ExportController sharedInstance] sendEmail:dict2];
        }
    };
    
    [validator validate];
}


- (void)appstore{

    MoreApp *app = moreApps[selectedIndex];
    NSString *appid = app.fAppid;
    
    validator = [[ParentalGateValidator alloc] init];
    validator.completionHandler = ^(BOOL completed){
        if (completed) {
            
         	
            
            NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/de/app/id%@&mt=8",appid];
            NSURL *url = [NSURL URLWithString: [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF16StringEncoding]];
            
            
            [[UIApplication sharedApplication] openURL:url];
        }
    };
    
    [validator validate];
	
}

- (void)selectApp:(MoreApp*)app{
    
    NSString *appid = isPaid()?app.pAppid:app.fAppid;
    
    [[ExportController sharedInstance]linkToAppStoreWithID:appid];
}
@end
