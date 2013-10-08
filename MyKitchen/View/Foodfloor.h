//
//  Foodfloor.h
//  TinyKitchen
//
//  Created by  on 30.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KitchenViewController.h"

#define kHFoodfloor (isPad?240.0:100.0)
#define kYFoodfloorCloseMargin (isPad?20.0:15.0)

// 1024x240
@interface Foodfloor : UIView<SpriteDelegate>{
	
	
	ControlView *controlView;
    UIScrollView *scrollView;
    NSMutableArray *plates;
	
	FoodCategory foodCategory; //0-9
	int preLoadedPlateNumber;

	// 在VC的位置都设到V上
	CGRect openRect,closeRect;
	
	int pageIndex;
	int numberOfPages;
}

@property (nonatomic, assign) FoodCategory foodCategory;
@property (nonatomic, strong) ControlView *controlView;
@property (nonatomic, assign) CGRect openRect, closeRect;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, unsafe_unretained) KitchenViewController *vc;

- (id)initWithVC:(KitchenViewController*)vc;

- (void)open;
- (void)close;
- (void)goNext;
- (void)goPrevious;
- (void)goPage:(int)page;
- (void)goRandom;

//- (void)removeIAPFeature;
@end
