//
//  Pinguin.m
//  TinyKitchen
//
//  Created by XC on 7/31/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Pinguin.h"

@implementation Pinguin

- (void)load{
	
	durationOfEating = 2.2;
    eatingPosition = isPad?CGRectMake(280, 230, 450, 450):CGRectMake((_w-200)/2, 90, 200, 200);//140
    mouthPosition = isPad?CGRectMake(205, 260, 40, 40):CGRectMake(84, 114, 20, 16);
	eyesPoint = isPad?CGPointMake(215, 210):CGPointMake(95, 95);
	
	figureIndex = FigurePinguin;
	self.frame = eatingPosition;

	[super load];
	
	defaultImg = [UIImage imageWithContentsOfFileUniversal:@"pinguin_base.png"];
	self.image = defaultImg;
	
	base2Img = [UIImage imageWithContentsOfFileUniversal:@"pinguin_base_animation2.png"];
	self.animationImages = [NSArray arrayWithObjects:defaultImg,base2Img,defaultImg, nil];
	self.animationRepeatCount = 2;
	self.animationDuration = 1;
	
	
	mouth = [[Mouth alloc]initWithFrame:self.bounds];
	mouth.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"pinguin_mouth.png"];
	mouth.sadParts = [NSArray arrayWithObjects:@"pinguin_notGood_mouth1.png",@"pinguin_notGood_mouth2.png",nil];
	mouth.happyParts = [NSArray arrayWithObject:@"pinguin_mouth.png"];
	mouth.yummyParts = [NSArray arrayWithObject:@"pinguin_yummy_mouth.png"];
	mouth.openImg = [UIImage imageWithContentsOfFileUniversal:@"pinguin_mouth_open.png"];
	mouth.eatingParts = [NSArray arrayWithObjects:@"pinguin_mouth_eating1.png",@"pinguin_mouth_eating2.png", nil];
	mouth.duration = durationOfEating;
	
	
	leftBrow = [[AnimationPart alloc]initWithFrame:self.bounds];
	leftBrow.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"pinguin_left_brow.png"];
	leftBrow.animationDistance = isPad?3:1.5;

	rightBrow = [[AnimationPart alloc]initWithFrame:self.bounds];
	rightBrow.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"pinguin_right_brow.png"];
	rightBrow.animationDistance = isPad?3:1.5;
	
	eyes = [[Eyes alloc]initWithFrame:self.bounds];
	eyes.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"Pinguin_eyeball.png"];
	eyes.eyeballImg = [UIImage imageWithContentsOfFileUniversal:@"Pinguin_puples.png"];
	eyes.animationDistance = isPad?3:1.5;
	
	animationParts = [NSArray arrayWithObjects:leftBrow,rightBrow,mouth, eyes, nil];
	
	for (AnimationPart *part in animationParts) {

		[self addSubview:part];

	}

	/*	FigureSoundNormal,
	 FigureSoundGood,
	 FigureSoundBad,
	 FigureSoundYummy,
	 FigureSoundEating*/
	
	//audioIDs是有问题的，不能用
	NSArray *audioNames = [NSArray arrayWithObjects:@"penguin_good.mp3",@"penguin_good.mp3",@"Penguin_notGood_eww.mp3",@"penguin_yummy.mp3",@"penguin_eating.mp3", nil];
	//		
	for(int i=0;i<[audioNames count];i++){
		SystemSoundID soundid = 0;
		AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:[audioNames objectAtIndex:i]], &soundid);
		audioIDs[i] = soundid;
	}
	
	
//	durationOfEating = 3.0;
	
//	[self addSubview:mouthPositionV];
	
}

- (FoodTasteType)willEatFood:(Food*)food{
	
	/*
	 
	 
	 不爱吃 冰激凌，asia
	 爱吃   蔬菜，水果
	 
	*/
	
	int category = food.category;
	
	if(food.category == FoodIce ){
		return FoodTasteNotGood;
	}
	else if(category == FoodVegetable ||category == FoodFruit){ // 超爱sushi
		return FoodTasteYummy;
	}
	else { //剩下随机
		return arc4random()%3+1;
	}
	

}



- (void)playUp{
	[super playUp];

	if (self.frame.origin.y - initialFrame.origin.y < -2*animationDistance) { // if y <-2 distance, 就不往上了
		return;
	}
	[UIView animateWithDuration:moveDuration/2 animations:^{
		[self moveOrigin:CGPointMake(0, -animationDistance)];
	} ];
	
}
- (void)playDown{

	[super playDown];
	if (self.frame.origin.y - initialFrame.origin.y > 2*animationDistance) { 
		return;
	}
	[UIView animateWithDuration:moveDuration/2 animations:^{
		[self moveOrigin:CGPointMake(0, animationDistance)];
	} ];
	
}
- (void)playLeft{

	[super playLeft];
	
	if (self.frame.origin.x - initialFrame.origin.x < -2*animationDistance) { 
		return;
	}
	
	[UIView animateWithDuration:moveDuration/2 animations:^{
		[self moveOrigin:CGPointMake(-animationDistance, 0)];
	} ];

}
- (void)playRight{
	[super playRight];
	
	if (self.frame.origin.x - initialFrame.origin.x > 2*animationDistance) { 
		return;
	}
	[UIView animateWithDuration:moveDuration/2 animations:^{
		[self moveOrigin:CGPointMake(animationDistance, 0)];
	} ];
}

- (void)playLeftUp{
	[head runLeftUp];
	[eyes runLeftUp];
}
- (void)playLeftDown{
	[head runLeftDown];
	[eyes runLeftDown];
}
- (void)playRightUp{
	[head runRightUp];
	[eyes runRightUp];
}
- (void)playRightDown{
	[head runRightDown];
	[eyes runRightDown];
}

@end



