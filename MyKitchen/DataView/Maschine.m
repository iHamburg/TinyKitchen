//
//  Maschine.m
//  TinyKitchen
//
//  Created by XC on 8/1/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Maschine.h"

@implementation Maschine

@synthesize food,type;

-(void)load{
	[super load];
	
	baseV = [[UIImageView alloc] initWithFrame:self.bounds];
	baseV.autoresizingMask = kAutoResize;
	
	contentV = [[UIImageView alloc]initWithFrame:CGRectZero];
	
	workingV = [[UIImageView alloc]initWithFrame:self.bounds];
	workingV.autoresizingMask = kAutoResize;
	
	
	[self addSubview:baseV];
	[self addSubview:contentV];
	
}

//
//- (void)willMoveToSuperview:(UIView *)newSuperview{
//
//	// 当Maschine被放到WorkingView上的时候，会自动把baseV设成nil
//    if (newSuperview.tag == kTagMaschineWorkingView) {  // working
//        
//		self.frame = newSuperview.bounds;
//		onWorkingView = YES;
//    }
//	else {  // choose
//
//		onWorkingView = NO;
//	}
//    
//}

#pragma mark -

/*
 ofen: 2张图的切换
 microwelle： 没有处理
 pan: fertigV.img: multiply
 pane: fertigV.img: whiteEffect
 
 */

- (void)play{
    L();
	
	food.transform = CGAffineTransformMakeScale(1.4, 1.4);
	
	float xscale = 1.0/1.4;
	float yscale = 1.0/1.4;

	if (contentV.width<food.frame.size.width) { //contentV:240x150, food:450x140-> 500x200
		xscale = food.bounds.size.width/contentV.width; //2.3
	
	}
	if (contentV.height<food.frame.size.height) {
		yscale = food.bounds.size.height/contentV.height; //0.9
	}

	float scale = fminf(xscale, yscale); //0.9
	
	food.transform = CGAffineTransformMakeScale(1.0/scale, 1.0/scale);

	[food setFrameCenter:CGPointMake(contentV.width/2, contentV.height/2)];
	[food startWorkWithMaschineType:type];
	
	//把food的gesture 都 disable
	[food disableAllGestures];


	contentV.contentMode = UIViewContentModeCenter;
	
    [contentV addSubview:food];

}

// stop in WorkingView
- (void)stopAfterDuration{
		
	// 停止工作声音
	[runningPlayer fadeOut];

}

// stop to kitchen
- (void)stopImmediately{

	
	// 工作view切换回 off

	[workingV stopAnimating];
	[workingV removeFromSuperview];
	
	// 停止工作声音
	[runningPlayer fadeOut];
	
	// food也还原
	[food stopWorkWithMaschine];

}

- (void)runWorkingSound{
	
}


- (float)scaleWithSize:(CGSize)originalSize toSize:(CGSize)destinationSize{
	float scaleX = destinationSize.width/originalSize.width;
	float scaleY = destinationSize.height/originalSize.height;
	
	if (scaleY>scaleX) {
		return scaleX;
	}
	else {
		return scaleY;
		
	}
}

+ (BOOL)isMaschine:(MaschineType)type workableWithFoodCategory:(FoodCategory)foodCategory{
	if (type == MaschineOfen) {
		switch (foodCategory) {
			case FoodMeat:
			case FoodVegetable:
			case FoodOutdoor:
			case FoodPizza:
				return YES;
				break;
				
			default:
				
				break;
		}
	}
	else if(type == MaschinePan){
		switch (foodCategory) {
			case FoodMeat:
			case FoodVegetable:
			case FoodOutdoor:
				return YES;
				break;
				
			default:
				return NO;
				break;
		}
	}
	else if(type == MaschinePot){
		switch (foodCategory) {
			case FoodMeat:
			case FoodVegetable:
			case FoodOutdoor:
			case FoodFruit:
				return YES;
				break;
				
			default:
				return NO;
				break;
		}
	}
	else if(type == MaschineMicrowelle){
		switch (foodCategory) {
			case FoodMeat:
			case FoodVegetable:
			case FoodOutdoor:
			case FoodFast:
				return YES;
				break;
				
			default:
				return NO;
				break;
		}
	}
	
	return NO;
}
@end
