//
//  AnimationPart.h
//  TinyKitchen
//
//  Created by XC on 7/31/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"

/*
 
 如果animationpart是全屏加入的话就只能位移，旋转和放大都会出现问题！！！
 
 没有用baseV和defaultImg
 
 */



@interface AnimationPart : UIImageView{
    UIImage *defaultImg;
    NSArray *happyParts; 
    NSArray *sadParts;
    NSArray *yummyParts;
	CGRect initialFrame;
	
	float animationDistance;
	float duration;
	int animationIndex;
	
	BOOL moveFlag;
}
@property (nonatomic, strong) UIImage *defaultImg;
@property (nonatomic, strong) NSArray *sadParts;
@property (nonatomic, strong) NSArray *happyParts;
@property (nonatomic, strong) NSArray *yummyParts;
@property (nonatomic, assign) CGRect initialFrame;
@property (nonatomic, assign) float animationDistance;
@property (nonatomic, assign) float duration;


- (void)load;

- (void)back;
- (void)normal;

- (void)happy;
- (void)sad;
- (void)yummy;




- (void)runBack;
- (void)runLeft;
- (void)runRight;
- (void)runUp;
- (void)runDown;
- (void)runLeftUp;
- (void)runLeftDown;
- (void)runRightUp;
- (void)runRightDown;
//- (void)runDirectionRandom;

// 自动back， 相对值
- (void)runLeftBack;
- (void)runRightBack;
- (void)runUpBack;
- (void)runDownBack;
- (void)runLeftUpBack;
- (void)runRightUpBack;
- (void)runLeftDownBack;
- (void)runRightDownBack;

- (void)runBigBack;
- (void)runDirectionRandomBack;
@end
