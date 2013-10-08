//
//  Maschine.h
//  TinyKitchen
//
//  Created by XC on 8/1/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Sprite.h"
#import "FoodManager.h"
#import  <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


/*
 Maschine在2个不同的view里是显示不同的uiview,关键是image和frame都不同,而且一旦add new的subview，原来的maschine就没有了！
 所以不要用原本的image，分别显示baseV和workingV

 maschine是不会移动的，maschine的frame是由外界设定的
 
 有可能的话，maschineView里不要放maschine，imgV就可以了，maschine只在workingV里出现，也可以不要都预载入
 */

@interface Maschine : Sprite{
    Food *food;
   

	UIView *contentV;
    UIImageView *baseV; 
    UIImageView *workingV, *workingV2; //1024x768
	
    UIImage *workingOffImg,*workingOnImg; // workingV的背景图像
    
    BOOL useable;
	BOOL onWorkingView; // true->base off, workingv on;

	
    MaschineType type;
	
	AVAudioPlayer *runningPlayer;
	SystemSoundID startID,stopID;
	
}

@property (nonatomic, strong) Food *food;
@property (nonatomic, assign) MaschineType type;


- (void)runWorkingSound;
- (void)stopAfterDuration;
- (void)stopImmediately;


- (float)scaleWithSize:(CGSize)originalSize toSize:(CGSize)destinationSize;


+ (BOOL)isMaschine:(MaschineType)type workableWithFoodCategory:(FoodCategory)category;
@end
