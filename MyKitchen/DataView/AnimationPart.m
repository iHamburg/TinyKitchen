//
//  AnimationPart.m
//  TinyKitchen
//
//  Created by XC on 7/31/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "AnimationPart.h"

@implementation AnimationPart

@synthesize defaultImg, animationDistance,duration,initialFrame;
@synthesize sadParts,happyParts,yummyParts;

- (void)setDefaultImg:(UIImage *)_defaultImg{
	defaultImg = _defaultImg;
	self.image = defaultImg;
}

- (void)awakeFromNib{
	L();
	[self load];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
		[self load];
	}
    return self;
}

- (void)load{
	self.autoresizingMask = kAutoResize;
	initialFrame = self.frame;
	duration = 0.8;
	animationDistance = 15;
	moveFlag = YES;
}

#pragma mark -
- (void)happy{
	
	if (ISEMPTY(happyParts)) {
		return;
	}
	
	NSString *imgName = [happyParts objectAtIndex:arc4random()%[happyParts count]];
  
    self.image = [UIImage imageWithContentsOfFileUniversal:imgName];
    [self performSelector:@selector(normal) withObject:nil afterDelay:1];
	
}
- (void)sad{
	if (ISEMPTY(sadParts)) {
		return;
	}
    NSString *imgName = [sadParts objectAtIndex:arc4random()%[sadParts count]];
	NSLog(@"sad img:%@",imgName);
	self.image = [UIImage imageWithContentsOfFileUniversal:imgName];
    [self performSelector:@selector(normal) withObject:nil afterDelay:1];
}
- (void)yummy{
	if (ISEMPTY(yummyParts)) {
		return;
	}
	NSString *imgName = [yummyParts objectAtIndex:arc4random()%[yummyParts count]];
   self.image = [UIImage imageWithContentsOfFileUniversal:imgName];

    [self performSelector:@selector(normal) withObject:nil afterDelay:1];
	
	
}
- (void)normal{
    self.image = defaultImg;
}



#pragma mark -
- (void)back{
//	L();
	self.frame = initialFrame;
}

- (void)runBack{
//	L();
	
//	NSLog(@"initialframe:%@",NSStringFromCGRect(initialFrame));
	[UIView animateWithDuration:duration/2 animations:^{
		self.frame = initialFrame;
	}];
}

- (void)runLeft{
	
	// frame 是不会变的
	

	[UIView animateWithDuration:duration/2 animations:^{
		[self setOrigin:CGPointMake(-animationDistance, 0)];
	} ];
}
- (void)runRight{
	
	
	[UIView animateWithDuration:duration/2 animations:^{
		[self setOrigin:CGPointMake(animationDistance, 0)];
	} ];
}

- (void)runUp{
	
	[UIView animateWithDuration:duration/2 animations:^{
		[self setOrigin:CGPointMake(0, -animationDistance)];
	} ];
}

- (void)runDown{
	
	[UIView animateWithDuration:duration/2 animations:^{
		[self setOrigin:CGPointMake(0, animationDistance)];
	} ];
}

- (void)runLeftUp{
	[UIView animateWithDuration:duration/2 animations:^{
		[self setOrigin:CGPointMake(-0.7*animationDistance,-0.7*animationDistance)];
	} ];
}
- (void)runLeftDown{
	[UIView animateWithDuration:duration/2 animations:^{
		[self setOrigin:CGPointMake(-0.7*animationDistance, 0.7* animationDistance)];
	} ];
}
- (void)runRightUp{
	[UIView animateWithDuration:duration/2 animations:^{
		[self setOrigin:CGPointMake(0.7*animationDistance, -0.7*animationDistance)];
	} ];
}
- (void)runRightDown{
	[UIView animateWithDuration:duration/2 animations:^{
		[self setOrigin:CGPointMake(0.7*animationDistance, 0.7*animationDistance)];
	} ];
}

- (void)runLeftBack{
	
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(-animationDistance, 0)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[self.layer addAnimation:move forKey:@"moveLeft"];

}
- (void)runRightBack{
	
	
	
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(animationDistance, 0)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[self.layer addAnimation:move forKey:@"moveLeft"];
	
}

- (void)runUpBack{
	if (!moveFlag) {
		return;
	}
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(0, -animationDistance)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	move.delegate = self;
	[self.layer addAnimation:move forKey:@"moveUpBack"];
}

- (void)runDownBack{
	if (!moveFlag) {
		return;
	}
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(0, animationDistance)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	move.delegate = self;
	[self.layer addAnimation:move forKey:@"moveLeft"];
}

- (void)runLeftUpBack{
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(-0.7*animationDistance, -0.7*animationDistance)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[self.layer addAnimation:move forKey:@"moveLeft"];

}
- (void)runRightUpBack{
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(0.7*animationDistance,-0.7*animationDistance)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[self.layer addAnimation:move forKey:@"moveLeft"];

}
- (void)runLeftDownBack{
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(-0.7*animationDistance, 0.7*animationDistance)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[self.layer addAnimation:move forKey:@"moveLeft"];

}
- (void)runRightDownBack{
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
	move.byValue = [NSValue valueWithCGPoint:CGPointMake(0.7*animationDistance, 0.7*animationDistance)];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[self.layer addAnimation:move forKey:@"moveLeft"];
}
- (void)runDirectionRandomBack{
//	int index = arc4random()%4;
	
}

- (void)runBigBack{
	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	move.toValue = [NSNumber numberWithFloat:1.5];
	move.duration = duration/2; // 因为会autoruverse
	move.autoreverses = YES;
	[self.layer addAnimation:move forKey:@"moveLeft"];
}

- (void)animationDidStart:(CAAnimation *)anim{
	moveFlag = NO;
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
	moveFlag = YES;
}
@end
