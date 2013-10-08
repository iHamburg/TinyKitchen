//
//  RootViewController.m
//  MyKitchen
//
//  Created by  on 25.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "RootViewController.h"
#import "FigureViewController.h"
#import "KitchenViewController.h"
#import "HomeViewController.h"
#import "Info2ViewController.h"
#import "MoreAppViewController.h"

@implementation RootViewController

@synthesize homeVC,figureVC,moreVC,kitchenVC;

@synthesize firstVersion,lastVersion,thisVersion,isFirstOpen,isUpdateOpen;


- (HomeViewController*)homeVC{
	if (!homeVC) {
		homeVC = [[HomeViewController alloc]init];
		homeVC.view.autoresizingMask = kAutoResize;
		homeVC.view.frame = self.view.bounds;
		homeVC.rootVC = self;
	}
	return homeVC;
}
- (FigureViewController*)figureVC{
	if(!figureVC){
		figureVC = [[FigureViewController alloc]init];
		figureVC.rootVC = self;
		figureVC.view.autoresizingMask = kAutoResize;
		figureVC.view.frame = self.view.bounds;

	}
    return figureVC;
}

- (KitchenViewController*)kitchenVC{
	if(!kitchenVC){
		kitchenVC = [[KitchenViewController alloc]init];
		kitchenVC.rootVC = self;
		kitchenVC.view.autoresizingMask = kAutoResize;
		kitchenVC.view.frame = self.view.bounds;
		
	}
	
	return kitchenVC;
}

#pragma mark -


+(id)sharedInstance{
	
	static id sharedInstance;
	
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]initWithNibName:@"RootViewController" bundle:nil];
	}
	return sharedInstance;
	
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//	L();
	
	[ExportController sharedInstance];

	if (isPad) {
		_r = CGRectMake(0, 0, 1024, 768);
		_containerRect = _r;
	}
	else if(isPhone5){
		_r = CGRectMake(0, 0, 568, 320);
		_containerRect = CGRectMake(44, 0, 480, 320);
	}
	else{
		_r = CGRectMake(0, 0, 480, 320);
		_containerRect = _r;
	}
		
	
	
	self.view.frame = _r;

	_h = self.view.height;
	_w = self.view.width;
	_hAdBanner = isPad?66:32;

	
	[Controller sharedInstance];

	self.homeVC.view.alpha = 1;
	self.figureVC.view.alpha = 1;
	self.kitchenVC.view.alpha = 1;


	[self toHome];
	
	[self initBanner];
	
	NSLog(@"root # %@",self.view);
	
}




- (void)viewDidAppear:(BOOL)animated{

	[super viewDidAppear:animated];

	[self test];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    
}

- (NSUInteger)supportedInterfaceOrientations{
	//	L();
	return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}


- (void)didReceiveMemoryWarning{
	L();
	[super didReceiveMemoryWarning];
}


- (void)checkVersion{
	
	
	firstVersion = [[NSUserDefaults standardUserDefaults]floatForKey:kFirstVersionKey];
	lastVersion = [[NSUserDefaults standardUserDefaults]floatForKey:kLastVersionKey];
	thisVersion = [[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey] floatValue];
	
	if (firstVersion == 0.0) { // 第一次安装app
		isFirstOpen = YES;
		
		firstVersion =  [[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey] floatValue];
		[[NSUserDefaults standardUserDefaults]setFloat:firstVersion forKey:kFirstVersionKey];
		
		lastVersion = firstVersion;
		[[NSUserDefaults standardUserDefaults]setFloat:lastVersion forKey:kLastVersionKey];
		
	}
	else{ // 已经安装过app，再次打开
		if (thisVersion != lastVersion) {
			isUpdateOpen = YES;
		}
		
		[[NSUserDefaults standardUserDefaults]setFloat:thisVersion forKey:kLastVersionKey];
	}
	
	
	
}

- (void)preLoad{
	
	if (isFirstOpen) {
		
//		[self toInstruction];
	}
	else if(isUpdateOpen){
		
		//		if (thisVersion == isPaid()?2.5:1.2) {
		//
		//		}
	}
	else{
		
	}
	
	
}

#pragma mark - Navi

- (void)toHome{
	
	[[AudioController sharedInstance]playBGMusicWithScene:SceneHome];
    [self fadeinSubView:self.homeVC.view outSubViews:[NSArray arrayWithObjects:self.figureVC.view, nil]];

	//消除缓存

	moreVC = nil;
	
	[self.view addSubview:_adContainer];
}

