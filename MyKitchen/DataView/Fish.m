//
//  Fish.m
//  TinyKitchen
//
//  Created by  on 20.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Fish.h"

@implementation Fish

- (void)load{
	[super load];
	
	toLeftImg = defaultImg;
	toRightImg = [[UIImage alloc]initWithCGImage:defaultImg.CGImage scale:1 orientation:UIImageOrientationUpMirrored];

}

- (void)play{
//	L();
	
	stopFlag = NO;
	
//	NSLog(@"fish.stopflag:%d",stopFlag);
	float duration = 6;
	CGFloat distance = isPad?500:200;
	[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
					 
		[self moveOrigin:CGPointMake(-distance, 0)];

	} completion:^(BOOL finished) {
		
		if (stopFlag) {
			return;
		}
		// 转身
//		NSLog(@"toright");
		
		toRight = YES;
		baseV.image = toRightImg;
		[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
			[self moveOrigin:CGPointMake(distance, 0)];
		} completion:^(BOOL finished) {
			//转身
			if (stopFlag) {
				return;
			}
			toRight = NO;
			baseV.image = toLeftImg;
			[self performSelector:@selector(play) withObject:nil afterDelay:5];
		}];
	}];
	

}

- (void)stop{
	stopFlag = YES;
	[self.layer removeAllAnimations];
	self.frame = initialFrame;
}
@end
