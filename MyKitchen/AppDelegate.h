//
//  AppDelegate.h
//  MyKitchen
//
//  Created by  on 25.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "FBViewController.h"
#import "RootViewController.h"

#define FBAppID @"215758368551004"


@interface AppDelegate : UIResponder <UIApplicationDelegate>{
	RootViewController *rootVC;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) Facebook *facebook;
@end
