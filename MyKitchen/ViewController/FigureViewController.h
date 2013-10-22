//
//  FigureViewController.h
//  MyKitchen
//
//  Created by  on 25.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
#import "TKRootViewController.h"
#import "FigureDash.h"
#import "MyStoreObserver.h"

@interface FigureViewController : UIViewController<SpriteDelegate>{
	UIButton *homeB;
	
	Figure *ninja, *cat, *lion, *pinguin;
	
	UIImageView *lock1, *lock2, *lock3;
	
	FigureDash *dash;
	
	int figureIndex;
	
}

@property (nonatomic, unsafe_unretained) TKRootViewController *rootVC;

//- (void)removeIAPFeature;
@end
