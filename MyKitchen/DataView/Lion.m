//
//  Lion.m
//  TinyKitchen
//
//  Created by XC on 7/31/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Lion.h"

@implementation Lion

- (void)load{

	
	durationOfEating = 2.53;

	eatingPosition = isPad?CGRectMake(300, 250, 450, 450):CGRectMake((_w-200)/2, 110, 200, 200);//160
    mouthPosition = isPad?CGRectMake(155, 230, 40, 40):CGRectMake(67, 105, 20, 20);
	eyesPoint = isPad?CGPointMake(166, 130):CGPointMake(74, 57);
	figureIndex = FigureLion;
	self.frame = eatingPosition;	
	[super load];

	
	head = [[Head alloc]initWithFrame:self.bounds];
	head.duration = 0.8;
	head.animationDistance = isPad?8:4;
	head.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"Animation_lion_head.png"];
	
	body = [[AnimationPart alloc]initWithFrame:self.bounds];
	body.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"Animation_lion_body.png"];
	
	
	tail = [UIImageView imageViewWithName:@"Animation_lion_body_tail.png" frame:self.bounds];
	tail.animationImages = [NSArray arrayWithObjects:[UIImage imageWithContentsOfFileUniversal:@"Animation_lion_body_tail.png"], 
							[UIImage imageWithContentsOfFileUniversal:@"Animation_lion_tail2.png"],
							[UIImage imageWithContentsOfFileUniversal:@"Animation_lion_tail3.png"],
							[UIImage imageWithContentsOfFileUniversal:@"Animation_lion_tail4.png"],nil];
	tail.animationDuration = 1;
	tail.autoresizingMask = kAutoResize;
	tail.animationRepeatCount = 2;

	glasses = [[AnimationPart alloc]initWithFrame:self.bounds];
	glasses.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"Animation_lion_glasses.png"];
	glasses.animationDistance = isPad?5:2.5;
	
	eyes = [[Eyes alloc]initWithFrame:self.bounds];
	eyes.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"Animation_lion_eyeballs.png"];
	eyes.eyeballImg = [UIImage imageWithContentsOfFileUniversal:@"Animation_lion_pupils.png"];
	eyes.animationDistance = isPad?5:2.5;

	
	mouth = [[Mouth alloc]initWithFrame:self.bounds];
	mouth.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"Animation_lion_mouth0.png"];
	mouth.duration = durationOfEating;
	mouth.sadParts = [NSArray arrayWithObject:@"Animation_lion_mouth_notGood.png"];
	mouth.happyParts = [NSArray arrayWithObject:@"Animation_lion_mouth_good.png"];
	mouth.yummyParts = [NSArray arrayWithObject:@"Animation_lion_mouth_yummy.png"];
	mouth.openImg = [UIImage imageWithContentsOfFileUniversal:@"Animation_lion_mouth_open.png"];
	mouth.eatingParts = [NSArray arrayWithObjects:@"Animation_lion_mouth_eating1.png",@"Animation_lion_mouth_eating2.png", nil];

	
	
	leftBrow= [[AnimationPart alloc]initWithFrame:self.bounds];
	leftBrow.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"Animation_lion_brow_left.png"];
	leftBrow.animationDistance = isPad?3:1.5;
	
	
	rightBrow = [[AnimationPart alloc]initWithFrame:self.bounds];
	rightBrow.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"Animation_lion_brow_right.png"];
	rightBrow.animationDistance = isPad?3:1.5;
	
	[self addSubview:body];
	[self addSubview:head];

	
	animationParts = [NSArray arrayWithObjects:head,mouth,leftBrow,rightBrow, eyes,nil];
	
	
	[self addSubview:tail];
	[head addSubview:mouth];
	[head addSubview:leftBrow];
	[head addSubview:rightBrow];
	[head addSubview:eyes];
	[head addSubview:glasses];

//	[self addSubview:mouthPositionV];

	/*	
	 FigureSoundNormal,
	 FigureSoundGood,
	 FigureSoundBad,
	 FigureSoundYummy,
	 FigureSoundEating
	 
	*/
	
	
	NSArray *audioNames = [NSArray arrayWithObjects:@"lion_good.mp3",@"lion_good.mp3",@"Lion_notGood_HMMM ANGRY.mp3",@"lion_yummy.mp3",@"lion_eating.mp3", nil];
	//		
	for(int i=0;i<[audioNames count];i++){
		SystemSoundID soundid = 0;
		AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:[audioNames objectAtIndex:i]], &soundid);
		audioIDs[i] = soundid;
	}

}


- (FoodTasteType)willEatFood:(Food*)food{
	
	/*

	 不爱吃： 蔬菜，水果
	 爱吃： 肉，冰激凌

	 */
	
	int category = food.category;
		
//	if (food.category == FoodPizza && state == FoodRaw) {
//		return FoodTasteWillNotEat;
//	}
	if(food.category == FoodVegetable ||category == FoodFruit){
		return FoodTasteNotGood;
	}
	else if(category == FoodMeat ||category == FoodIce){ // 超爱sushi
		return FoodTasteYummy;
	}
	else { //剩下随机
		return arc4random()%3+1;
	}
}

- (void)runBack{
	
	[super runBack];
	[glasses runBack];
	
}

- (void)runHappy{
	[super runHappy];
	
}

- (void)runSad{
	[super runSad];

}
- (void)runYummy{
	[super runYummy];
	[glasses runUpBack];
	[tail startAnimating];
}

- (void)playUp{
	[super playUp];
	[glasses runUp];
	
}

- (void)playRight{
	[super playRight];
	[glasses runRight];
}

- (void)playDown{
      [super playDown];
    [glasses runDown];
}

- (void)playLeft{
    [super playLeft];
    [glasses runLeft];
}

- (void)playUpBack{
	[super playUpBack];
	[glasses runUpBack];
}
- (void)playDownBack{
	[super playDownBack];
	[glasses runDownBack];
}
- (void)playLeftBack{
	[super playLeftBack];
	[glasses runLeftBack];

}
- (void)playRightBack{
	[super playRightBack];
	[glasses runRightBack];
}

#pragma mark -
- (void)toEatStatus{


	[super toEatStatus];
	glasses.initialFrame = CGRectMake(0, 0, initialFrame.size.width, initialFrame.size.height);
}


@end
