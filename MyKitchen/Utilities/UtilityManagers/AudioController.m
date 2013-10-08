//
//  AudioController.m
//  FirstThings_Uni
//
//  Created by  on 11.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "AudioController.h"

@implementation AudioController

@synthesize silent;

- (void)setSilent:(BOOL)_Silent{
	silent = _Silent;
	[[NSUserDefaults standardUserDefaults]setBool:silent forKey:@"silent"];
	if (silent) {
		[self stopBGMusic];
	}
	else {
		[self playBGMusicWithScene:SceneHome];
	}
}
#pragma mark -
- (id)init{
	if (self = [super init]) {
		
		/*
		 AudioButton,
		 AudioFigureChoosing,
		 AudioFigureNinja,
		 AudioFigureLion,
		 AudioFigureCat,
		 AudioFigurePinguin
		 */
		NSArray *audioNames = [NSArray arrayWithObjects:@"button_click.mp3",@"ChooseFigure_Click.mp3",@"ninja_good.mp3",@"lion_good.mp3",
							   @"cat_meows3.mp3",@"penguin_good.mp3",nil];
		
		for(int i=0;i<[audioNames count];i++){
			SystemSoundID soundid = 0;
			AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:[audioNames objectAtIndex:i]], &soundid); 
			audioIDs[i] = soundid;
		}
		
	

		homeBGPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL urlWithFilename:@"homeBG.mp3"] error:nil];
		homeBGPlayer.numberOfLoops = -1;
		kitchenBGPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL urlWithFilename:@"kitchenBG.mp3"] error:nil];
		kitchenBGPlayer.numberOfLoops = -1;
		figureBGPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL urlWithFilename:@"homeBG.mp3"] error:nil];
		figureBGPlayer.numberOfLoops = -1;
		outdoorBGPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL urlWithFilename:@"outdoorBG.mp3"] error:nil];
		outdoorBGPlayer.numberOfLoops = -1;
		bgPlayers = [NSArray arrayWithObjects:homeBGPlayer,kitchenBGPlayer,figureBGPlayer,outdoorBGPlayer, nil];
		
		silent = [[NSUserDefaults standardUserDefaults]boolForKey:@"silent"];
		
		
	}
	return self;
}

+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	
	return sharedInstance;
	
}

- (void)play:(AudioType)type{
		

	SystemSoundID soundid = audioIDs[type];
	AudioServicesPlaySystemSound(soundid);
}



- (void)playBGMusicWithScene:(Scene)scene{
	
	if (silent) {
		return;
	}
	
	//这里我也可以做一个array，但是4个player，没有太大的必要
	
	//先关闭所有的音乐
	for (AVAudioPlayer *player in bgPlayers) {
		[player stop];
	}
	
	AVAudioPlayer *player;
	if (scene == SceneHome ) {
		player = homeBGPlayer;
	}
	else if(scene == SceneFigure){
		player = figureBGPlayer;
	}
	else if (scene == SceneKitchen) {
		player = kitchenBGPlayer;
	}
	else if (scene == SceneOutdoor) {
		player = outdoorBGPlayer;
	}
	
	[player playFading];
}

- (void)stopBGMusicWithScene:(Scene)scene{
	AVAudioPlayer *player;
	if (scene == SceneHome ) {
		player = homeBGPlayer;
	}
	else if(scene == SceneFigure){
		player = figureBGPlayer;
	}
	else if (scene == SceneKitchen) {
		player = kitchenBGPlayer;
	}
	else if (scene == SceneOutdoor) {
		player = outdoorBGPlayer;
	}

	[player fadeOut];
}

- (void)stopBGMusic{
	for (AVAudioPlayer *player in bgPlayers) {
		[player fadeOut];
	}
}

- (void)playFigureSound:(FigureIndex)figure{
	
}

- (void) observeValueForKeyPath:(NSString *)keyPath
					   ofObject:(id)object 
						 change:(NSDictionary *)change
						context:(void *)context {
	L();
	
	if ([keyPath isEqual:@"isSilent"]) { //这里的silent要save在defautls中

		NSLog(@"new price is %d", [[change objectForKey:@"new"] boolValue]);
		if ([[change objectForKey:@"new"] boolValue]) {
			[self stopBGMusic];
		}
		else {
			[self playBGMusicWithScene:SceneHome];
		}
	}
}

@end
