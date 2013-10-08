//
//  FoodManager.m
//  TinyKitchen
//
//  Created by XC on 7/31/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "FoodManager.h"

@implementation FoodManager

+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	return sharedInstance;
}

- (id)init{
    if (self = [super init]) {
        foodNames = [NSArray arrayWithContentsOfFile:[NSString filePathForResource:@"Foods.plist"]];
//        NSLog(@"foodNames:%@",foodNames);
        foods = [NSMutableArray array];
        for (int i = 0; i<[foodNames count]; i++) {
            NSMutableArray *categorys = [NSMutableArray array];
            NSArray *catFoodNames = [foodNames objectAtIndex:i];
            for (int j = 0; j<[catFoodNames count]; j++) {
                [categorys addObject:[NSNull null]];
            }
           
            [foods addObject:categorys];
        }
        
//        NSLog(@"foods:%@",foods);
    }
    return self;
}

- (NSArray *)foodsWithCategory:(FoodCategory)foodcategory{
    NSMutableArray *catFoods = [foods objectAtIndex:foodcategory];
//    NSLog(@"catFoods:%@",catFoods);
    
    Food *food = [catFoods objectAtIndex:0];
    if (![food isKindOfClass:[NSNull class]]) { // already loaded
        return catFoods;
    }
  
    //load food
    NSArray *catFoodNames = [foodNames objectAtIndex:foodcategory];
    
    for (int i = 0; i<[catFoodNames count]; i++) {
		
		// normally init Food
        Food *food = [[Food alloc]initWithName:[catFoodNames objectAtIndex:i]];
        food.category = foodcategory;
        [catFoods replaceObjectAtIndex:i withObject:food];
    }
    return catFoods;
}

- (Food*)foodRandomInCategory:(FoodCategory)category{
	NSMutableArray *catFoods = [foods objectAtIndex:category];
	//    NSLog(@"catFoods:%@",catFoods);
    
    Food *food = [catFoods objectAtIndex:0];
    if (![food isKindOfClass:[NSNull class]]) { // already loaded
        return [catFoods randomObject];
    }
	
    //load food
    NSArray *catFoodNames = [foodNames objectAtIndex:category];
    
    for (int i = 0; i<[catFoodNames count]; i++) {
        Food *food = [[Food alloc]initWithName:[catFoodNames objectAtIndex:i]];
        food.category = category;
        [catFoods replaceObjectAtIndex:i withObject:food];
    }
    return [catFoods randomObject];
}

- (Food*)foodInMaschineWithName:(NSString*)name{
	Food *food = [[Food alloc]initWithName:name];
	return food;
}
- (Food*)foodinWorkingMaschineWithName:(NSString*)name{

	Food *food = [[Food alloc]initWithName:name];
	return food;
}

#pragma mark - Food in Outdoor
- (Food*)foodInOutdoorViewWithIndex:(FoodOutdoorIndex)index{
	NSString *foodName;
	Food *food ;
	if (index == FoodOutdoorAubergine) {
		foodName = @"aubergine_default1.png";
		food = [[Food alloc]initWithName:foodName frame:isPad?CGRectMake(400, 270, 130, 75):CGRectMake(192, 118, 60, 30)];
	}
	else if(index == FoodOutdoorCarrot){
		foodName = @"carrot_default1.png";
		food = [[Food alloc]initWithName:foodName frame:isPad?CGRectMake(250, 270, 120, 70):CGRectMake(120, 118, 50, 30)];
	}
	else if(index == FoodOutdoorRadish){
		foodName = @"radish_default1.png";
		food = [[Food alloc]initWithName:foodName frame:isPad?CGRectMake(100, 250, 88, 88):CGRectMake(41, 100, 40, 40)];
	}
	else if(index == FoodOutdoorTomato){
		foodName = @"tomato_default1.png";
		food = [[Food alloc]initWithName:foodName frame:isPad?CGRectMake(560, 270, 100, 100):CGRectMake(265, 115, 40, 40)];
	}
	else if(index == FoodOutdoorFish){
		foodName = @"fish_default1.png";
		food = [[Fish alloc]initWithName:foodName frame:isPad?CGRectMake(700, 470, 150, 70):CGRectMake(368, 209, 60, 30)];
	}
	
//	NSLog(@"food.initialFrame:%@",NSStringFromCGRect(food.initialFrame));
	
	return food;
}

- (NSArray*)foodMushroomsInOutdoor{
	NSMutableArray *array = [NSMutableArray array];
	
	Food *food1 = [[Food alloc]initWithName:@"rushroom1_default.png" frame:isPad?CGRectMake(125, 500, 100, 100):CGRectMake(62, 212, 40, 40)];
	[array addObject:food1];
	Food *food2 = [[Food alloc]initWithName:@"rushroom2_default1.png" frame:isPad?CGRectMake(0, 410, 100, 100):CGRectMake(0, 170, 40, 40)];
	[array addObject:food2];
	Food *food3 = [[Food alloc]initWithName:@"rushroom3_default.png" frame:isPad?CGRectMake(800, 310, 100, 100):CGRectMake(378, 130, 40, 40)];
	[array addObject:food3];
	Food *food4 = [[Food alloc]initWithName:@"rushroom4_default.png" frame:isPad?CGRectMake(18, 265, 100, 100):CGRectMake(12, 109, 40, 40)];
	[array addObject:food4];
	
	return array;
}
- (NSArray*)foodApplesInOutdoor{

	NSMutableArray *array = [NSMutableArray array];
	
	Food *food1 = [[Food alloc]initWithName:@"apple_default1.png" frame:isPad?CGRectMake(820, 65, 85, 85):CGRectMake(386, 25, 40, 40)];
	
	[array addObject:food1];
	Food *food2 = [[Food alloc]initWithName:@"apple_default1.png" frame:isPad?CGRectMake(710, 160, 65, 65):CGRectMake(342, 70, 30, 30)];
	[array addObject:food2];
	Food *food3 = [[Food alloc]initWithName:@"apple_default1.png" frame:isPad?CGRectMake(910, 110, 65, 65):CGRectMake(434, 50, 30, 30)];
	[array addObject:food3];

	
	return array;
}
@end
