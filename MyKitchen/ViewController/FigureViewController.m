//
//  FigureViewController.m
//  MyKitchen
//
//  Created by  on 25.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "FigureViewController.h"


@implementation FigureViewController

@synthesize rootVC;



- (void)loadView{
	L();

	self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
	[self.view setBGView:@"Figures2_BG.jpg"];

	
	homeB = [UIButton buttonWithFrame:CGRectMake(10, 10, 60, 60) title:nil image:@"home.png" target:self actcion:@selector(buttonClicked:)];
	[homeB setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
	homeB.autoresizingMask = kAutoResize;
	
	
	dash = [FigureDash spriteWithName:@"dinnerware~ipad.png" frame:CGRectMake(380, 260, 250, 250)];
	dash.autoresizingMask =kAutoResize;
	
	ninja = [Sprite spriteWithName:@"Figures_ninjia~ipad.png" frame:CGRectMake(100, 30, 300, 300)];
	ninja.tag = 1;
	ninja.delegate = self;
	ninja.autoresizingMask = UIViewAutoresizingNone;
	
	cat = [Sprite spriteWithName:@"Figures_cat~ipad.png" frame:CGRectMake(620, 30, 300, 300)];
	cat.delegate = self;
	cat.tag = 2;
	cat.autoresizingMask = UIViewAutoresizingNone;
    
	lion = [Sprite spriteWithName:@"Figures_lion~ipad.png" frame:CGRectMake(100, 400, 300, 300)];
    lion.delegate = self;
	lion.tag = 3;
	lion.autoresizingMask = UIViewAutoresizingNone;
	
	pinguin = [Sprite spriteWithName:@"Figures_pinguin~ipad.png" frame:CGRectMake(620, 400, 300, 300)];
	pinguin.delegate = self;
	pinguin.autoresizingMask = UIViewAutoresizingNone;
	pinguin.tag = 4;
	

	
	if (isPhone5) {
		CGFloat length = 120;
		ninja.frame = CGRectMake(60, 20, length, length);
		cat.frame = CGRectMake(375, 20, length, length);
		lion.frame = CGRectMake(60, 180, length, length);
		pinguin.frame = CGRectMake(375, 180, length, length);
	}
	else if(!isPad){ //  normal iphone
		CGFloat length = 120;
		ninja.frame = CGRectMake(60, 20, length, length);
		cat.frame = CGRectMake(300, 20, length, length);
		lion.frame = CGRectMake(60, 180, length, length);
		pinguin.frame = CGRectMake(300, 180, length, length);
	}

	
	
	[self.view addSubview:ninja];
	[self.view addSubview:cat];
	[self.view addSubview:lion];
	[self.view addSubview:pinguin];
	[self.view addSubview:dash];
	[self.view addSubview:homeB];
	
//	CGFloat wLock = isPad?64:32;

	NSLog(@"isIAPfull version # %d",isIAPFullVersion);
	
	if (!isPaid() && !isIAPFullVersion) {
//		lock1 = [[UIImageView alloc]initWithFrame:CGRectMake(0.2*_w, 0.68*_h, wLock, wLock)];
//		lock1.image = [UIImage imageNamed:@"Icon_Lock.png"];
//
//		lock2 = [[UIImageView alloc]initWithFrame:CGRectMake(0.73*_w, 0.68*_h, wLock, wLock)];
//		lock2.image = [UIImage imageNamed:@"Icon_Lock.png"];
//
//		
//		[self.view addSubview:lock1];
//		[self.view addSubview:lock2];

		lion.image = [UIImage imageNamedUniversal:@"Figures_lion_IAP.png"];
		pinguin.image = [UIImage imageNamedUniversal:@"Figure_penguin_IAP.png"];
	}
}

#pragma mark - IBAction
- (IBAction)buttonClicked:(id)sender{
	[[AudioController sharedInstance]play:AudioButton];
	if (sender == homeB) {
		[rootVC toHome];
		return;
	}

}

#pragma mark - Sprite
- (void)spriteDidClicked:(Sprite *)sprite{
	L();
	
	
	Controller *controller = [Controller sharedInstance];

	controller.figureIndex = sprite.tag -1;
	
	
	if (isPaid() || isIAPFullVersion || sprite == ninja || sprite == cat) {
		
		[[AudioController sharedInstance]play:AudioFigureChoosing];
		
		[dash play];
		
		//sprite 旋转一圈
		[AnimationManager runSpinAnimationOnView:sprite duration:0.5 rotations:1 repeat:0];
		
		// 去kitchen
		[rootVC performSelector:@selector(toKitchen) withObject:nil afterDelay:1];
	}
	else {
//		NSLog(@"show alert");
		if (sprite == lion) {
			[[AudioController sharedInstance]play:AudioFigureLion];
		}
//		else if(sprite == cat){
//			[[AudioController sharedInstance]play:AudioFigureCat];
//		}
		else if(sprite == pinguin){
			[[AudioController sharedInstance]play:AudioFigurePinguin];
		}
		
		[[MyStoreObserver sharedInstance]showFullVersionAlert];
		
	}

	
}

//#pragma mark - IAP
//
//- (UIView*)viewForLoading{
//	return self.view;
//}
//- (void)didCompleteIAPWithIdentifier:(NSString *)identifier{
//	L();
//	
//	// 
//	[[NSUserDefaults standardUserDefaults]setBool:YES forKey:kIAPFullVersion];
//	
//	[[NSUserDefaults standardUserDefaults]synchronize];
//	
//	[rootVC removeIAPFeatures];
//
//}
//
//- (void)removeIAPFeature{
//	[lock1 removeFromSuperview];
//	[lock2 removeFromSuperview];
//	[lock3 removeFromSuperview];
//	
//	cat.image = [UIImage imageNamedUniversal:@"Figures_cat.png"];
//	lion.image = [UIImage imageNamedUniversal:@"Figures_lion.png"];
//	pinguin.image = [UIImage imageNamedUniversal:@"Figures_pinguin.png"];
//}
@end
