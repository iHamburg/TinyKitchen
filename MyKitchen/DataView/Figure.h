//
//  Figure.h
//  TinyKitchen
//
//  Created by  on 30.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

#import "Sprite.h"
#import "Food.h"
#import "AnimationPart.h"
#import "Mouth.h"
#import "Eyes.h"
#import "Head.h"
/*

     figure 的具体图片大小都不一样，怎么破？
	 没有BaseV
 
  head 和eyes是正交的还是一致的？
 
 
 Figure和Food是否应该正交？那么figure和food的交互就应该由kitchenVC来处理？
 
 */



@interface Figure : Sprite{
	// subclass 是否还要加这个index？
	FigureIndex figureIndex;

	CGRect eatingPosition; // frame of figures in the kitchenVC
    CGRect mouthPosition;                 // rect of mouth in eatingModul
	CGPoint eyesPoint;
	
	IBOutlet AnimationPart *leftBrow, *rightBrow,*nose, *body;  
	IBOutlet Head *head;
	IBOutlet Eyes *eyes;
	IBOutlet Mouth *mouth;
	NSArray *animationParts;
	
	SystemSoundID audioIDs[10];

	float durationOfEating;
	float animationDistance;
	float moveDuration;
	
	FoodTasteType selectedTaste;
	BOOL touchFlag;
	
	
	//temp
	int figureActionIndex;
	int tempInt;
	float tempfloat;
	UIView *mouthPositionV;
}


- (void)load;

@property (nonatomic, assign) CGRect eatingPosition,mouthPosition;
@property (nonatomic, assign) FigureIndex figureIndex;
@property (nonatomic, assign) FoodTasteType selectedTaste;
@property (nonatomic, assign) float durationOfEating;

+ (NSString*)NSStringFromFigureIndex:(FigureIndex)index;

- (void)runBack;

// 当点击到figure的2种反应
- (void)runUnhappyWithoutFood;
- (void)runHappyWithFood;

- (void)runSeeWindow;
- (void)runSit; 
- (void)runWaitingForEat; //禁止runsit
- (void)runEat;
- (void)runCloseMouth;
- (void)runSound:(FigureSoundType)type;

- (void)runHappy;
- (void)runSad;
- (void)runYummy;

- (void)runEyesWithPoint:(CGPoint)point;



//内部具体动作
- (void)playUp;
- (void)playDown;
- (void)playLeft;
- (void)playRight;
- (void)playLeftUp;
- (void)playLeftDown;
- (void)playRightUp;
- (void)playRightDown;

- (void)playUpBack;
- (void)playDownBack;
- (void)playLeftBack;
- (void)playRightBack;
- (void)playLeftUpBack;
- (void)playLeftDownBack;
- (void)playRightUpBack;
- (void)playRightDownBack;
- (void)playBigBack;


- (void)playHeadLeftRight;
- (void)playHeadUpDown;

- (void)playAfterEat; //恢复runsit


// 切换不用的status，包括frame和image(可能)
- (void)toEatStatus;

//判断对于食物的喜爱程度
- (FoodTasteType)willEatFood:(Food*)food; 


@end
