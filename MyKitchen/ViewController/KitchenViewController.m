//
//  KitchenViewController.m
//  MyKitchen
//
//  Created by  on 25.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "KitchenViewController.h"
#import "MaschinesView.h"
#import "FoodFloor.h"
#import "OutdoorViewController.h"
#import "MaschineWorkingView.h"
#import "Lion.h"
#import "Pinguin.h"
#import "Cat.h"
#import "Ninja.h"
#import "FoodPlate.h"

#import "FigureTestToolbar.h"

@implementation KitchenViewController

@synthesize rootVC, controlView;
@synthesize selectedFood, selectedMaschineType;


#pragma mark -
- (void)loadView{

    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp ;
    UISwipeGestureRecognizer *swipe2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    swipe2.direction = UISwipeGestureRecognizerDirectionDown ;
	UISwipeGestureRecognizer *swipe3 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    swipe3.direction = UISwipeGestureRecognizerDirectionLeft ;
	leftSwipe = swipe3;
	UISwipeGestureRecognizer *swipe4 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    swipe4.direction = UISwipeGestureRecognizerDirectionRight ;
	rightSwipe = swipe4;
    

    
    
	self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
	
	if (isPad) {
		plateCenter = CGPointMake(500, 605);
	}
	else if(isPhone5){
		plateCenter = CGPointMake(284, 254);
	}
	else{ //normal phone
		plateCenter = CGPointMake(242, 254);
	}
	
	
	bgV = [[UIImageView alloc]initWithFrame:self.view.bounds];
	bgV.autoresizingMask = kAutoResize;
	bgV.image = [UIImage imageWithContentsOfFileUniversal:@"kitchen_BG.jpg"];

	
	backS = [Sprite spriteWithName:@"icon_figures~ipad.png" frame:CGRectMake(10, 10, 125, 125)];
    backS.delegate = self;
	backS.autoresizingMask = UIViewAutoresizingNone;
	if (isPhone) {
		backS.frame = CGRectMake(10, 10, 40, 40);
	}
	

    controlView = [[ControlView alloc]initWithFrame:self.view.bounds];
    controlView.delegate = self;

	window = [Sprite spriteWithName:@"kitchen_window~ipad.png" frame:CGRectMake(0, 0, 400, 400)];
    
	window.autoresizingMask = UIViewAutoresizingNone;
	if (isPhone) {
		window.frame = CGRectMake(0, 0, 167, 167);
	}
	window.delegate = self;

	maschinesView = [[MaschinesView alloc]initWithVC:self];

	figureContainer = [[UIView alloc]initWithFrame:self.view.bounds];
    figureContainer.autoresizingMask = kAutoResize;
    
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
	tap.delegate = self;
	[figureContainer addGestureRecognizer:tap];
 
    desk = [Sprite spriteWithName:@"kitchen_desk_big_2~ipad.png" frame:CGRectMake(232, 548, 560, 200)];
    desk.autoresizingMask =kAutoResize;

	foodfloor = [[Foodfloor alloc]initWithVC:self];
	
	[foodfloor addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)]];
   	[foodfloor addGestureRecognizer:swipe2];
	[foodfloor addGestureRecognizer:swipe];
	[foodfloor addGestureRecognizer:swipe3];
	[foodfloor addGestureRecognizer:swipe4];

	
	[figureContainer addSubview:desk];
    [figureContainer addSubview:foodfloor];
	
	
	[self.view addSubview:bgV];
	[self.view addSubview:window];
	[self.view addSubview:maschinesView];
	[self.view addSubview:figureContainer];
	[self.view addSubview:backS];
    
//    desk.backgroundColor = [UIColor redColor];
	
}

