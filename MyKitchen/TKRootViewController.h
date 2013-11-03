//
//  RootViewController.h
//  MyKitchen
//
//  Created by  on 25.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
#import "LRootViewController.h"
//#import "AdView.h"
//#import "InfoViewController.h"

@class HomeViewController;
@class FigureViewController;
@class KitchenViewController;




#define kFirstVersionKey @"firstVersionKey"
#define kLastVersionKey @"lastVersionKey"

@interface TKRootViewController : LRootViewController{

	CGRect frame;
    
}


@property (nonatomic, strong) HomeViewController *homeVC;
@property (nonatomic, strong) FigureViewController* figureVC;
@property (nonatomic, strong) KitchenViewController *kitchenVC;

- (void)toHome;
- (void)toFigure;
- (void)toKitchen;
- (void)toInfo;
- (void)closeInfo;


- (void)test;

- (void)fadeinSubView:(UIView*)subview outSubViews:(NSArray*)outViews;


- (void)IAPDidFinished:(NSString*)identifier;
- (void)IAPDidRestored;
@end
