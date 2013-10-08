//
//  FigureDash.m
//  MyKitchen
//
//  Created by  on 26.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//


#import "FigureDash.h"

@implementation FigureDash


- (void)load{
	[super load];
	
	
	spark = [UIImageView imageViewWithName:@"Animation_star1.png" frame:self.bounds];
	spark.autoresizingMask = kAutoResize;
	spark.alpha = 0;
	
	
//	strahl = [UIImageView imageViewWithName:@"Animation_star2.png" frame:self.bounds];
//	strahl.alpha = 0;
//	strahl.autoresizingMask = kAutoResize;
	
	[self addSubview:spark];
//	[self addSubview:strahl];
//	self.backgroundColor = [UIColor redColor];
}

- (void)play{
	
	/* spark  闪烁两下.貌似闪烁2下不要在同一个地方
	 
	*/
	
	 [AnimationManager runflickerOnView:spark duration:0.5 times:2];
	
	
}

//-(void) animationDidStop:(CAAnimation *) animation finished:(bool) flag {
//    if (animation == [strahl.layer animationForKey:@"aa"]) {
//        // remove view here, add another view and/or start another transition
//		NSLog(@"end of animation");
//    }
//	
//}

- (void)ratateStrahl{
	// strahl在旋转的同时也要消失？用animation
	
	strahl.alpha = 1;
	CABasicAnimation* rotationAnimation;
	
	rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotationAnimation.byValue = [NSNumber numberWithFloat: M_PI * 1.0 /* full rotation*/  ];
	rotationAnimation.duration = 4;
	
	//			rotationAnimation.cumulative = YES; //每次都是累计的变化 == byValue
	rotationAnimation.repeatCount = 0; //不重复
	rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	
	[strahl.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
@end
