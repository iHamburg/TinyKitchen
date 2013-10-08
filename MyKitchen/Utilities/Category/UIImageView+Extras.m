//
//  UIImageView+Extras.m
//  MyKitchen
//
//  Created by  on 26.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "UIImageView+Extras.h"

@implementation UIImageView (Extras)

+ (id)imageViewWithName:(NSString*)imgName frame:(CGRect)rect{
	
	UIImageView *imgV = [[UIImageView alloc]initWithFrame:rect];
	imgV.image = [UIImage imageWithContentsOfFileUniversal:imgName];
	return imgV;
}
- (void)setAnimationImageNames:(NSArray *)animationImageNames{
	NSMutableArray *imgs = [NSMutableArray array];
	for (NSString *imgName in animationImageNames) {
		UIImage *img = [UIImage imageWithContentsOfFileUniversal:imgName];
		[imgs addObject:img];
	}
	self.animationImages = imgs;
	
}


@end
