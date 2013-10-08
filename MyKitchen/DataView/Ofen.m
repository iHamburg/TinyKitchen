//
//  Ofen.m
//  TinyKitchen
//
//  Created by XC on 8/1/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Ofen.h"

@implementation Ofen


- (void)load{
	[super load];
	
	type = MaschineOfen;
	
	baseV.image = [UIImage imageNamedUniversal:@"kitchen_machine_big_ofen_off.png"];

	workingV.image = [UIImage imageNamedUniversal:@"kitchen_machine_big_ofen_onMask.png"];
	
	contentV.frame = isPad?CGRectMake(400, 424, 240, 150):CGRectMake(186, 176, 110, 65);
	
	
	runningPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL urlWithFilename:@"Oven_fan.mp3"] error:nil];
	runningPlayer.numberOfLoops = 1;
	
	startID = 0;
	AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:@"Oven_open.mp3"], &startID); 
	

	
	timer = [[Timer alloc]initWithFrame:isPad?CGRectMake(464, 125, 90, 30):CGRectMake(217, 50, 44, 18)];
	timer.label.font = [UIFont boldSystemFontOfSize:isPad?24:12];
	timer.label.textColor = [UIColor orangeColor];
	timer.label.textAlignment = UITextAlignmentCenter;
	timer.label.text = @"0:00:00";
	timer.strings = [NSArray arrayWithObjects:@"0:30:00",@"0:20:00",@"0:10:00",@"0:00:00", nil];
	timer.duration = kOfenDuration;
	[self addSubview:timer];
	
//	NSLog(@"ofen # %@, baseV # %@",self,baseV);

}




- (void)play{
    L();

	[super play];
	
	
	AudioServicesPlaySystemSound(startID);
	
	[runningPlayer playFading];
	
	//workingV的切换

	if (food) {
		[self insertSubview:workingV belowSubview:contentV];
	}
	else {
		[self addSubview:workingV];
	}
	
	//timer
	[timer run];
	
	//stop working
    [self performSelector:@selector(stopAfterDuration) withObject:nil afterDelay:kOfenDuration+0.2];
	

}

- (void)stopAfterDuration{
	
	L();
	
	[runningPlayer fadeOut];
	
	[workingV removeFromSuperview];
	
	
}

@end
