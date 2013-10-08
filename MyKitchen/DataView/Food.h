//
//  Food.h
//  TinyKitchen
//
//  Created by XC on 7/31/12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Sprite.h"
#import "Steam.h"

/*
 

 baseV,
 fertigV,
 steam
 
 */

@interface Food : Sprite{

	 NSString *foodName;
    
	UIImage *fertigImg;
	UIImageView *baseV; //defaultView, 
	UIImageView *fertigV;
	
	Steam *steam;

    FoodState state;
}

@property (nonatomic, strong) NSString *defaultImageName; //用来copy的时候再次生成Food
@property (nonatomic, assign) FoodCategory category;
@property (nonatomic, assign) FoodState state;



- (id)initWithName:(NSString*)imgName;
- (id)initWithName:(NSString *)imgName frame:(CGRect)frame;
- (void)startWorkWithMaschineType:(MaschineType)maschineType;
- (void)stopWorkWithMaschine;
- (void)startSteaming;

- (NSString*)categoryName;
@end
