//
//  MoreAppViewController.h
//  KidsLearn
//
//  Created by  on 04.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
#import "RootViewController.h"
#import "MoreAppView.h"

@interface MoreAppViewController : UIViewController<MoreAppViewDelegate>{
	IBOutlet UIImageView *bgV;
	IBOutlet UIButton *backB;
	UIScrollView *scrollView;
	IBOutlet UIImageView *imgV1,*imgV2,*imgV3;
	UIView *bar1, *bar2, *bar3;
	UITextView *t1, *t2, *t3;
	UIImageView *icon1, *icon2, *icon3;
	
	MoreAppView *v1,*v2,*v3;
}

@property (nonatomic, unsafe_unretained) RootViewController *rootVC;

- (IBAction)toApp1:(id)sender;
- (IBAction)toApp2:(id)sender;
- (IBAction)toApp3:(id)sender;
- (IBAction)back:(id)sender;

@end
