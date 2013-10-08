//
//  AnimationiManager.h
//  KidsLearn
//
//  Created by  on 26.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utilities.h"

@interface AnimationManager : NSObject

+ (void)waver:(UIView*)v;
+ (void)scale:(UIView*)v withScale:(CGFloat)scale times:(int)times;
+ (void)move:(UIView*)v away:(CGPoint)point;

+ (void)clickAnimation:(UIView*)v;
+ (void)jump:(UIView*)v;
+ (void)jumps:(NSArray*)vs;
+ (void)rotate:(UIView*)v;

+ (void)runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration clockwise:(BOOL)clockwise;
+ (void)runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
+ (void)runflickerOnView:(UIView*)view duration:(CGFloat)duration times:(int)times;

@end
