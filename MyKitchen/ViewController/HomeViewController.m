//
//  HomeViewController.m
//  MyKitchen
//
//  Created by  on 29.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.


#import "HomeViewController.h"


@implementation HomeViewController

@synthesize rootVC;

- (void)loadView{
	
	self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
	[self.view setBGView:@"Hauptmenu_BG.jpg"];
	
	
	//25->240
	
	CGFloat wInfo = isPad?200:85;
	
	
	infoB = [UIButton buttonWithFrame:CGRectMake(0.8* _w, 0.26*_h, wInfo, wInfo) title:nil imageName:@"Hauptmenu_Info~ipad.png" target:self action:@selector(buttonClicked:)];
//	infoB.autoresizingMask = kAutoResize;
//	moreB = [UIButton buttonWithFrame:CGRectMake(810, 200, 200, 200) title:nil image:@"Hauptmenu_more_apps~ipad.png" target:self actcion:@selector(buttonClicked:)];
//	moreB.autoresizingMask = kAutoResize;
//	
	
	BOOL silent = [[AudioController sharedInstance]silent];
	CGFloat wSprecher = isPad?50:30;
	CGFloat xSprecher = 0.7*_w;
	CGFloat ySprecher = isPad?20:10;
	sprecherB = [UIButton buttonWithFrame:CGRectMake(xSprecher, ySprecher, wSprecher, wSprecher) title:nil imageName:silent?@"icon_sprecher_off.png":@"icon_sprecher_on.png" target:self action:@selector(buttonClicked:)];

    
	CGFloat wStart = isPad?300:150;
	start = [Sprite spriteWithName:@"icon_figures~ipad.png" frame:CGRectMake(0, 0, wStart, wStart)];
    start.delegate = self;
	start.center = CGPointMake(_w/2, _h/2);
	start.autoresizingMask = UIViewAutoresizingNone;

	
	[self.view addSubview:infoB];
//	[self.view addSubview:moreB];
	[self.view addSubview:start];
	[self.view addSubview:sprecherB];


//	NSLog(@"start # %@",start);
	
}


- (void)viewWillDisappear:(BOOL)animated{
//	L();
	// ipad 在addsubview的时候是不会调用viewwilldisappear的

	[super viewWillDisappear:animated];
	
	[[AudioController sharedInstance]stopBGMusicWithScene:SceneHome];
}


#pragma mark - IBAction
- (IBAction)buttonClicked:(id)sender{
	L();
	
	[[AudioController sharedInstance]play:AudioButton];
	
	if (sender == infoB) {
	
		[rootVC toInfo];
	}

	else if(sender == startB) {
		[rootVC toFigure];
	}
	else if(sender == sprecherB){
	

		BOOL silent = ![[AudioController sharedInstance]silent];
		NSLog(@"isSilent:%d",silent);
		
		[[AudioController sharedInstance]setSilent:silent];
		[sprecherB setBackgroundImage:silent?[UIImage imageNamed:@"icon_sprecher_off.png"]:[UIImage imageNamed:@"icon_sprecher_on.png"] forState:UIControlStateNormal];
	
	
	}
}

#pragma mark - SpriteDelegate

- (void)spriteDidClicked:(Sprite *)sprite{
//    [v.layer removeAllAnimations];
    if (sprite == start) {
		[[AudioController sharedInstance]play:AudioFigureChoosing];
        [AnimationManager runSpinAnimationOnView:sprite duration:0.6 clockwise:arc4random()%2];
        [rootVC performSelector:@selector(toFigure) withObject:nil afterDelay:0.6];
    }
}

@end
