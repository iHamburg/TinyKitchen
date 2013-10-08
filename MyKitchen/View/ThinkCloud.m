//
//  ThinkCloud.m
//  TinyKitchen
//
//  Created by  on 25.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "ThinkCloud.h"

@implementation ThinkCloud

- (void)load{
	[super load];
	
	foodV = [[UIImageView alloc]initWithFrame:CGRectMake(40, 30, 120, 100)];
	foodV.autoresizingMask = kAutoResize;
	foodV.contentMode = UIViewContentModeCenter;
	[self addSubview:foodV];
}

- (void)addFoodImg:(UIImage*)foodImg{
//	NSLog(@"img.size:%@",NSStringFromCGSize(foodImg.size));
	
	if (foodImg.size.width>120 || foodImg.size.height>100) {
		foodV.contentMode = UIViewContentModeScaleAspectFit;
	}
	else {
		foodV.contentMode = UIViewContentModeCenter;
	}
	foodV.image = foodImg;
}
@end
