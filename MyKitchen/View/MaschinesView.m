//
//  MaschinesView.m
//  TinyKitchen
//
//  Created by  on 30.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "MaschinesView.h"


@implementation MaschinesView

@synthesize vc, isOpen;

- (id)initWithVC:(KitchenViewController*)_vc{
	vc = _vc;
	openRect = isPad?CGRectMake(424, 0, 600, 350):CGRectMake(_w-250, 0, 250, 150);
	closeRect = isPad?CGRectMake(1024-250, 0, 600, 350):CGRectMake(_w-100, 0, 250, 150); // default
	
	if (self = [self initWithFrame:closeRect]) {
		
		UIImageView *mark = [UIImageView imageViewWithName:@"kitchen_mark~ipad.png" frame:isPad?CGRectMake(0, 0, 250, 250):CGRectMake(0, 0, 100, 100)];
		
		UIImageView *maschineBG = [UIImageView imageViewWithName:@"small_appliances_BG.jpg" frame:isPad?CGRectMake(250, 0, 350, 350):CGRectMake(100, 0, 150, 150)];
		
		// width:150
		CGFloat markLength = isPad?250:100;
		CGFloat frameWidth = isPad?350:150;
		width = isPad?150:60;
		margin = (frameWidth-2*width)/3;
		

		ofen =  [UIImageView imageViewWithName:@"kitchen_machine_small_ofen.png" frame:CGRectMake(markLength+margin, margin, width, width)];
		ofen.userInteractionEnabled = YES;
		[ofen addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
		
		pot = [UIImageView imageViewWithName:@"kitchen_machine_small_pot.png" frame:CGRectMake(markLength+margin, width+2*margin, width, width)];
		pot.userInteractionEnabled = YES;
		[pot addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
		pan = [UIImageView imageViewWithName:@"kitchen_machine_small_pane.png" frame:CGRectMake(markLength+width+2*margin, margin, width, width)];
		pan.userInteractionEnabled = YES;
		[pan addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
		microwelle = [UIImageView imageViewWithName:@"kitchen_machine_small_microwelle.png" frame:CGRectMake(markLength+width+2*margin, width+2*margin, width, width)];
		microwelle.userInteractionEnabled = YES;
		[microwelle addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];

		maschines = [NSArray arrayWithObjects:ofen,pan,pot,microwelle, nil];
		
		[self addSubview:mark];
		[self addSubview:maschineBG];
		
		[self addSubview:ofen];
		[self addSubview:pan];
		[self addSubview:pot];
		[self addSubview:microwelle];

		[self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)]];
		UISwipeGestureRecognizer *swipe3 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
		swipe3.direction = UISwipeGestureRecognizerDirectionLeft ;
		UISwipeGestureRecognizer *swipe4 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
		swipe4.direction = UISwipeGestureRecognizerDirectionRight ;
		[self addGestureRecognizer:swipe3];
		[self addGestureRecognizer:swipe4];

	}
	
	return self;
}

#pragma mark - SpriteDelegate
- (void)spriteDidClicked:(Sprite *)sprite{
	L();

	vc.selectedMaschineType = [(Maschine*)sprite type];
	[vc toMaschineWorkingView];
}

#pragma mark - IBAction
- (IBAction)handleTap:(UITapGestureRecognizer*)gesture{
	L();
	
	UIView *v = [gesture view];
	if (v == ofen) {
		vc.selectedMaschineType = MaschineOfen;
		[vc toMaschineWorkingView];
	}
	else if (v == pot) {
		vc.selectedMaschineType = MaschinePot;
		[vc toMaschineWorkingView];
	}
	else if (v == pan) {
		vc.selectedMaschineType = MaschinePan;
		[vc toMaschineWorkingView];
	}

	else if (v == microwelle) {
		vc.selectedMaschineType = MaschineMicrowelle;
		[vc toMaschineWorkingView];
	}

    if (!isOpen) { // open
        //向左移

		[self open];
    }
    else{ // close

		[self close];
    }

}

- (void)handleSwipe:(UISwipeGestureRecognizer*)gesture{
	L();
	if (gesture.direction == UISwipeGestureRecognizerDirectionLeft && !isOpen) { //打开
		[self open];
	}
	else if(gesture.direction == UISwipeGestureRecognizerDirectionRight && isOpen){ //close
		[self close];
	}
}
#pragma mark -
- (void)open{
	[UIView animateWithDuration:0.5 animations:^{
		self.frame = openRect;
	}];
	
	isOpen = YES;
}
- (void)close{
	[UIView animateWithDuration:0.5 animations:^{
		self.frame = closeRect;
	}];

	isOpen = NO;
}

// Get MaschineType from point
- (MaschineType)maschineTypeWithPoint:(CGPoint)point foodCategory:(FoodCategory)foodCategory{
	

	
	for (UIView *v in maschines) {
		if (CGRectContainsPoint(v.frame, point)) {
			if (v == ofen && [Maschine isMaschine:MaschineOfen workableWithFoodCategory:foodCategory]) {
				return MaschineOfen;
			}
			if (v == pan && [Maschine isMaschine:MaschinePan workableWithFoodCategory:foodCategory]) {
				return MaschinePan;
			}
			if (v == pot && [Maschine isMaschine:MaschinePot workableWithFoodCategory:foodCategory]) {
				return MaschinePot;
			}
			if (v == microwelle && [Maschine isMaschine:MaschineMicrowelle workableWithFoodCategory:foodCategory]) {
				return MaschineMicrowelle;
			}
		}
	}
	
	
	
	return MaschineNone;
}

- (void)setFoodWorkable:(FoodCategory)foodCategory{
	float value = 0.6;
	if (![Maschine isMaschine:MaschineOfen workableWithFoodCategory:foodCategory]) {
		ofen.alpha = value;
	}
	if (![Maschine isMaschine:MaschinePan workableWithFoodCategory:foodCategory]) {
		pan.alpha = value;
	}
	if (![Maschine isMaschine:MaschinePot workableWithFoodCategory:foodCategory]) {
		pot.alpha = value;
	}
	if (![Maschine isMaschine:MaschineMicrowelle workableWithFoodCategory:foodCategory]) {
		microwelle.alpha = value;
	}
}

- (void)reset{
	ofen.alpha = 1.0;
	pan.alpha = 1.0;
	pot.alpha = 1.0;
	microwelle.alpha = 1.0;
}
@end
