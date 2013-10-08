//
//  Drop.m
//  TinyKitchen
//
//  Created by  on 21.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Drop.h"

@implementation Drop

- (void)load{
	[super load];
	
	defaultImg = [UIImage imageNamedUniversal:@"water_animation2_1.png"];
	self.image = defaultImg;
}

- (void)play{
	
	//上升
	
	[UIView animateWithDuration:5 animations:^{
		[self moveOrigin:CGPointMake(0, -200)];
	} completion:^(BOOL finished) {
		if (stopFlag) {
			return;
		}
		[self moveOrigin:CGPointMake(0, 200)];
		[self play];
	}];
	
}

@end
