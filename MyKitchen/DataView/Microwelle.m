//
//  Microwelle.m
//  TinyKitchen
//
//  Created by XC on 8/1/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Microwelle.h"

@implementation Microwelle

- (void)load{
	[super load];
	type = MaschineMicrowelle;
	
	/*
	 只有一张图片的都应该当做
	 */
	baseV.image = [UIImage imageNamedUniversal:@"kitchen_machine_big_microwelle_off.png"];

	workingV.image = [UIImage imageWithContentsOfFileUniversal:@"kitchen_machine_big_microwelle_onMaske.png"];
	workingV.alpha = 0.6;
	

	
	
	contentV.frame = isPad?CGRectMake(230, 350, 300, 180):CGRectMake(132, 136, 97, 87);
	
	runningPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL urlWithFilename:@"Microwave_microwaving.mp3"] error:nil];
	runningPlayer.numberOfLoops = 1;
	
	startID = 0;
	AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:@"Microwave_open.mp3"], &startID); 
	
	stopID = 0;
	AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:@"Microwave_Bing.mp3"], &stopID); 
	
	timer = [[Timer alloc]initWithFrame:isPad?CGRectMake(840, 180, 100, 40):CGRectMake(395, 70, 48, 20)];
	timer.label.font = [UIFont boldSystemFontOfSize:isPad?32:14];
	timer.label.textAlignment = UITextAlignmentCenter;
	timer.label.textColor = [UIColor orangeColor];
	timer.label.text = @"00:00";
	timer.strings = [NSArray arrayWithObjects:@"00:30",@"00:20",@"00:10",@"00:00", nil];
	timer.duration = kMicrowelleDuration;
	[self addSubview:timer];
	
	
	
}

- (void)play{
    L();
	
	[super play];
	
	AudioServicesPlaySystemSound(startID);
	
	[runningPlayer playFading];
	
	food.alpha = 0.7;
	
	//workingV的切换

	[self addSubview:workingV];

	[timer run];
	
	//stop working
    [self performSelector:@selector(stopAfterDuration) withObject:nil afterDelay:kMicrowelleDuration+0.2];
	
		
}

- (void)stopAfterDuration{
	
	L();
	
	[runningPlayer fadeOut];
	
	[workingV removeFromSuperview];
	
	//正常stop才会有这个声音
	AudioServicesPlaySystemSound(stopID);
}

- (void)stopImmediately{
	L();
	[super stopImmediately];
	

}

@end
