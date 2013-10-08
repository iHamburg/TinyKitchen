//
//  Sprite.m
//  KidsLearn
//
//  Created by  on 21.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Sprite.h"

@implementation Sprite

@synthesize delegate,initialFrame,stopFlag;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self load];
    }
    return self;
}


- (id)initWithImage:(UIImage*)image{

	if (self = [super initWithImage:image]) {
		[self load];
	}
	return self;
}


- (void)load{
  
	initialFrame = self.frame;

	self.animationDuration = 1;
	self.animationRepeatCount = 0;
	self.userInteractionEnabled = YES;
    self.autoresizingMask = kAutoResize;
    
	[self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
}

+ (id)spriteWithName:(NSString*)imgName{
	UIImage *img = [UIImage imageWithContentsOfFileUniversal:imgName];
	return [[[self class] alloc]initWithImage:img];
}

+ (id)spriteWithName:(NSString *)imgName origin:(CGPoint)origin{
	id sprite = [[self class] spriteWithName:imgName];
	[sprite setOrigin:origin];
	return sprite;
}

+ (id)spriteWithName:(NSString*)imgName frame:(CGRect)rect{
	id sprite = [[self class] spriteWithName:imgName];
	[sprite setFrame:rect];
  
	return sprite;

}

+ (id)spriteWithNames:(NSArray*)names{
	NSMutableArray *imgs = [NSMutableArray array];
	for (NSString *name in names) {
		UIImage *img = [UIImage imageWithContentsOfFileUniversal:name];
		[imgs addObject:img];
	}
	id sprite = [[[self class] alloc]initWithImage:[imgs objectAtIndex:0]];

	[sprite setAnimationImages:imgs];
	return sprite;
}

- (id)copyWithZone:(NSZone *)zone{
	Sprite *copy = [[Sprite alloc]initWithFrame:self.frame];
	copy.image = self.image;
	copy.delegate = self.delegate;
	
	return copy;
}
#pragma mark - Property


#pragma mark - IBOutlet
- (void)handleTap:(UITapGestureRecognizer*)gesture{

	if ([delegate respondsToSelector:@selector(spriteDidClicked:)]) {
		[delegate spriteDidClicked:self];
	}
}

#pragma mark - Animation
- (void)play{
	
}
- (void)stop{

	stopFlag = YES;
	[self.layer removeAllAnimations];
}

- (void)backToInitialPosition{
//	stopFlag = YES;
	[self.layer removeAllAnimations];
	self.frame = initialFrame;
}


- (void)disableAllGestures{
	for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
		gesture.enabled = NO;
	}
}
- (void)enableAllGestures{
	for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
		gesture.enabled = YES;
	}
}
@end
