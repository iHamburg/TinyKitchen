//
//  AnimationView.h
//  Webmoebel
//
//  Created by Michael Zapf on 12.06.11.
//  Copyright 2011 mimagazine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnimationViewDataSource;
@protocol AnimationViewDelegate;


@interface AnimationView : UIView {

}

@property (nonatomic, assign) IBOutlet id<AnimationViewDataSource> dataSource;
@property (nonatomic, assign) IBOutlet id<AnimationViewDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL isPlaying;
@property (nonatomic, assign, readonly) NSInteger numberOfFrames;
@property (nonatomic, assign, readonly) NSInteger currentFrame;
@property (nonatomic, assign ) BOOL isReversed;

- (void)gotoFrame:(NSInteger)frame;
- (void)play;
- (void)pause;
- (void)reloadData;

@end

@protocol AnimationViewDataSource <NSObject> 
	- (UIImage*)imageForFrame:(NSInteger)frame inAnimationView:(AnimationView*)view;
	- (NSInteger)numberOfFramesInAnimationView:(AnimationView*)view;
	
@optional
	- (NSInteger)numberOfLoopsInAnimationView:(AnimationView*)view;
	- (NSInteger)framesPerSecondInAnimationView:(AnimationView*)view;
@end

@protocol AnimationViewDelegate <NSObject>

- (void)animationView:(AnimationView*)animationView didRenderFrame:(NSInteger)frame; 

@end