- (void)setup{
    
    //predefined: figureIndex
	
	[figure removeFromSuperview];
	
	FigureIndex figureIndex = [[Controller sharedInstance]figureIndex];

	
	if (figureIndex == FigureCat) {
		figure = [[Cat alloc]initWithFrame:CGRectZero];
	}
	else if(figureIndex == FigureLion){
		figure = [[Lion alloc]initWithFrame:CGRectZero];

	}
	else if(figureIndex == FigureNinja){
		figure = [[Ninja alloc]initWithFrame:CGRectZero];
	}
	else if(figureIndex == FigurePinguin){
		figure = [[Pinguin alloc]initWithFrame:CGRectZero];
	}
//	NSLog(@"figure:%@",figure);

	figure.delegate = self;
	
	[figure toEatStatus];
	
	[figureContainer insertSubview:figure belowSubview:desk];
	
	[figure performSelector:@selector(runSit) withObject:nil afterDelay:1];

	[foodfloor performSelector:@selector(goRandom) withObject:nil afterDelay:2];

}


- (void)viewDidAppear:(BOOL)animated{
	L();
	[super viewDidAppear:animated];
	
	[[AudioController sharedInstance]playBGMusicWithScene:SceneKitchen];
	
	// 打开foodfloor
	[self startFoodfloor:YES];
	
	//打开maschineview
	[maschinesView open];
	
	[self layoutADBanner:[AdView sharedInstance]];
    
	[self test];
    
//    NSLog(@"desk # %@, desk.superv # %@",desk,desk.superview);
//    NSLog(@"window# %@, window.superv # %@",window,window.superview);
}


- (void)didReceiveMemoryWarning{
	L();
	[super didReceiveMemoryWarning];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Notification

- (void)registerNotifications{
    
    //
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleAdviewNotification:) name:NotificationAdChanged object:nil];
    
}

- (void)handleAdviewNotification:(NSNotification*)notification{
    [self layoutADBanner:notification.object];
    
}

#pragma mark - Adview


- (void)layoutADBanner:(AdView *)banner{
    
    L();
    
    [UIView animateWithDuration:0.25 animations:^{
		
		if (banner.isAdDisplaying) { // 从不显示到显示banner
            
			[banner setOrigin:CGPointMake(0, _h - banner.height)];
            figureContainer.frame = CGRectMake(0, -_hAdBanner, _w, _h);

			[rootVC.view addSubview:banner];
		}
		else{
            figureContainer.frame = CGRectMake(0, 0, _w, _h);
			[banner setOrigin:CGPointMake(0, _h)];
		}
		
    }];
    
}

//
//#pragma mark - ADView
//
//- (void)layoutBanner:(UIView*)banner loaded:(BOOL)loaded{
//	
//	L();
//	
//	[UIView animateWithDuration:0.25 animations:^{
//		
//		if (loaded) { // 从不显示到显示banner
//            
//			figureContainer.frame = CGRectMake(0, -_hAdBanner, _w, _h);
//			
//			[banner setOrigin:CGPointMake(0, _h - _hAdBanner)];
//			
//		}
//		else{
//            
//			figureContainer.frame = CGRectMake(0, 0, _w, _h);
//			[banner setOrigin:CGPointMake(0, _h)];
//		}
//		
//    }];
//	
//    //	//	NSLog(@"H# %f,hBanner # %f,banner # %@",_h,_hAdBanner,banner);
//    //	NSLog(@"foodfloor # %@",foodfloor);
//	
//}

#pragma mark - SpriteDelegate
- (void)spriteDidClicked:(Sprite *)sprite{
	
		
	if (sprite == window) {
		
		[self toOutdoor];
	
	}
    else if (sprite == backS) {

		[[AudioController sharedInstance]play:AudioButton];
		
		[NSObject cancelPreviousPerformRequestsWithTarget:figure];
		
        [AnimationManager runSpinAnimationOnView:sprite duration:0.6 clockwise:NO];
        [rootVC performSelector:@selector(toFigure) withObject:nil afterDelay:0.6];

    }
	else if(sprite == figure){

		
		if (selectedFood) { // 如果盘子有食物
			[figure runHappyWithFood];
		}
		else {
			[figure runUnhappyWithoutFood];
		}
	}

}
//
//
//#pragma mark - Gesture
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//	L();
//	UIView *v = touch.view;
//	NSLog(@"touch in view # %@",v);
//	
//	return NO;
//}

#pragma mark - ControlView


-(UISwipeGestureRecognizer*)leftSwipeOnDelegate{

	return leftSwipe;
}


