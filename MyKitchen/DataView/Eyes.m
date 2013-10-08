//
//  Eyes.m
//  TinyKitchen
//
//  Created by  on 11.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Eyes.h"

@implementation Eyes

@synthesize  eyeballImg;

- (void)setEyeballImg:(UIImage *)_eyeballImg{
	eyeballImg = _eyeballImg;
	eyeball.image = _eyeballImg;
}

- (void)load{

	[super load];
	initialFrame = self.frame;
	
	eyeball = [[UIImageView alloc]initWithFrame:self.bounds];
	eyeball.autoresizingMask = kAutoResize;
	
	[self addSubview:eyeball];
	
}

- (void)back{
	eyeball.frame = initialFrame;
}

- (void)runBack{
//	L();
//	eyeball.frame = initialFrame;
	[UIView animateWithDuration:duration/2 animations:^{
		eyeball.frame = initialFrame;
	}];
}

- (void)runLeft{

	// frame 是不会变的


	[UIView animateWithDuration:duration/2 animations:^{
		[eyeball setOrigin:CGPointMake(-animationDistance, 0)];
	} ];
}
- (void)runRight{


	[UIView animateWithDuration:duration/2 animations:^{
		[eyeball setOrigin:CGPointMake(animationDistance, 0)];
	} ];
}

- (void)runUp{
	
	[UIView animateWithDuration:duration/2 animations:^{
		[eyeball setOrigin:CGPointMake(0, -animationDistance)];
	} ];
}

- (void)runDown{
	
	[UIView animateWithDuration:duration/2 animations:^{
		[eyeball setOrigin:CGPointMake(0, animationDistance)];
	} ];
}

- (void)runLeftUp{
	[UIView animateWithDuration:duration/2 animations:^{
		[eyeball setOrigin:CGPointMake(-0.7*animationDistance,-0.7*animationDistance)];
	} ];
}
- (void)runLeftDown{
	[UIView animateWithDuration:duration/2 animations:^{
		[eyeball setOrigin:CGPointMake(-0.7*animationDistance, 0.7* animationDistance)];
	} ];
}
- (void)runRightUp{
	[UIView animateWithDuration:duration/2 animations:^{
		[eyeball setOrigin:CGPointMake(0.7*animationDistance, -0.7*animationDistance)];
	} ];
}
- (void)runRightDown{
	[UIView animateWithDuration:duration/2 animations:^{
		[eyeball setOrigin:CGPointMake(0.7*animationDistance, 0.7*animationDistance)];
	} ];
}


- (void)runLeftBack{
	
//	NSLog(@"begin runleft");

	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(-animationDistance, 0)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[eyeball.layer addAnimation:move forKey:@"moveLeft"];
}
- (void)runRightBack{
	

	
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(animationDistance, 0)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[eyeball.layer addAnimation:move forKey:@"moveLeft"];

}

- (void)runUpBack{
	
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(0, -animationDistance)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[eyeball.layer addAnimation:move forKey:@"moveLeft"];
}

- (void)runDownBack{
	
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(0, animationDistance)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[eyeball.layer addAnimation:move forKey:@"moveLeft"];
}


- (void)runLeftUpBack{
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(-0.7*animationDistance, -0.7*animationDistance)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[eyeball.layer addAnimation:move forKey:@"moveLeft"];
	
}
- (void)runRightUpBack{
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(0.7*animationDistance,-0.7*animationDistance)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[eyeball.layer addAnimation:move forKey:@"moveLeft"];
	
}
- (void)runLeftDownBack{
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(-0.7*animationDistance, 0.7*animationDistance)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[eyeball.layer addAnimation:move forKey:@"moveLeft"];
	
}
- (void)runRightDownBack{
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(0.7*animationDistance, 0.7*animationDistance)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[eyeball.layer addAnimation:move forKey:@"moveLeft"];
}
- (void)runBigBack{
//	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//	move.toValue = [NSNumber numberWithFloat:1.5];
//	move.duration = duration/2; // 因为会autoruverse
//	move.autoreverses = YES;
//	[eyeball.layer addAnimation:move forKey:@"moveLeft"];

	//中心点不变
	[UIView animateWithDuration:duration/2 animations:^{
		self.transform = CGAffineTransformMakeScale(1.5, 1.5);
		
	}];
}
@end
