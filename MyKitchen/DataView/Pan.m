//
//  Pan.m
//  TinyKitchen
//
//  Created by XC on 8/1/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Pan.h"

@implementation Pan

- (void)load{
	[super load];
	
	type = MaschinePan;
	
	baseV.image = [UIImage imageWithContentsOfFileUniversal:@"pane2_big.png"];
	workingV.image = [UIImage imageNamedUniversal:@"pane2_big_effect.png"];
	
	
	contentV.frame = isPad?CGRectMake(300, 417, 200, 200):CGRectMake(134, 168, 100, 100);
	
	runningPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL urlWithFilename:@"pan_frying.mp3"] error:nil];
	runningPlayer.numberOfLoops = -1;
	
	startID = 0;
	AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:@"pan_place.mp3"], &startID); 
	
	
}



- (void)play{
    L();
	
	[super play];
	
	
	AudioServicesPlaySystemSound(startID);
	
	[runningPlayer playFading];

	if (food) {
		[self insertSubview:workingV belowSubview:food];
	}
	else {
		[self addSubview:workingV];
	}
	
	workingV.alpha = 0;
	[UIView animateWithDuration:5 animations:^{
		workingV.alpha = 0.3;
	}];
}


@end