-(UISwipeGestureRecognizer*)rightSwipeOnDelegate{
//	L();
	//	NSLog(@"leftSwipe:%@",leftSwipe);
	return rightSwipe;
}

- (BOOL)willPanPiece:(UIPanGestureRecognizer *)gestureRecognizer inView:(UIView *)controllView{
//    L();

	UIView *v = [gestureRecognizer view];
	
	if (!selectedFood) { // 如果没有selectedfood,那么这个food就是selectedfood
		selectedFood = (Food*)[gestureRecognizer view];
	}
	else { // 如果有了selectedfood，那么要判断v是否是selectedfood
		if (v != selectedFood) {
			NSLog(@"new food isnt' selectedfood'");
			return NO;
		}
	}
	
//	//判断figure是否该张嘴
	
	FoodTasteType tasteType = [figure willEatFood:selectedFood];

	//这个判断可以放到 begin的时候去
	if (tasteType != FoodTasteWillNotEat) {
		
		// stop runsit; 当end pan 的时候恢复，
		[figure runWaitingForEat];
	}

	
	if (gestureRecognizer.state == UIGestureRecognizerStateBegan) { // 移动的开始
		
		if ([selectedFood.superview isKindOfClass:[FoodPlate class]]) {// 如果在platte上，close foodfloor

			[self startFoodfloor:NO];
            
			// 因为连贯性的问题，所以food要作为继续运动的piece，copy留在原地
			copyFood = [selectedFood copy];
            [controlView addGestureRecognizersToPiece:copyFood];
			copyFood.alpha = 0;
            [selectedFood.superview addSubview:copyFood];
			[selectedFood moveOrigin:CGPointMake(0, isPad?528:200)];
//			[self.view addSubview:selectedFood];
			[figureContainer addSubview:selectedFood];
			
			// 如果foodcategory不能被work，maschinev相应的img变虚	
			isPaning = YES;
		
		}
		
		//pan begin
		
		[maschinesView setFoodWorkable:selectedFood.category];
		
		[self performSelector:@selector(setEyesMoveFlag) withObject:nil afterDelay:0.8];

		NSDictionary *dict = @{
		@"Food": selectedFood.categoryName,
		};
		
//		NSLog(@"dict # %@",dict);
		
		[Flurry logEvent:@"Food" withParameters:dict];
	
	}
	else if(gestureRecognizer.state == UIGestureRecognizerStateChanged){
		//if food is in the maschine, and maschine can use it, let the food become useable
		
		/*
		 可以考虑等1s之后才动眼睛
		 */
		if (eyesMoveFlag) {
			//  根据point的位置移动figure的眼睛
			CGPoint foodPoint = [gestureRecognizer locationInView:figure];
			
			[figure runEyesWithPoint:foodPoint];
		}
	
	}
    else if(gestureRecognizer.state == UIGestureRecognizerStateEnded){ // 移动的结束
				
        CGPoint pointOnMaschineView = [gestureRecognizer locationInView:maschinesView];
		selectedMaschineType = [maschinesView maschineTypeWithPoint:pointOnMaschineView foodCategory:selectedFood.category];

		if(selectedMaschineType!=MaschineNone){ //如果在maschine上，打开maschineview
			
			[figure runBack];
			
			[self toMaschineWorkingView];
			
			//figure 闭嘴
			[figure runCloseMouth];
			
			
			[figure performSelector:@selector(runSit) withObject:nil afterDelay:1];
			
		}
		else if (CGRectIntersectsRect(selectedFood.frame, [self mouthRect]) && tasteType != FoodTasteWillNotEat) { //如果在嘴边也能吃
			// NSLog(@"eat!!!");

			[selectedFood removeGestureRecognizer:gestureRecognizer];

			//自动做吃完的反应：happy,sad,yummy
			figure.selectedTaste = tasteType;
			
			[figure runEat];
			
			// 让selectedfood缩小并消失
			CGFloat endWidthOfFood = selectedFood.frame.size.width/5;
			CGFloat endHeightOfFood = selectedFood.frame.size.height/5;
			
			[UIView animateWithDuration:0.3 animations:^{
				
				selectedFood.frame = CGRectMake( [self mouthRect].origin.x,[self mouthRect].origin.y, endWidthOfFood, endHeightOfFood);
//				NSLog(@"selectedFood:%@",NSStringFromCGRect(selectedFood.frame));
				
			} completion:^(BOOL finished) {
				
				[selectedFood removeFromSuperview];
				selectedFood = nil;
				
			}];
			
			[figure performSelector:@selector(runSit) withObject:nil afterDelay:figure.durationOfEating+1];
			
        }
		else  { //如果不能吃也不在机器上 put food to plate, 放回去

			[figure runBack];
			
			[UIView animateWithDuration:0.5 animations:^{
				selectedFood.frame = [self foodPositionOnPlate:selectedFood];
			} completion:^(BOOL finished) {
				
			}];
			

			//figure 闭嘴
			[figure runCloseMouth];
			
			[figure performSelector:@selector(runSit) withObject:nil afterDelay:1];
		}
		
		//end of pan
		
		isPaning = NO;
		[maschinesView reset];
		eyesMoveFlag = NO;
		
    }
	
	return YES;
}

