//
//  Cloud.m
//  TinyKitchen
//
//  Created by  on 03.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Cloud.h"

@implementation Cloud


- (void)play{

	
	[UIView animateWithDuration:40 delay:0 options:UIViewAnimationOptionRepeat animations:^{
		[self moveOrigin:CGPointMake(isPad?1500:700, 0)];
	} completion:^(BOOL finished) {
		[self moveOrigin:CGPointMake(isPad?-1500:-700, 0)];
	}];

}


@end
