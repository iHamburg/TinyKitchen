//
//  RootViewController.h
//  MyKitchen
//
//  Created by  on 25.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
#import "AdView.h"

@class HomeViewController;
@class FigureViewController;
@class KitchenViewController;
@class Info2ViewController;
@class MoreAppViewController;


#define kFirstVersionKey @"firstVersionKey"
#define kLastVersionKey @"lastVersionKey"

@interface RootViewController : UIViewController<AdViewDelegate>{

	CGRect frame;
	AdView *_adContainer;
	
	Info2ViewController *info2VC;
	
}


@property (nonatomic, strong) HomeViewController *homeVC;
@property (nonatomic, strong) FigureViewController* figureVC;
@property (nonatomic, strong) KitchenViewController *kitchenVC;
@property (nonatomic, strong) MoreAppViewController *moreVC;
@property (nonatomic, assign) BOOL isFirstOpen,isUpdateOpen;
@property (nonatomic, assign) float firstVersion, lastVersion, thisVersion;

+ (id)sharedInstance;

- (void)checkVersion; // first, last, this version
- (void)preLoad;

- (void)toHome;
- (void)toFigure;
- (void)toKitchen;
- (void)toInfo;
- (void)closeInfo;
- (void)toMore;
//- (void)removeIAPFeatures;

- (void)test;

- (void)fadeinSubView:(UIView*)subview outSubViews:(NSArray*)outViews;

- (void)initBanner;
- (void)showBanner;
- (void)hideBanner;


- (void)IAPDidFinished:(NSString*)identifier;
- (void)IAPDidRestored;
@end