#pragma mark - IBAction


- (IBAction)handleTap:(UITapGestureRecognizer*)gesture{
    //	L();
	CGPoint point  = [gesture locationInView:self.view];
    //	NSLog(@"point # %@",NSStringFromCGPoint(point));
    
	UIView *v = [gesture view];
	if (v == foodfloor && !foodfloor.isOpen) {
        //		NSLog(@"open foodfloor");
		
		[self startFoodfloor:YES];
	}
	else if (CGRectContainsPoint(window.frame, point)) { // 如果点击到了window
        
		[self toOutdoor];
	}
    
    
}

- (IBAction)handleSwipe:(UISwipeGestureRecognizer*)gesture{
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionUp) {//控制foodfloor
        [self startFoodfloor:YES];
    }
    if ( gesture.direction == UISwipeGestureRecognizerDirectionDown) {
        [self startFoodfloor:NO];
    }
	if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        
		[foodfloor goNext];
	}
	else if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        
		[foodfloor goPrevious];
	}
}

#pragma mark - Navigation


-(void)toMaschineWorkingView{

	L();
	
	if (!maschineWorkingView) {
		maschineWorkingView = [[MaschineWorkingView alloc]initWithFrame:self.view.bounds];
        maschineWorkingView.vc = self;
        maschineWorkingView.tag = kTagMaschineWorkingView;

	}
	
	maschineWorkingView.maschineType = selectedMaschineType;
    maschineWorkingView.food = selectedFood;
	
    //在addsubview之前一定要setup！
    [maschineWorkingView setup];
	
	
	[self.view addSubview:maschineWorkingView];
}


// 打开和关闭Foodfloor 

- (void)startFoodfloor:(BOOL)flag{
	
	if (isPaning) { // 如果食物在移动的过程，那么foodfloor不应该被打开
		return;
	}
	
    if (!flag) { // figure 放大 to eating, close
		
        [UIView animateWithDuration:0.5 animations:^{

			[foodfloor close];

        } completion:^(BOOL finished) {
			
        }];
    }
    else {// figure 缩小 to choose food , open 
		
      //selectedfood 在打开foodfloor的时候，insert到foodfloor的下方，这样事物就能从foodfloor后面掉下去
		
	
		//原本在foodfloow上空着的食物重新出现
		
		copyFood.alpha = 1.0;
		
		[self.view insertSubview:selectedFood belowSubview:foodfloor];
		
        [UIView animateWithDuration:0.5 animations:^{

			[foodfloor open];

			[selectedFood moveOrigin:CGPointMake(0, 300)];
        } completion:^(BOOL finished) {
            selectedFood = nil;
			
        }];
    }
}


- (void)toOutdoor{
	
	[[AudioController sharedInstance]play:AudioButton];
	
	[[AudioController sharedInstance]playBGMusicWithScene:SceneOutdoor];
	
	outdoorVC = [[OutdoorViewController alloc]init];
	outdoorVC.vc = self;
	outdoorVC.view.autoresizingMask = kAutoResize;
	
	[self.view addSubview:outdoorVC.view];
	
//	[rootVC hideBanner];
}

