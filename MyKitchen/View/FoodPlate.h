//
//  FoodPlate.h
//  TinyKitchen
//
//  Created by XC on 7/31/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
#import "Foodfloor.h"



@interface FoodPlate : UIView{
	Sprite *lock;
	UIView *container;
}

@property (nonatomic, unsafe_unretained) ControlView *controlView;
@property (nonatomic, assign) FoodCategory foodCategory;
@property (nonatomic, unsafe_unretained) Foodfloor *foodfloor;

- (void)setup;

//- (void)removeIAPFeature;
@end
