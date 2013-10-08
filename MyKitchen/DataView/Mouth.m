//
//  Mouth.m
//  TinyKitchen
//
//  Created by  on 11.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Mouth.h"

@implementation Mouth

@synthesize openImg, eatingParts;

- (void)setEatingParts:(NSArray *)_eatingParts{
	eatingParts = _eatingParts;
	eatingV.animationImages = [NSArray arrayWithObjects:[UIImage imageWithContentsOfFileUniversal:[eatingParts objectAtIndex:0]], 
							   [UIImage imageWithContentsOfFileUniversal:[eatingParts objectAtIndex:1]],nil];

}

- (void)load{
	[super load];
	
	eatingV = [[UIImageView alloc]initWithFrame:self.bounds];
	eatingV.autoresizingMask = kAutoResize;
	eatingV.animationDuration = 0.5;
	eatingV.animationRepeatCount = 10;
	eatingV.alpha = 0;
	
	[self addSubview:eatingV];

}

#pragma mark -
- (void)runBack{
	//mouth不会位移
	
	[self stopEating];
	
}

- (void)runOpen{
//	L();
	self.image = openImg;
}

- (void)runClose{
//	L();
	self.image = defaultImg;
}

- (void)runOpenBack{
	[self runOpen];
	[self performSelector:@selector(runClose) withObject:nil afterDelay:0.8];
}
- (void)runEating{

	
	//让本身的图片清空
	/*
	 
	 ninja 
	 */
	
	
//	NSLog(@"begin eating");
	
	self.image = nil;
	eatingV.alpha = 1;
	[eatingV startAnimating];
	
	[self performSelector:@selector(stopEating) withObject:nil afterDelay:duration];
}
- (void)stopEating{
//	NSLog(@"stop eating");
//	self.image = defaultImg;
	eatingV.alpha = 0;
	[eatingV stopAnimating];
}
@end