#pragma mark -　Function
- (CGRect)foodPositionOnPlate:(Food*)food{
	return CGRectMake(plateCenter.x-food.width/2, plateCenter.y-food.height/2, food.width, food.height);
	
}

- (CGRect)mouthRect{
	
	return CGRectMake(figure.eatingPosition.origin.x+figure.mouthPosition.origin.x, figure.eatingPosition.origin.y+figure.mouthPosition.origin.y, figure.mouthPosition.size.width,figure.mouthPosition.size.height);
	
}


- (void)getFoodFromOutdoor:(Food*)outdoorFood{
	
	[[AudioController sharedInstance]playBGMusicWithScene:SceneKitchen];
	
    [self startFoodfloor:NO];
    [outdoorVC.view removeFromSuperview];
	
	[selectedFood removeFromSuperview];
	
    
	// if outdoorFood is fish
	if ([outdoorFood.defaultImageName isEqualToString:@"fish_default1.png"]) {
		
		selectedFood = [[Food alloc]initWithName:@"fish2_default.png" frame:isPad?CGRectMake(700, 470, 150, 70):CGRectMake(368, 209, 60, 30)];
	}
	
	selectedFood = outdoorFood;
    //
	[controlView addGestureRecognizersToPiece:selectedFood];
	
	
	// let selectedFood fall from oben
	[selectedFood setFrameCenter:CGPointMake(self.view.width/2, 0)];
	[figureContainer addSubview:selectedFood];
	
	[UIView animateWithDuration:0.6 animations:^{
        selectedFood.frame = [self foodPositionOnPlate:selectedFood];
	}];
	
	outdoorVC = nil;
	
//	[rootVC showBanner];
	
	
	NSDictionary *dict = @{
                           @"Food": @"Outdoor",
                           };
	
	[Flurry logEvent:@"Food" withParameters:dict];
}




- (void)getFoodFromWorkingView:(Food*)workedFood{
	
	
	[maschineWorkingView removeFromSuperview];
	selectedFood = workedFood;
	
	[selectedFood enableAllGestures];
	
	
	[selectedFood setFrameCenter:CGPointMake(self.view.width, 0)];
	[figureContainer addSubview:selectedFood];
    
	[UIView animateWithDuration:0.6 animations:^{
		selectedFood.frame = [self foodPositionOnPlate:selectedFood];
	}];
    
	//food start steaming
	[selectedFood startSteaming];
    
}


#pragma mark - Intern Fcns

- (void)setEyesMoveFlag{

	eyesMoveFlag = YES;
}

#pragma mark - Test
- (void)test{

	
}


- (IBAction)toolbarButtonPressed:(id)sender{
	
	
	int tag = [sender tag];
	if (tag == kTagFigureTest0) {
		
		[figure runBack];
	}
	else if (tag == kTagFigureTest1) {
		[figure runHappy];
		
	}
	else if(tag == kTagFigureTest2){
		
		[figure runSad];
		
	}
	else if(tag == kTagFigureTest3){
		
		[figure runYummy];
		
	}
	else if(tag == kTagFigureTest4){
		
		[figure playLeft];
	}
	else if(tag == kTagFigureTest5){
		[figure playUp];
	}
	else if(tag == kTagFigureTest6){
		[figure playDown];
	}
	else if(tag == kTagFigureTest7){
		[figure playLeft];
	}
	else if(tag == kTagFigureTest8){
		[figure playRight];
	}
	else if(tag == kTagFigureTest9){
		
		[figure playLeftUpBack];
	}
	else if(tag == kTagFigureTest10){
		
		[figure playRightUpBack];
	}
	else if(tag == kTagFigureTest11){
		//		[figure playLeftBack];
		[figure playRightDownBack];
	}
	else if(tag == kTagFigureTest12){
		//		[figure playRightBack];
		[figure playLeftDownBack];
	}
	
}

@end
