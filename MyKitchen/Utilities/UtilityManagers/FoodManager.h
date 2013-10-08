//
//  FoodManager.h
//  TinyKitchen
//
//  Created by XC on 7/31/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utilities.h"
#import "Food.h"
#import "Fish.h"

@interface FoodManager : NSObject{
    NSArray *foodNames;
    
    //foods是先都载入还是cache模式？　试试cache吧
    NSMutableArray *foods;
}

+(id)sharedInstance;

- (NSArray *)foodsWithCategory:(FoodCategory)foodcategory;
- (Food*)foodInMaschineWithName:(NSString*)name;
- (Food*)foodinWorkingMaschineWithName:(NSString*)name;
- (Food*)foodInOutdoorViewWithIndex:(FoodOutdoorIndex)index;
- (NSArray*)foodMushroomsInOutdoor;
- (NSArray*)foodApplesInOutdoor;

- (Food*)foodRandomInCategory:(FoodCategory)category;
@end
