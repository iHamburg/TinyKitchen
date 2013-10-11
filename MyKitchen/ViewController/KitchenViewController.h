//
//  KitchenViewController.h
//  MyKitchen
//
//  Created by  on 25.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
#import "RootViewController.h"
#import "Figure.h"
#import "Food.h"
#import "ThinkCloud.h"
#import "MyStoreObserver.h"

@class Foodfloor;
@class MaschinesView;
@class OutdoorViewController;
@class MaschineWorkingView;
@class FigureTestToolbar;

@interface KitchenViewController : UIViewController<SpriteDelegate, ControlViewDelegate, UIGestureRecognizerDelegate>{
	UIImageView *bgV;
	
	ControlView *controlView;
	
	OutdoorViewController *outdoorVC;
	MaschinesView *maschinesView;
	MaschineWorkingView *maschineWorkingView;
	
	UIView *figureContainer; //  figure, foodfloor, desk, selectedfood, 可以全屏
	
	Foodfloor *foodfloor; // CGRectMake(0, 528, 1024, 240) 和 (0，748，1024，240)
	Figure *figure;
	
	
    Food *selectedFood; //归nil的情况：1.打开foodfloor ；2 吃掉
	Food *copyFood; //
	Sprite *window, *desk, *backS;
	
//	FoodCategory thinkedFoodCategory;
//	Food *thinkedFood;
//	ThinkCloud *thinkCloud;
//	Sprite *outdoorHinweis;
	
	UISwipeGestureRecognizer *leftSwipe, *rightSwipe;

    CGPoint plateCenter;
    CGRect mouthPosition;
	
	BOOL isPaning; // 当食物在移动的时候，foodfloor不会升起来
	BOOL eyesMoveFlag;  //default：no， 当pan开始后1s，激活，pan结束回no
	float runEyesDelay;
	
	// temp
	int tempInteger;
	FigureTestToolbar *testToolbar;
}


@property (nonatomic, unsafe_unretained) RootViewController *rootVC;
@property (nonatomic, strong) ControlView *controlView; // foodfloor 要使用到这个controlview
@property (nonatomic, strong) Food *selectedFood;
@property (nonatomic, assign) MaschineType selectedMaschineType;// 因为这里的maschine不需要传递任何改变，所以传递maschinetype就可以了


- (void)setup;

- (void)toMaschineWorkingView;

- (void)toOutdoor;

- (void)getFoodFromOutdoor:(Food*)outdoorFood;
- (void)getFoodFromWorkingView:(Food*)workedFood;
- (void)startFoodfloor:(BOOL)flag; 




- (CGRect)foodPositionOnPlate:(Food*)food; // 这个rect也能放在food中，但是如果会修改plateCenter的位置的话，也可以放在这里
- (CGRect)mouthRect;

- (void)setEyesMoveFlag;


//- (void)layoutBanner:(UIView*)banner loaded:(BOOL)loaded;

// new to added feature
//- (void)wantFood;
//- (void)generateThinkFood;
//- (void)showCloud;
//- (void)closeCloud;
//- (void)showOutdoorHinweis; //自动消失

- (void)test;

@end
