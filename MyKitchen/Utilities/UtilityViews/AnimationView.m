//
//  AnimationView.m
//  Webmoebel
//
//  Created by Michael Zapf on 12.06.11.
//  Copyright 2011 mimagazine. All rights reserved.
//

#import "AnimationView.h"
#import <QuartzCore/QuartzCore.h>

@interface AnimationView ()

@property (nonatomic, assign, readwrite) NSInteger numberOfFrames;
@property (nonatomic, assign, readwrite) NSInteger currentFrame;

@property (nonatomic, assign) NSInteger numberOfLoops;
@property (nonatomic, assign) NSInteger framesPerSecond;
@property (nonatomic, assign) NSInteger currentLoop;
@property (nonatomic, retain) NSMutableDictionary* imageCache;
@property (nonatomic, retain) CADisplayLink* displayLink;
@property (nonatomic, retain) CALayer* currentRenderLayer;

@property (nonatomic, retain) NSDate* timestamp;

@property (nonatomic, assign, readwrite) BOOL isPlaying;

- (void)renderFrame;
- (UIImage*)getImageForFrame:(NSInteger)frame;

@end


@implementation AnimationView
@synthesize dataSource;
@synthesize delegate;
@synthesize numberOfLoops;
@synthesize numberOfFrames;
@synthesize framesPerSecond;
@synthesize currentFrame;
@synthesize currentLoop;
@synthesize imageCache;
@synthesize timestamp;
@synthesize isPlaying;
@synthesize isReversed;
@synthesize displayLink;
@synthesize currentRenderLayer;

- (id)initWithCoder:(NSCoder*)coder {
	if ((self = [super initWithCoder:coder])) {
        self.framesPerSecond = 0;
		self.numberOfFrames = 0;
		self.numberOfLoops = 0;
		self.currentFrame = -1;
		self.isPlaying = NO;
    }
    return self;
}

- (void)play {
	self.timestamp = nil;
	self.isPlaying = YES;
	self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(renderFrame)];
	self.displayLink.frameInterval = (int)(50 / self.framesPerSecond);
	[self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)pause {
	[self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];	
	self.displayLink = nil;
	self.currentRenderLayer = nil;
	self.isPlaying = NO;
}


- (void)gotoFrame:(NSInteger)frame {
	if (frame < 0 || frame >= self.numberOfFrames) {
		return;
	}
	
	currentFrame = frame;
	[self renderFrame];
	currentFrame = frame;
}

- (void)drawRect:(CGRect)rect {	
	
	UIImage* image = [self getImageForFrame:currentFrame];
	[image drawAtPoint:CGPointMake(0.0f, 0.0f)];
	
#ifdef DEBUG 
	NSDate* currentTimestamp = [NSDate date];
	int fps = 0;
	if (timestamp) {
		fps = (int)(1.0 / [currentTimestamp timeIntervalSinceDate:timestamp]);
	}
	self.timestamp = currentTimestamp;
	
	NSString* info = [NSString stringWithFormat:@"fps = %i", fps];
	[info drawAtPoint:CGPointMake(5.0f, 5.0f) withFont:[UIFont systemFontOfSize:17.0]];
#endif
}


- (void)renderFrame {
	[self setNeedsDisplay];
	
	if ([self.delegate respondsToSelector:@selector(animationView:didRenderFrame:)]) {
		[self.delegate animationView:self didRenderFrame:currentFrame];
	}
	
	if (!isReversed) {
		if (currentFrame < (numberOfFrames - 1)) {
			currentFrame++;
		}
		//loop
		else if (numberOfLoops == -1 || currentLoop < numberOfLoops){
			currentFrame = 0;
			currentLoop++;
		}
		else {
			[self pause];
		}
	}
	else {
		if (currentFrame > 0) {
			currentFrame--;
		}
		//loop
		else if (numberOfLoops == -1 || currentLoop > numberOfLoops){
			currentFrame = numberOfFrames - 1;
			currentLoop++;
		}
		else {
			[self pause];
		}
	}
}

- (UIImage*)getImageForFrame:(NSInteger)frame {
	//TODO: cache images
	UIImage* image = [self.dataSource imageForFrame:currentFrame inAnimationView:self];
	return image;
}

- (void)reloadData {
	if ([self.dataSource respondsToSelector:@selector(numberOfLoopsInAnimationView:)]) {
		self.numberOfLoops = [self.dataSource numberOfLoopsInAnimationView:self];
	}
	else {
		self.numberOfLoops = 0;
	}
	
	if ([self.dataSource respondsToSelector:@selector(numberOfFramesInAnimationView:)]) {
		self.numberOfFrames = [self.dataSource numberOfFramesInAnimationView:self];
	}
	else {
		self.numberOfFrames = 0;
	}
	
	if ([self.dataSource respondsToSelector:@selector(framesPerSecondInAnimationView:)]) {
		self.framesPerSecond = [self.dataSource framesPerSecondInAnimationView:self];
	}
	else {
		self.framesPerSecond = 0;
	}
}

@end
