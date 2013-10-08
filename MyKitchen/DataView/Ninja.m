//
//  Ninja.m
//  TinyKitchen
//
//  Created by XC on 7/31/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Ninja.h"

@implementation Ninja


// 350x350
- (void)load{

	eatingPosition = isPad?CGRectMake(280, 250, 450, 450):CGRectMake((_w-200)/2, 110, 200, 200); // big
    mouthPosition = isPad?CGRectMake(205, 210, 40, 40):CGRectMake(90, 95, 20, 20);
	eyesPoint = isPad?CGPointMake(220, 130):CGPointMake(97, 57);

	figureIndex = FigureNinja;
	durationOfEating = 3.0;
	self.frame = eatingPosition;
	[super load];
	

	
	head = [[Head alloc]initWithFrame:self.bounds];
	head.duration = 0.8;
	head.animationDistance = isPad?6:3;
	head.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"Ninja_head.png"];
	
	body = [[AnimationPart alloc]initWithFrame:self.bounds];
	body.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"Ninja_body.png"];
	
	mouth = [[Mouth alloc]initWithFrame:self.bounds];
	mouth.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"Animation_ninjia_default_mouth.png"];
	mouth.sadParts = [NSArray arrayWithObject:@"Animation_ninjia_notGood_mouth.png"];
	mouth.happyParts = [NSArray arrayWithObject:@"Animation_ninjia_good_mouth.png"];
	mouth.yummyParts = [NSArray arrayWithObject:@"Animation_ninjia_yummy_mouth.png"];
	mouth.openImg = [UIImage imageWithContentsOfFileUniversal:@"Animation_ninjia_open_mouth.png"];
	mouth.eatingParts = [NSArray arrayWithObjects:@"Animation_ninjia_mouth_eating1.png",@"Animation_ninjia_mouth_eating2.png", nil];
	mouth.duration = durationOfEating;
	
	eyes = [[Eyes alloc]initWithFrame:self.bounds];
	eyes.eyeballImg = [UIImage imageWithContentsOfFileUniversal:@"Ninja_eyes.png"];
	eyes.animationDistance = isPad?5:2.5;
	
	leftBrow = [[AnimationPart alloc]initWithFrame:self.bounds];
	leftBrow.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"Animation_ninjia_good_brow_left.png"];
	leftBrow.animationDistance = isPad?3:1.5;
	
	rightBrow = [[AnimationPart alloc]initWithFrame:self.bounds];
	rightBrow.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"Animation_ninjia_good_brow_right.png"];
	rightBrow.animationDistance = isPad?3:1.5;
	
	
	[self addSubview:body];
	[self addSubview:head];
	
	animationParts = [NSArray arrayWithObjects:leftBrow,rightBrow,mouth,eyes, nil];
	
	for (AnimationPart *part in animationParts) {
		
		[head addSubview:part];

	}
	
	/*	FigureSoundNormal,
	 FigureSoundGood,
	 FigureSoundBad,
	 FigureSoundYummy,
	 FigureSoundEating*/
	
	//audioIDs是有问题的，不能用
	NSArray *audioNames = [NSArray arrayWithObjects:@"ninja_good.mp3",@"ninja_good.mp3",@"ninja_notGood.mp3",@"ninjia_yummy.mp3",@"ninja_eating.mp3", nil];
	//		
	for(int i=0;i<[audioNames count];i++){
		SystemSoundID soundid = 0;
		AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:[audioNames objectAtIndex:i]], &soundid);
		audioIDs[i] = soundid;
	}

}

- (FoodTasteType)willEatFood:(Food*)food{
	
	/*
	 
	
	 不爱吃 fast, ice
	 爱吃   sushi, asia

	 */
	
	int category = food.category;

	if(food.category == FoodFast || food.category == FoodIce){
		return FoodTasteNotGood;
	}
	else if(category == FoodSushi ||category == FoodVegetable){ // 超爱sushi
		return FoodTasteYummy;
	}
	else { //剩下随机
		return arc4random()%3+1;
	}
}

@end
