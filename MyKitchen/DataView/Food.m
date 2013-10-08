//
//  Food.m
//  TinyKitchen
//
//  Created by XC on 7/31/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Food.h"
#import "Maschine.h"
#import "Ofen.h"

@implementation Food

@synthesize category,defaultImageName, state ;

//	FoodPizza,
//    FoodMeat,
//    FoodVegetable,
//    FoodSushi,
//    FoodFast,
//    FoodFruit,
//    FoodStarch,
//    FoodIce,
//	FoodOutdoor
 NSString* categoryNames[9] = {
@"Pizza",@"Meat",@"Vegetable",@"Sushi",@"Fast",@"Fruit",@"Starch",@"Ice",@"Outdoor"
};

- (void)setState:(FoodState)_state{
	state = _state;
}

#pragma mark -

- (void)load{
	[super load];

	state = FoodRaw;
	
	
	baseV = [[UIImageView alloc]initWithFrame:self.bounds];
	baseV.image = defaultImg;
	baseV.autoresizingMask = kAutoResize;

	
	fertigV = [[UIImageView alloc]initWithFrame:self.bounds];
	fertigV.autoresizingMask = kAutoResize;
	
	fertigImg = defaultImg;
	
	steam = [[Steam alloc]initWithFrame:self.bounds];
	
	
	[self addSubview:baseV];

	[self addSubview:fertigV];
	[self addSubview:steam];
	
	self.clipsToBounds = NO;
//	self.backgroundColor = [UIColor redColor];
	
//	NSLog(@"name:%@,defaultimgSize:%@,food.frame:%@",defaultImageName,NSStringFromCGSize(defaultImg.size), self);
}


//正常的food init, 因为不知道图片的大小，所以得先生成图片，再根据图片的size来initFrame，调用load
//
- (id) initWithName:(NSString*)imgName{
    foodName = [[imgName componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"_."]]objectAtIndex:0];
    defaultImageName = imgName;

	defaultImg = [UIImage imageWithContentsOfFileUniversal:imgName];
//    NSString *ofenName = [NSString stringWithFormat:@"%@_ofen2.png",foodName];

    CGSize size = defaultImg.size;
	

	// if ipad: 150, ipad retina: 150, iphone: 300
	/*
	 
	 iphone 上
	 
	 */
    return [self initWithFrame:isPad?CGRectMake(0, 0, size.width, size.height):CGRectMake(0,0, size.width/2, size.height/2)];
}

// outdoorVC 的food的init

- (id)initWithName:(NSString *)imgName frame:(CGRect)frame{

	self = [self initWithName:imgName];
	self.frame = frame;
	self.initialFrame = frame;
	self.category = FoodOutdoor;
	
    return self;
}

- (id)copyWithZone:(NSZone *)zone{

//	Food* clone =[[[self class] allocWithZone:zone] init]; // view的frame都是0
	Food *clone = [[Food alloc]initWithName:self.defaultImageName frame:self.frame];
	clone.category = self.category;
	return clone;
}


- (NSString*)categoryName{
//	FoodPizza,
//    FoodMeat,
//    FoodVegetable,
//    FoodSushi,
//    FoodFast,
//    FoodFruit,
//    FoodStarch,
//    FoodIce,
//	FoodOutdoor
	
	return categoryNames[category];

}
#pragma mark -

- (void)startWorkWithMaschineType:(MaschineType)maschineType{
   
	//在机器里冒烟
	
	if (maschineType == MaschineOfen) { 

//		NSLog(@"food.state:%d",state);
		// 不重复
		if (state == FoodOfen) {
			return;
		}
//		NSLog(@"begin work ofen");
        NSString *ofen1 = [NSString stringWithFormat:@"%@_ofen1.png",foodName];
	
		
		UIImage *ofenImg1 = [UIImage imageWithContentsOfFileUniversal:ofen1];

        NSString *ofen2 = [NSString stringWithFormat:@"%@_ofen2.png",foodName];
		UIImage *ofenImg2 = [UIImage imageWithContentsOfFileUniversal:ofen2];
		NSLog(@"ofen1:%@;ofen2:%@,img1:%@,img2:%@",ofen1,ofen2,ofenImg1,ofenImg2);
		fertigV.image = ofenImg1;
		fertigV.alpha = 0;

		[self bringSubviewToFront:fertigV];
		
        [UIView animateWithDuration:kMaschineDuration/2 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{

            fertigV.alpha = 1;
        } completion:^(BOOL finished) {
			if (stopFlag) {
				return;
			}
			baseV.image = ofenImg1;
			fertigV.image = [UIImage imageWithContentsOfFileUniversal:ofen2];
			fertigV.alpha = 0;

			[UIView animateWithDuration:kMaschineDuration/2 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{

                fertigV.alpha = 1;
            } completion:^(BOOL finished) {
				//准备下一次work
				baseV.image = ofenImg2;
			}
             ];
        }];
		
		
		[self startSteaming];
		state = FoodOfen;

		
    }
	else if(maschineType == MaschineMicrowelle){ //
		// 微波炉只是冒烟
		

		[self startSteaming];
		
		state = FoodMicrowelle;
		
	}
	else if(maschineType == MaschinePan){

		if (state == FoodPan) {
			return;
		}
		
		fertigImg = [[ImageManager sharedInstance]imgWithBlend:kCGBlendModeMultiply Souce:fertigImg destinateImg:[UIImage imageNamedUniversal:@"pane_effect9.png"]];

		fertigV.image = fertigImg;
		[self addSubview:fertigV];
		fertigV.alpha = 0;
		
		[UIView animateWithDuration:kMaschineDuration animations:^{
			fertigV.alpha = 1.0;
		} completion:^(BOOL finished) {
			//准备下一次work
			baseV.image = fertigImg;
		}];
		
		[self startSteaming];
		state = FoodPan;
		
		
	}
	else if(maschineType == MaschinePot){
		
		if (state == FoodPot) {
			return;
		}
		
		fertigImg = [[ImageManager sharedInstance]imgWithWhiteEffect:fertigImg];
		
		fertigV.image = fertigImg;
		[self addSubview:fertigV];
		
		fertigV.alpha = 0;
		
		[UIView animateWithDuration:5 animations:^{
			fertigV.alpha = 1.0;
		} completion:^(BOOL finished) {
			//准备下一次work
			baseV.image = fertigImg;

		}];
		
		[self startSteaming];
		state = FoodPot;
		
		//准备下一次work
		NSLog(@"food.state:%d",state);
	}
	else {
		NSAssert1(0, @"food startWork error:%d", maschineType);
	}
}

- (void)stopWorkWithMaschine{
	L();
	// stop steaming
	stopFlag = YES;
	
	[self.layer removeAllAnimations];
	[baseV.layer removeAllAnimations];
	[fertigV.layer removeAllAnimations];
	
	self.transform = CGAffineTransformMakeScale(1.0, 1.0);
	self.alpha = 1.0;
//	NSLog(@"v1.alpha:%f",v1.alpha);
	[steam stop];
}


- (void)startSteaming{

	[steam play];
}

@end
