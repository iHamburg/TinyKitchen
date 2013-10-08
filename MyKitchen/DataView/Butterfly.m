//
//  Butterfly.m
//  TinyKitchen
//
//  Created by  on 03.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Butterfly.h"

@implementation Butterfly

- (void)play{
	
	[self startAnimating];


	CGPoint startPoint = self.center;
	CGPoint endPoint = isPad?CGPointMake(self.center.x+720, self.center.y):CGPointMake(self.center.x+350, self.center.y);
//	CGPoint controlPoint = CGPointMake(self.center.x+350, self.center.y+150);

	CGFloat x1 = isPad?240:100;
	CGFloat x2 = isPad?480:200;
	CGFloat y = isPad?150:60;
	CGPoint controlPoint1 = CGPointMake(self.center.x+x1, self.center.y-y);
	CGPoint controlPoint2 = CGPointMake(self.center.x+x2, self.center.y+y);
	UIBezierPath *path = [UIBezierPath bezierPath];
	
    [path moveToPoint:startPoint];

	[path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
	
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path = path.CGPath;
    moveAnimation.duration = 4.0f;
	moveAnimation.removedOnCompletion = NO;
	moveAnimation.fillMode = kCAFillModeForwards;
	moveAnimation.delegate = self;

    // Setting the rotation mode ensures Pacman's mouth is always forward.  This is a very convenient CA feature.
	//    moveAnimation.rotationMode = kCAAnimationRotateAuto;

	[self.layer addAnimation:moveAnimation forKey:@"moveAnimation"];
	
//	[self performSelector:@selector(stopAnimating) withObject:nil afterDelay:5.0];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
	L();
	[self stopAnimating];
}

- (void)stop{
	L();
	[self.layer removeAllAnimations];
}
@end
