//
//  OutdoorViewController.m
//  MyKitchen
//
//  Created by  on 25.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "OutdoorViewController.h"


@implementation OutdoorViewController

@synthesize vc;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    L();
	
    self.view.frame = _r;
    self.view.backgroundColor = [UIColor blackColor];
	
//	NSLog(@"_r # %@, outdoor # %@",NSStringFromCGRect(_r),self.view);
	
	container = [[UIView alloc]initWithFrame:_containerRect];
    UIImageView *bgV = [[UIImageView alloc]initWithFrame:container.bounds];
	bgV.image = [UIImage imageWithContentsOfFileUniversal:@"outdoor_BG.jpg"];
	[container addSubview:bgV];

	[self.view addSubview:container];
	
	//controlView只要存在设了delegate就可以了
	controlView = [[ControlView alloc]initWithFrame:CGRectZero];
    controlView.delegate = self;
	
	cloud = [Cloud spriteWithName:@"outdoor_cloud.png" frame:isPad?CGRectMake(-300, 0, 200, 100):CGRectMake(-150, 0, 100, 50)];
	

    basket = [Sprite spriteWithName:@"outdoor_basket.png" frame:isPad?CGRectMake(760, 526, 225, 225):CGRectMake(370, 225, 90, 90)];
	basket.delegate = self;
	
	grass = [Sprite spriteWithName:@"grass.png" frame:isPad?CGRectMake(80, 290, 700, 83):CGRectMake(50, 126, 300, 27)];
	grass.userInteractionEnabled = NO;

	arrow = [Sprite spriteWithName:@"Hinweis_arrow.png" frame:isPad?CGRectMake(650, 670, 120, 60):CGRectMake(305, 270, 50, 25)];
	
	
    CGRect butterflyRect = isPad?CGRectMake(50, 526, 80, 80):CGRectMake(20, 250, 30, 30);
    butterfly = [Butterfly spriteWithNames:[NSArray arrayWithObjects:@"Animation_butterfly1.png",@"Animation_butterfly2.png" ,nil]];
    butterfly.frame = butterflyRect;
	butterfly.initialFrame = butterflyRect;
    butterfly.animationDuration = 0.5;
    butterfly.animationRepeatCount = -1;
	butterfly.delegate = self;

	
//  *radish, *aubergine, *carrot, *tomato
	fish = (Fish*)[[FoodManager sharedInstance]foodInOutdoorViewWithIndex:FoodOutdoorFish];
	radish = [[FoodManager sharedInstance]foodInOutdoorViewWithIndex:FoodOutdoorRadish];
	aubergine =  [[FoodManager sharedInstance]foodInOutdoorViewWithIndex:FoodOutdoorAubergine];
	carrot =  [[FoodManager sharedInstance]foodInOutdoorViewWithIndex:FoodOutdoorCarrot];
	tomato =  [[FoodManager sharedInstance]foodInOutdoorViewWithIndex:FoodOutdoorTomato];
    
	
	mushrooms = [[FoodManager sharedInstance]foodMushroomsInOutdoor];
	Food *mushRoom1 = [mushrooms objectAtIndex:0];
	[controlView addGestureRecognizersToPiece:mushRoom1];
	[container addSubview:mushRoom1];
	Food *mushRoom2 = [mushrooms objectAtIndex:1];
	[controlView addGestureRecognizersToPiece:mushRoom2];
	[container addSubview:mushRoom2];
	Food *mushRoom3 = [mushrooms objectAtIndex:2];
	[controlView addGestureRecognizersToPiece:mushRoom3];
	[container addSubview:mushRoom3];
	Food *mushRoom4 = [mushrooms objectAtIndex:3];
	[controlView addGestureRecognizersToPiece:mushRoom4];
	[container addSubview:mushRoom4];
	
    
	apples = [[FoodManager sharedInstance]foodApplesInOutdoor];
	Food *apple1 = [apples objectAtIndex:0];
	[controlView addGestureRecognizersToPiece:apple1];
	[container addSubview:apple1];
	Food *apple2 = [apples objectAtIndex:1];
	[controlView addGestureRecognizersToPiece:apple2];
	[container addSubview:apple2];
	Food *apple3 = [apples objectAtIndex:2];
	[controlView addGestureRecognizersToPiece:apple3];
	[container addSubview:apple3];
	
	[container addSubview:cloud];
    [container addSubview:basket];
	[container addSubview:grass];
    [container addSubview:butterfly];

 
    [controlView addGestureRecognizersToPiece:fish];
	[container insertSubview:fish belowSubview:grass];
	[controlView addGestureRecognizersToPiece:aubergine];
	[container insertSubview:aubergine belowSubview:grass];
	[controlView addGestureRecognizersToPiece:radish];
	[container insertSubview:radish belowSubview:grass];
	[controlView addGestureRecognizersToPiece:carrot];
	[container insertSubview:carrot belowSubview:grass];
	[controlView addGestureRecognizersToPiece:tomato];
	[container insertSubview:tomato belowSubview:grass];
	

	[container addSubview:arrow];
    
}


