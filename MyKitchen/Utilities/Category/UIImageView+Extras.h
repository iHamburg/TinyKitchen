//
//  UIImageView+Extras.h
//  MyKitchen
//
//  Created by  on 26.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "UIImage+Extras.h"

@interface UIImageView (Extras)


+ (id)imageViewWithName:(NSString*)imgName frame:(CGRect)rect;
- (void)setAnimationImageNames:(NSArray *)animationImageNames;


@end
