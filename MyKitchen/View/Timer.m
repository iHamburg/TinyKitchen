//
//  Timer.m
//  TinyKitchen
//
//  Created by  on 17.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Timer.h"

@implementation Timer

@synthesize label,strings, duration;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		label = [[UILabel alloc]initWithFrame:self.bounds];
		label.backgroundColor = [UIColor clearColor];
//		label.autoresizingMask = kAutoResize;
		[self addSubview:label];
		
		
    }
    return self;
}


- (void)run{
	indexOfString = 0;
	
	[self performSelector:@selector(showNextString) withObject:nil afterDelay:duration/[strings count]];
}
- (void)stop{

}

- (void)showNextString{
//	L();
	if (indexOfString<[strings count]) {
		label.text = [strings objectAtIndex:indexOfString];
		indexOfString++;
		[self performSelector:@selector(showNextString) withObject:nil afterDelay:duration/[strings count]];
	}
	else { //到最后一针了
		[NSObject cancelPreviousPerformRequestsWithTarget:self];
	}
}

@end