/*
 
 home-> figure
 
 kitchen ->figure
 */

-  (void)toFigure{


	[[AudioController sharedInstance]playBGMusicWithScene:SceneHome];
    [self fadeinSubView:self.figureVC.view outSubViews:[NSArray arrayWithObjects:self.kitchenVC.view,self.homeVC.view,nil]];
	
	[self.view addSubview:_adContainer];
   
}

- (void)toKitchen{


    [[AudioController sharedInstance]playBGMusicWithScene:SceneKitchen];
	
	[self.kitchenVC setup];
	
	NSDictionary *dict = @{
	@"Figure": [Figure NSStringFromFigureIndex:[[Controller sharedInstance]figureIndex]],
	};
	
	[Flurry logEvent:@"Figure" withParameters:dict];

	
	
    [self fadeinSubView:self.kitchenVC.view outSubViews:[NSArray arrayWithObject:self.figureVC.view]];


	[self.view addSubview:_adContainer];
}

/*
 每次直接调用，返回就消除
 */

// home->info 
- (void)toInfo{

//	
//	infoVC = [[InfoViewController alloc ]initWithNibName:@"InfoViewController" bundle:nil];
//	infoVC.view.autoresizingMask = kAutoResize;
//	infoVC.rootVC = self;
//	infoVC.view.frame = self.view.bounds;
//	[self.view addSubview:infoVC.view];
	
	if (!info2VC) {
		info2VC = [[Info2ViewController alloc]init];
		info2VC.view.alpha = 1;
		info2VC.root = self;
	}
	
	
	
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	
    [self.view addSubview:info2VC.view];
    
    [UIView commitAnimations];
	


}

- (void)closeInfo{
	
	[[AudioController sharedInstance]play:AudioButton];
	
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	
    [info2VC.view removeFromSuperview];
	
    [UIView commitAnimations];
}

//home -> morevc
- (void)toMore{
	
	moreVC = [[MoreAppViewController alloc]initWithNibName:@"MoreAppViewController" bundle:nil];
	moreVC.rootVC = self;
	moreVC.view.frame = self.view.bounds;
    [self.view addSubview:self.moreVC.view];
}



- (void)fadeinSubView:(UIView*)subview outSubViews:(NSArray*)outViews{
    
    subview.alpha = 0;
    
    [self.view addSubview:subview];

    [UIView animateWithDuration:0.6 delay:0 options: UIViewAnimationOptionCurveEaseIn animations:^{
        subview.alpha = 1;

        for (UIView *v in outViews) {
            v.alpha = 0;
        }
    } completion:^(BOOL finished) {
        for (UIView *v in outViews) {
			v.alpha = 1;
            [v removeFromSuperview];
        }
    }];
}



#pragma mark - AdView

- (void)initBanner{
	L();
//	NSLog(@"w # %f, h # %f",_w,_h);
	//
	if (isPaid() || isIAPFullVersion) {
		[_adContainer removeFromSuperview];
		_adContainer.delegate = nil;
		_adContainer = nil;
	}
	else{
		if (!_adContainer) {
			_adContainer = [[AdView alloc]initWithFrame:CGRectMake(0, _h-_hAdBanner, _w, _hAdBanner)];
			_adContainer.delegate = self;

		}
		
		
		[self.view addSubview:_adContainer];

		
	}
}

- (void)layoutBanner:(BOOL)loaded{
	
	//kitchen的floor位置先定下来了，没有及时的layout？
	
	[self.kitchenVC layoutBanner:_adContainer loaded:loaded];
	
}


- (void)showBanner{
	_adContainer.hidden = NO;
}
- (void)hideBanner{
	_adContainer.hidden = YES;
}


#pragma mark - IAP


- (void)IAPDidFinished:(NSString*)identifier{
	
	L();
	// ads
	
	[self initBanner];

	[self toHome];
	
	self.kitchenVC = nil;
	self.figureVC = nil;
}
- (void)IAPDidRestored{
	
	L();
	
	[self initBanner];
	[self toHome];
	
	
	self.kitchenVC = nil;
	self.figureVC = nil;

}




#pragma mark - Test
- (void)test{

//	UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFileUniversal:@"appIcon_cityQuiz.png"]];
//	[self.view addSubview:imgV];

}
@end
