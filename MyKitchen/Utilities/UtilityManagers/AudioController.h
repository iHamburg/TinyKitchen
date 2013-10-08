//
//  AudioController.h
//  FirstThings_Uni
//
//  Created by  on 11.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import  <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Utilities.h"

typedef enum{
	AudioButton,
	AudioFigureChoosing,
	AudioFigureNinja,
	AudioFigureLion,
	AudioFigureCat,
	AudioFigurePinguin
}AudioType;

@interface AudioController : NSObject{

	
	SystemSoundID audioIDs[10]; // 一次性的都能放在这里


	AVAudioPlayer *homeBGPlayer, *figureBGPlayer, *kitchenBGPlayer, *outdoorBGPlayer;
	NSArray *bgPlayers;
	BOOL silent;
	
}
@property(nonatomic, assign) BOOL silent;

+(id)sharedInstance;


- (void)play:(AudioType)type;

- (void)playBGMusicWithScene:(Scene)scene;
- (void)stopBGMusicWithScene:(Scene)scene;
- (void)stopBGMusic;
- (void)playFigureSound:(FigureIndex)figure;
@end
