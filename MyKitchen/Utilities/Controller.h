//
//  Controller.h
//  SportTraining
//
//  Created by  on 10.03.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>


// 只导入app独立的部分
#import "Utilities.h"
#import "FBViewController.h" //Facebook
#import "Flurry.h"  //Flurry

#import "UtilityViews.h"
#import "UtilityManagers.h"
#import "FoodManager.h"
#import "Food.h"
#import "Lion.h"
#import "Ninja.h"
#import "Cat.h"
#import "Pinguin.h"
#import "Pan.h"
#import "Pot.h"
#import "Microwelle.h"
#import "Ofen.h"

@interface Controller : NSObject{

//	Maschine *ofen,*pan,*pot,*microwelle;
}

@property (nonatomic, assign) int figureIndex;

@property (nonatomic, strong) Maschine *ofen,*pan,*pot,*microwelle;


+ (id)sharedInstance;

+ (id)maschineWithType:(MaschineType)type;

- (void)save;


@end
