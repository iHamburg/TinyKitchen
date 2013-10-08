//
//  Foodfloor.m
//  TinyKitchen
//
//  Created by  on 30.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Foodfloor.h"
#import "FoodPlate.h"

@implementation Foodfloor

@synthesize vc,foodCategory,controlView,openRect,closeRect,isOpen;


#pragma mar -
- (id)initWithVC:(KitchenViewController*)_vc{
	vc = _vc;
	
	openRect = CGRectMake(0, _h - kHFoodfloor, _w, kHFoodfloor);
	closeRect = isPad?CGRectMake(0, 748, 1024, kHFoodfloor):CGRectMake(0, 305, _w, kHFoodfloor);
	
	isOpen = NO;
	pageIndex = 0;
	numberOfPages = 8;
	
	if (self = [super initWithFrame:closeRect]) {
		[self setBGView:@"Board.jpg"];
		
		plates = [NSMutableArray array];
		
		controlView = [[ControlView alloc]initWithFrame:self.bounds];
		
		// max plate number: 9
		preLoadedPlateNumber = 8;
        scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
		scrollView.pagingEnabled = YES;
		
		for (int i = 0 ; i<preLoadedPlateNumber; i++) {
			// floor 要先于category定义
			FoodPlate *plate = [[FoodPlate alloc]initWithFrame:self.bounds];
			plate.foodfloor = self; // delegate要在setup之前赋值
			plate.controlView = vc.controlView;
			plate.foodCategory = i;
			[plate setOrigin:CGPointMake(i*self.width, 0)];
			
			[plates addObject:plate];
			[scrollView addSubview:plate];
		}
		scrollView.contentSize = CGSizeMake(preLoadedPlateNumber* self.width, 0);
       
		// scroll can't be scrolled, so that food on plate can be panned
		scrollView.scrollEnabled = NO;
		
		[self addSubview:scrollView];

	

	}
	return self;
}


- (void)open{
	self.frame = openRect;
	isOpen = YES;
}
- (void)close{

	self.frame = closeRect;
	isOpen = NO;
}


- (void)goNext{
//	L();
	if (pageIndex<numberOfPages-1) {
		pageIndex++;
		[self goPage:pageIndex];
	}

}
- (void)goPrevious{
//	L();
	if (pageIndex>0) {
		pageIndex--;
		[self goPage:pageIndex];
	}
}

- (void)goPage:(int)page{
	[scrollView setContentOffset:CGPointMake(page*self.width, 0) animated:YES];
}

- (void)goRandom{
	pageIndex = arc4random()%8;
	[self goPage:pageIndex];
}

@end
