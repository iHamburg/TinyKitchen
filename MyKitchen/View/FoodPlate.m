//
//  FoodPlate.m
//  TinyKitchen
//
//  Created by XC on 7/31/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "FoodPlate.h"

@implementation FoodPlate

@synthesize foodCategory,controlView;
@synthesize foodfloor;

- (void)setFoodCategory:(FoodCategory)_foodCategory{
    foodCategory = _foodCategory;
    [self setup];
}


- (id)initWithFrame:(CGRect)frame{
//	L();
	if (self = [super initWithFrame:frame]) {
		
		if (isPad) {
			container = [[UIView alloc]initWithFrame:self.bounds];
		}
		else if(isPhone5){
			container = [[UIView alloc]initWithFrame:CGRectMake(44, 0, 480, frame.size.height)];
		}
		else{
			container = [[UIView alloc]initWithFrame:self.bounds];
		}

	    [self addSubview:container];


	
	}
	
	return self;
}


- (void)setup{
    
    //prodefined: foodcategory
    float scale = isPad?1.0:0.42;   
	float xscale = isPad?1.0:0.47;
//    [self removeAllSubviews];
    NSArray *foods = [[FoodManager sharedInstance]foodsWithCategory:foodCategory];
	
    if (foodCategory == FoodPizza) {
   
        [[foods objectAtIndex:0] setOrigin:CGPointMake(20*xscale, 60*scale)];
        [[foods objectAtIndex:1] setOrigin:CGPointMake(250*xscale, 60*scale)]; 
        [[foods objectAtIndex:2] setOrigin:CGPointMake(420*xscale, 60*scale)];
        [[foods objectAtIndex:3] setOrigin:CGPointMake(620*xscale, 60*scale)]; 
        [[foods objectAtIndex:4] setOrigin:CGPointMake(815*xscale, 60*scale)];
       
    }
    else if(foodCategory == FoodMeat){

		[[foods objectAtIndex:0] setOrigin:CGPointMake(190*xscale, 60*scale)];
        [[foods objectAtIndex:3] setOrigin:CGPointMake(540*xscale, 60*scale)]; 
        [[foods objectAtIndex:2] setOrigin:CGPointMake(830*xscale, 60*scale)];
        [[foods objectAtIndex:1] setOrigin:CGPointMake(50*xscale, 130*scale)]; 
        [[foods objectAtIndex:4] setOrigin:CGPointMake(380*xscale, 130*scale)];
        [[foods objectAtIndex:5] setOrigin:CGPointMake(670*xscale, 130*scale)];
	}
    else if(foodCategory == FoodVegetable){
        
        [[foods objectAtIndex:0] setOrigin:CGPointMake(10*xscale, 30*scale)];
        [[foods objectAtIndex:1] setOrigin:CGPointMake(160*xscale, 60*scale)]; 
        [[foods objectAtIndex:2] setOrigin:CGPointMake(340*xscale, 60*scale)];
        [[foods objectAtIndex:3] setOrigin:CGPointMake(540*xscale, 60*scale)]; 
        [[foods objectAtIndex:4] setOrigin:CGPointMake(660*xscale, 60*scale)];
        [[foods objectAtIndex:5] setOrigin:CGPointMake(840*xscale, 40*scale)];
    }   
    else if(foodCategory == FoodSushi){
        
        [[foods objectAtIndex:0] setOrigin:CGPointMake(121*xscale, 23*scale)];
        [[foods objectAtIndex:1] setOrigin:CGPointMake(121*xscale, 125*scale)]; 
        [[foods objectAtIndex:2] setOrigin:CGPointMake(314*xscale, 23*scale)];
        [[foods objectAtIndex:3] setOrigin:CGPointMake(314*xscale, 125*scale)]; 
        [[foods objectAtIndex:4] setOrigin:CGPointMake(491*xscale, 23*scale)];
        [[foods objectAtIndex:5] setOrigin:CGPointMake(491*xscale, 120*scale)];
        [[foods objectAtIndex:6] setOrigin:CGPointMake(691*xscale, 23*scale)];
        [[foods objectAtIndex:7] setOrigin:CGPointMake(720*xscale, 135*scale)];
    }

    
    else if(foodCategory == FoodFast){
        
        [[foods objectAtIndex:0] setOrigin:CGPointMake(97*xscale, 30*scale)];
        [[foods objectAtIndex:1] setOrigin:CGPointMake(174*xscale, 120*scale)]; 
        [[foods objectAtIndex:2] setOrigin:CGPointMake(333*xscale, 30*scale)];
        [[foods objectAtIndex:3] setOrigin:CGPointMake(439*xscale, 120*scale)]; 
        [[foods objectAtIndex:4] setOrigin:CGPointMake(595*xscale, 30*scale)];
        [[foods objectAtIndex:5] setOrigin:CGPointMake(740*xscale, 105*scale)];
    }
    
    else if(foodCategory == FoodFruit){
        
        [[foods objectAtIndex:0] setOrigin:CGPointMake(130*xscale, 20*scale)];
        [[foods objectAtIndex:1] setOrigin:CGPointMake(85*xscale, 115*scale)]; 
        [[foods objectAtIndex:2] setOrigin:CGPointMake(320*xscale, 20*scale)];
        [[foods objectAtIndex:3] setOrigin:CGPointMake(282*xscale, 125*scale)]; 
        [[foods objectAtIndex:4] setOrigin:CGPointMake(450*xscale, 20*scale)];
        [[foods objectAtIndex:5] setOrigin:CGPointMake(463*xscale, 115*scale)];
        [[foods objectAtIndex:6] setOrigin:CGPointMake(645*xscale, 20*scale)];
        [[foods objectAtIndex:7] setOrigin:CGPointMake(653*xscale, 105*scale)];
        [[foods objectAtIndex:8] setOrigin:CGPointMake(796*xscale, 20*scale)];
        [[foods objectAtIndex:9] setOrigin:CGPointMake(825*xscale, 120*scale)];
    }

    else if(foodCategory == FoodStarch){
        
        [[foods objectAtIndex:0] setOrigin:CGPointMake(166*xscale, 30*scale)];
        [[foods objectAtIndex:1] setOrigin:CGPointMake(160*xscale, 145*scale)]; 
        [[foods objectAtIndex:2] setOrigin:CGPointMake(354*xscale, 25*scale)];
        [[foods objectAtIndex:3] setOrigin:CGPointMake(337*xscale, 142*scale)]; 
        [[foods objectAtIndex:4] setOrigin:CGPointMake(551*xscale, 30*scale)];
        [[foods objectAtIndex:5] setOrigin:CGPointMake(551*xscale, 145*scale)];
        [[foods objectAtIndex:6] setOrigin:CGPointMake(778*xscale, 30*scale)];
        [[foods objectAtIndex:7] setOrigin:CGPointMake(778*xscale, 145*scale)];
    }
    
    else if(foodCategory == FoodIce){
        
        [[foods objectAtIndex:0] setOrigin:CGPointMake(73*xscale, 97*scale)];
        [[foods objectAtIndex:1] setOrigin:CGPointMake(252*xscale, 38*scale)]; 
        [[foods objectAtIndex:2] setOrigin:CGPointMake(428*xscale, 38*scale)];
        [[foods objectAtIndex:3] setOrigin:CGPointMake(600*xscale, 40*scale)]; 
        [[foods objectAtIndex:4] setOrigin:CGPointMake(728*xscale, 40*scale)];
        [[foods objectAtIndex:5] setOrigin:CGPointMake(887*xscale, 30*scale)];
    }
	
	for (Food *food in foods) {
		[controlView addGestureRecognizersToPiece:food];
		[self addSubview:food];
//		[container addSubview:food];
	}
    
//	NSLog(@"ispaid:%d,isiapfull:%d",isPaid(),isIAPFullVersion);
	
//	if (isPaid() || isIAPFullVersion || foodCategory == FoodPizza || foodCategory == FoodMeat) { // open
//		for (Food *food in foods) {
//			[controlView addGestureRecognizersToPiece:food];
////			[self addSubview:food];
//			[container addSubview:food];
//		}
//
//	}
//	else {
//		// add lock
//		
//		lock = [Sprite spriteWithName:@"lock _iap.png" frame:CGRectMake(0, 0, isPad?128:64, isPad?128:64)];
//		lock.delegate = foodfloor;
//		[lock setFrameCenter:self.center];
//		
//		for (Food *food in foods) {
//			food.alpha = 0.5;
//			[self addSubview:food];
//		}
//		
//		[self addSubview:lock];
//	}

}

//- (void)removeIAPFeature{
//	L();
////	NSLog(@"food:%d remove iap feature",foodCategory);
//	[lock removeFromSuperview];
//
//
//	NSArray *foods = [[FoodManager sharedInstance]foodsWithCategory:foodCategory];
//
//	if (foodCategory == FoodPizza || foodCategory == FoodMeat) {
//		return;
//	}
//	
//	for (Food *food in foods) {
//		food.alpha = 1.0;
//		[controlView addGestureRecognizersToPiece:food];
//
//		
//	}
//
//}

@end
