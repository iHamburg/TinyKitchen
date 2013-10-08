//
//  MaschinesView.h
//  TinyKitchen
//
//  Created by  on 30.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KitchenViewController.h"
#import "Ofen.h"
#import "Pan.h"
#import "Microwelle.h"
#import "Pot.h"
// 600x350
@interface MaschinesView : UIView<SpriteDelegate>{

	
	
	CGFloat width,margin;	
	CGRect openRect,closeRect;
    
	NSArray *maschines;
	UIImageView *ofen, *pan, *pot, *microwelle;
}

- (id)initWithVC:(KitchenViewController*)vc;
@property (nonatomic, unsafe_unretained) KitchenViewController *vc;
@property (nonatomic, assign) BOOL isOpen;


- (void)open;
- (void)close;

- (MaschineType)maschineTypeWithPoint:(CGPoint)point foodCategory:(FoodCategory)foodCategory;
- (void)setFoodWorkable:(FoodCategory)foodCategory;
- (void)reset;
@end
