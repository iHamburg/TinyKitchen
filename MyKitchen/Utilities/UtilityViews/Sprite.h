//
//  Sprite.h
//  KidsLearn
//
//  Created by  on 21.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Utilities.h"
#import "AnimationManager.h"
#import <CoreImage/CoreImage.h>

@protocol SpriteDelegate;

@interface Sprite : UIImageView<NSCopying>{

	UIImage *defaultImg;

	BOOL stopFlag;
	CGRect initialFrame;
	__unsafe_unretained id<SpriteDelegate> delegate;
}

@property (nonatomic, unsafe_unretained) id<SpriteDelegate> delegate;
@property (nonatomic, assign) CGRect initialFrame; //只有在initWithFrame会自动设置，其他都没有
@property (nonatomic, assign) BOOL stopFlag;

- (void)load;

+ (id)spriteWithName:(NSString*)imgName;
+ (id)spriteWithName:(NSString *)imgName origin:(CGPoint)origin;
+ (id)spriteWithName:(NSString*)imgName frame:(CGRect)rect;
+ (id)spriteWithNames:(NSArray*)names;

- (void)play;
- (void)stop;
- (void)backToInitialPosition;
- (void)disableAllGestures;
- (void)enableAllGestures;
@end

@protocol SpriteDelegate <NSObject>

@optional
- (void)spriteDidClicked:(Sprite*)sprite;

@end