//
//  Pot.m
//  TinyKitchen
//
//  Created by XC on 8/1/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Pot.h"

@implementation Pot

- (void)load{
	[super load];
	
	type = MaschinePot;
	
	//		baseV.image = [UIImage imageNamedUniversal:@"kitchen_machine_small_pot.png"];
	baseV.image = [UIImage imageNamedUniversal:@"kitchen_machine_big_pot.png"];

	//平时workingV不在view上，只有play的时候add上去，stop后remove
	[workingV setAnimationImageNames:[NSArray arrayWithObjects:@"pot_water2_1.png",@"pot_water2_2.png",@"pot_water2_3.png",nil]];
	workingV.animationDuration = 0.6;
	workingV.alpha = 0.5;
	
	
	contentV.frame = isPad?CGRectMake(388, 473, 250, 200):CGRectMake(184, 195, 120, 100);
	
	runningPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL urlWithFilename:@"pot Water or soup boiling.mp3"] error:nil];
	runningPlayer.numberOfLoops = -1;
	
	startID = 0;
	AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:@"Pot_bangs.mp3"], &startID); 
	

}



- (void)play{
    L();
	
	[super play];
	
	AudioServicesPlaySystemSound(startID);
	
	[runningPlayer playFading];
	

	[self addSubview:workingV];
	[workingV startAnimating];
	
}

- (void)stopImmediately{
	[super stopImmediately];
}
@end
