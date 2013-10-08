//
//  Steam.m
//  TinyKitchen
//
//  Created by  on 08.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Steam.h"

@implementation Steam

@synthesize duration;

- (void)load{
	[super load];
	

	v1 = [[UIImageView alloc]initWithFrame:self.bounds];
	v2 = [[UIImageView alloc]initWithFrame:self.bounds];
	v3 = [[UIImageView alloc]initWithFrame:self.bounds];
	
	v1.autoresizingMask = kAutoResize;
	v2.autoresizingMask = kAutoResize;
	v3.autoresizingMask = kAutoResize;
	
	v1.image = [UIImage imageNamedUniversal:@"steam1.png"];
	v2.image = [UIImage imageNamedUniversal:@"steam1.png"];
	v3.image = [UIImage imageNamedUniversal:@"steam1.png"];
	
	v1.alpha = 0;
	v2.alpha = 0;
	v3.alpha = 0;
	
	[self addSubview:v1];
	[self addSubview:v2];
	[self addSubview:v3];

	duration = 5.0;
	
	
}

- (void)play{
	
	L();


	[self runSubviewHover:v1];
	
	[v2 moveOrigin:CGPointMake(-30, 0)];
	[self performSelector:@selector(runSubviewHover:) withObject:v2 afterDelay:duration/2+0.2];
	
	[v3 moveOrigin:CGPointMake(30, 0)];
	[self performSelector:@selector(runSubviewHover:) withObject:v3 afterDelay:duration+0.2];

}

- (void)stop{
	L();
//	self.alpha = 0.0;
	
	// v1 和 v是否也要removeallanimation？
	v1.alpha = 0.0;
	v2.alpha = 0.0;
	v3.alpha = 0.0;
	
	[self.layer removeAllAnimations];
	[v1.layer removeAllAnimations];
	[v2.layer removeAllAnimations];
	[v3.layer removeAllAnimations];


	[self backToInitialPosition];
}

- (void)runSubviewHover:(UIView*)v{
	CGFloat height = self.height;
	
	v.alpha = 1;
	[UIView animateWithDuration:duration/2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
		
		[v moveOrigin:CGPointMake(0, -height/2)];
		
	} completion:^(BOOL finished) {
		
		
		[UIView animateWithDuration:duration/2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
			
			v.alpha = 0;
			[v moveOrigin:CGPointMake(0, -height/2)];
		
			
		} completion:^(BOOL finished) {
			
			v.frame = self.bounds;
		
		}
		 ];
	}];
}
@end