- (void)viewDidAppear:(BOOL)animated{
    L();
    [super viewDidAppear:animated];

    
    // butterfly to right

	[butterfly play];
    
    // cloud to right

    [cloud play];
	
	// fish move
	[fish performSelector:@selector(play) withObject:nil afterDelay:1.5];
	
	// show arrow , basket become bigger
    arrow.hidden = NO;

	[self performSelector:@selector(hideArrow) withObject:nil afterDelay:2];
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	animation.toValue = [NSNumber numberWithFloat:1.2];
	animation.autoreverses = YES;
	animation.repeatCount = 2;
	animation.duration = 0.5;
	[basket.layer addAnimation:animation forKey:@"scale"];

	NSLog(@"outdoor # %@",self.view);
	
}

- (void)viewDidDisappear:(BOOL)animated{
	L();
	[super viewDidDisappear:animated];
	
	[butterfly stop];
	[fish stop];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


#pragma mark - IBAction


- (void)spriteDidClicked:(Sprite *)sprite{

	L();
	if (sprite == butterfly) {
		NSLog(@"butterfly clicked:%@",sprite);
	}
	else if(sprite == basket){
		[vc getFoodFromOutdoor:nil];
	}
}


#pragma mark - ControlView
- (BOOL)willPanPiece:(UIPanGestureRecognizer *)gestureRecognizer inView:(UIView *)controllView{

	L();
    Food *piece = (Food*)[gestureRecognizer view];
	
	// 如果selected不是nil，而这个piece不是selectedFood,那么returnNO
	if (selectedFood && selectedFood!=piece) {
		return NO;
	}
	
    CGPoint point = piece.center;

//    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
		
		CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
		animation.toValue = [NSNumber numberWithFloat:1.2];
		animation.duration = 0.1;
		animation.autoreverses = YES;
		[piece.layer addAnimation:animation forKey:@"scale"];
        
		selectedFood = piece;
		
		//在开始时把food的位置拉到最高

//		[self.view bringSubviewToFront:piece];
		[container bringSubviewToFront:piece];
    
		if (piece == fish) {
			[NSObject cancelPreviousPerformRequestsWithTarget:fish];
		}
	}
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"pan ended!!!");
        // Put it back
		
		// 回去时把蔬菜放到他们的层里, 并不是所有的食物都是belowgrass
	
		if (CGRectContainsPoint(basket.frame, point)) { // 如果food在篮子里，回到Kitchen
			NSLog(@"back to kitchen");
			Food *food = [piece copy];
			
			[vc getFoodFromOutdoor:food];
			
			//put butterfly back
			[butterfly backToInitialPosition];
		}

		[UIView animateWithDuration:0.5 animations:^{

			[piece backToInitialPosition];
		
		} completion:^(BOOL finished) {
//			[self.view insertSubview:piece belowSubview:grass];
			[container insertSubview:piece aboveSubview:grass];
		}];

		selectedFood = nil;
		
		if (piece == fish) {
			[fish performSelector:@selector(play) withObject:nil afterDelay:1.5];
		}
    }

	return YES;

}

- (void)hideArrow{
	arrow.hidden = YES;
}

@end
