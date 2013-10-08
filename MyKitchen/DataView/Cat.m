//
//  Cat.m
//  TinyKitchen
//
//  Created by XC on 7/31/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Cat.h"

@implementation Cat
- (void)load{

	// 先设定self。frame，以免加进来的layer的frame不正常
	
	durationOfEating = 2.2;
//	choosePosition = CGRectMake(370, 240, 300, 300);
	eatingPosition = isPad?CGRectMake(280, 250, 450, 450):CGRectMake((_w-200)/2, 110, 200, 200);//120
	mouthPosition = isPad?CGRectMake(245, 190, 40, 40):CGRectMake(107, 82, 20, 20);
	eyesPoint = isPad?CGPointMake(250, 160):CGPointMake(112, 72);
	figureIndex = FigureCat;
	self.frame = eatingPosition;
	
	[super load];
	
	
	
//	self.image = [UIImage imageWithContentsOfFileUniversal:@"cat_base~ipad.png"];
	
	head = [[Head alloc]initWithFrame:self.bounds];
	head.duration = 0.8;
	head.animationDistance = isPad?8:4;
	head.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"cat_head2.png"];
	
	body = [[AnimationPart alloc]initWithFrame:self.bounds];
	body.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"cat_legs.png"];
	
	bowTie = [UIImageView imageViewWithName:@"cat_bowTie.png" frame:self.bounds];
	bowTie.autoresizingMask = kAutoResize;

	brow = [UIImageView imageViewWithName:@"cat_brow.png" frame:self.bounds];
	brow.autoresizingMask = kAutoResize;
	jaw = [UIImageView imageViewWithName:@"cat_jaw.png" frame:self.bounds];
	jaw.autoresizingMask = kAutoResize;
	nose = [UIImageView imageViewWithName:@"cat_nose.png" frame:self.bounds];
	nose.autoresizingMask = kAutoResize;
	
	eyes = [[Eyes alloc]initWithFrame:self.bounds];
	eyes.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"cat_eyeball.png"];
	eyes.eyeballImg = [UIImage imageWithContentsOfFileUniversal:@"cat_puples.png"];
	eyes.animationDistance = isPad?5:2.5;
	
	//yummy的part要在eyeball之前
//	eyes.yummyParts = [NSArray arrayWithObjects:@"cat_eye_yummy1.png", nil];

	
	mouth = [[Mouth alloc]initWithFrame:self.bounds];
	mouth.defaultImg = [UIImage imageWithContentsOfFileUniversal:@"cat_mouth.png"];
	mouth.duration = durationOfEating;
	mouth.sadParts = [NSArray arrayWithObjects:@"cat_mouth_notGood1.png",nil];
	mouth.happyParts = [NSArray arrayWithObjects:@"cat_mouth_good1.png",nil];
	mouth.yummyParts = [NSArray arrayWithObjects:@"cat_mouth_yummy.png",nil];
	mouth.openImg = [UIImage imageWithContentsOfFileUniversal:@"cat_mouth_open.png"];
	mouth.eatingParts = [NSArray arrayWithObjects:@"cat_eating0.png",@"cat_eating1.png", nil];
	
	[self addSubview:body];
	[self addSubview:head];
	
	[head addSubview:bowTie];
	[head addSubview:brow];
	[head addSubview:jaw];
	[head addSubview:nose];
	
	[self addSubview:eyes];
	
	animationParts = [NSArray arrayWithObjects:mouth,eyes, nil];
	
	for (AnimationPart *part in animationParts) {

		[head addSubview:part];

	}
	
//	[self addSubview:mouthPositionV];
	

	
	/*	FigureSoundNormal,
	 FigureSoundGood,
	 FigureSoundBad,
	 FigureSoundYummy,
	 FigureSoundEating*/
	
	//audioIDs是有问题的，不能用
	NSArray *audioNames = [NSArray arrayWithObjects:@"cat_meows3.mp3",@"cat_good.mp3",@"cat_notGood.mp3",@"cat_yummy.mp3",@"Cat_eating.mp3", nil];
//		
		for(int i=0;i<[audioNames count];i++){
			SystemSoundID soundid = 0;
			AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:[audioNames objectAtIndex:i]], &soundid);
			audioIDs[i] = soundid;
		}
	

	//	NSLog(@"delegate:%@, durationOfEating:%f",delegate,durationOfEating);

}

- (FoodTasteType)willEatFood:(Food*)food{

	int category = food.category;
//	int state = food.state;
//	
//	if (food.category == FoodPizza && state == FoodRaw) { // 不吃生pizza
//		return FoodTasteWillNotEat;
//	}
	if(food.category == FoodMeat) { //不爱吃生肉和蔬菜
		return FoodTasteNotGood;
	}
	else if(food.category == FoodVegetable){
		return FoodTasteNotGood;
	}
	else if(category == FoodIce || category == FoodStarch || category == FoodFruit){//爱吃冰激凌，蛋糕，水果
		return FoodTasteGood;
	}
	else if(category == FoodSushi || category == FoodOutdoor){ // 超爱sushi
		return FoodTasteYummy;
	}
	else { //剩下随级
		return arc4random()%3+1;
	}
}

- (void)runEat{
	[super runEat];
	
	jaw.hidden = YES;
}

- (void)playAfterEat{
	[super playAfterEat];
	jaw.hidden = NO;
}
@end
