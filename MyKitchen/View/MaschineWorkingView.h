//
//  MaschineWorkingView.h
//  TinyKitchen
//
//  Created by  on 30.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KitchenViewController.h"

/*
 
 只有可以被机器处理的食物(有处理图片的食物)才会进入本view，或者没有食物也能进入本页

 Maschine里面可以设定一个Food
 
 */
@interface MaschineWorkingView : UIView<SpriteDelegate>{
	UIView *container;
	
	Sprite *back;
	Maschine *maschine;
	Maschine *ofen,*pan,*pot,*microwelle;
	NSArray *maschines;
}
@property (nonatomic, assign) FigureIndex figure;
@property (nonatomic, strong) Sprite *back;
@property (nonatomic, assign) MaschineType maschineType;
@property (nonatomic, strong) Food *food;
@property (nonatomic, unsafe_unretained) KitchenViewController *vc;

- (void) setup;

@end
