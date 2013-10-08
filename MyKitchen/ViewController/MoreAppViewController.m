//
//  MoreAppViewController.m
//  KidsLearn
//
//  Created by  on 04.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "MoreAppViewController.h"

@implementation MoreAppViewController

@synthesize rootVC;

- (void)viewDidLoad{

	self.view.backgroundColor = [UIColor colorWithHEX:@"27282a"];
	
	imgV1.userInteractionEnabled = YES;
	[imgV1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
	imgV2.userInteractionEnabled = YES;
	[imgV2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
	imgV3.userInteractionEnabled = YES;
	[imgV3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];

	if (!isPad) {
		
		imgV1.image = nil;
		imgV2.image = nil;
		imgV3.image = nil;
		
		CGFloat width = 568;
		
		scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
		scrollView.autoresizingMask = kAutoResize;
		scrollView.contentSize = CGSizeMake(0, 600);
		scrollView.backgroundColor = [UIColor colorWithHEX:@"3b3e40"];

		bgV.image = nil;

		v1 = [[MoreAppView alloc]initWithFrame:CGRectMake(0, 0, width, 200)];
		v1.iconImg = [UIImage imageWithContentsOfFileUniversal:@"appIcon_NSC.png"];
		v1.description = @"3in1 Kids Games - Number, Color and Shape is designed for toddlers / preschoolers / kindergarten kids to learn colors, shapes and counting with pretty illustration, warm voiceover and funny interactive, animated activities.\n\n3in1 Kids Games is a fantastic tool that helps little ones better understand their colors, numbers and shapes. It uses examples such as toys or fruits to have young users first recognize the different colors and shapes found in the world around them. Learning is a natural process, and games are an effective way to help children learn about them.";
		v1.title = @"3in1 Kids Games";
		v1.delegate = self;
		
		v2 = [[MoreAppView alloc]initWithFrame:CGRectMake(0, v1.frame.origin.y+v1.height, width, 200)];
		v2.iconImg = [UIImage imageWithContentsOfFileUniversal:@"appIcon_MyeCard.png"];
		v2.description = @"My eCard featured in United States, Australia, Canada, Germany, France, United Kingdom, Hong Kong, Saudi Arabia and Taiwan!\nMy eCard is an app that can help you create your personal and individual e-cards with your own photos, in a very comfortable way.\nBesides writing your own texts, you can also find beautiful and special verses to simplify creating a card or for your spirit. All you need to concern yourself with is personalizing your card by using a simple way in which you can tap, scale, rotate, drop and drag. As easy to use as this app, it cuts all tiresome steps and lets users create a great card just through 3 steps or even less.";
		v2.title = @"My eCard: Send it Later";
		v2.isfeatured = YES;
		v2.delegate = self;
		
		v3 = [[MoreAppView alloc]initWithFrame:CGRectMake(0, v2.frame.origin.y+v2.height, width, 200)];
		v3.iconImg = [UIImage imageWithContentsOfFileUniversal:@"appIcon_cityQuiz.png"];
		v3.description = @"Information can be a burden, when there is too much information, or it is not in a form that can be easily understood. City Quiz is an application specifically designed for it. It represents famous cities in the world. But for each city, City Quiz demonstrates 10 important points that might be interesting to you. Through pictures and exercises, you can easily broaden your knowledge on the basis of human memory. Each city has its own characteristics. Pour a cup of tea and take a look at what you might not know.";
		v3.title = @"City Quiz";
		v3.delegate = self;
		
		[scrollView addSubview:v1];
		[scrollView addSubview:v2];
		[scrollView addSubview:v3];
		
	
		[backB setOrigin:CGPointMake(15, 15)];
		[scrollView addSubview:backB];
		[self.view addSubview:scrollView];
	}

}

- (void)dealloc{
	L();
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - IBAction

- (IBAction)handleTap:(UITapGestureRecognizer*)gesture{
	UIView *v = [gesture view];
	if (v == imgV1) {
		[self toApp1:nil];
	}
	else if(v == imgV2){
		[self toApp2:nil];
	}
	else if(v == imgV3){
		[self toApp3:nil];
	}
}


- (void)moreAppViewDidClicked:(MoreAppView *)moreAppView{
	if (moreAppView == v1) {
		[self toApp1:nil];
	}
	else if(moreAppView == v2) {
		[self toApp2:nil];
	}
	else if(moreAppView == v3){
		[self toApp3:nil];
	}
}
#pragma mark - Navigation
// kidsgames
- (IBAction)toApp1:(id)sender{
	NSLog(@"KidsGames");
	[[AudioController sharedInstance]play:AudioButton];
	
	//appID = @"540869085";
	
	NSURL *url = [NSURL URLWithString:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=540869085&mt=8"];
	[[UIApplication sharedApplication] openURL:url];
}
// myecard:
- (IBAction)toApp2:(id)sender{
	NSLog(@"myecard");
	
	[[AudioController sharedInstance]play:AudioButton];

	
	NSString *appStr = isPaid()?@"495584349":@"540736134";
	NSString *urlStr = [NSString stringWithFormat:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@&mt=8",appStr];
	
	NSURL *url = [NSURL URLWithString:urlStr];
	[[UIApplication sharedApplication] openURL:url];
	
}

// cityquiz: 425936134
- (IBAction)toApp3:(id)sender{
	NSLog(@"cityquiz");
	[[AudioController sharedInstance]play:AudioButton];


//	[[AudioController sharedInstance]playSound:AudioButton];
	NSURL *url = [NSURL URLWithString:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=425936134&mt=8"];
	[[UIApplication sharedApplication] openURL:url];
}


- (IBAction)back:(id)sender{
	[[AudioController sharedInstance]play:AudioButton];


//	[self.view removeFromSuperview];
//	[rootVC viewDidAppear:YES];

	[rootVC toHome];
}
@end
