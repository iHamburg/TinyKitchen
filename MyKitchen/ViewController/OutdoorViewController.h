//
//  OutdoorViewController.h
//  MyKitchen
//
//  Created by  on 25.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KitchenViewController.h"
#import "ControlView.h"
#import "Controller.h"
#import "Food.h"
#import "Fish.h"
#import "Cloud.h"
#import "Butterfly.h"

@interface OutdoorViewController : UIViewController<SpriteDelegate, ControlViewDelegate>{
    
	UIView *container;
    ControlView *controlView;
    Sprite *basket, *grass, *tree, *seeMaske, *arrow;
    Butterfly *butterfly;
    Cloud *cloud;
	
    
	Fish *fish;
    Food *radish, *aubergine, *carrot, *tomato;
    NSArray *mushrooms;
    NSArray *apples;
    Food *selectedFood; //清nil：放手了就清
	
    CGRect oldRect;
    
	NSString* number;
	
	BOOL fishAnimationStopFlag;
}

@property (nonatomic, unsafe_unretained) KitchenViewController *vc;

- (void)hideArrow;

@end
