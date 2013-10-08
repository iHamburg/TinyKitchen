//
//  UIImage+Extras.h
//  Supercry
//
//  Created by AppDevelopper on 14.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (Extras)

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
- (UIImage*)rotate:(UIImageOrientation)orient;
- (UIImage*)imageByScalingAndCroppingForWidth:(float)width;
//+ (id) createRoundedRectImage:(UIImage*)image size:(CGSize)size;
+ (UIImage*)imageWithView:(UIView*)view;
+ (UIImage*)imageWithView:(UIView*)view faktor:(float)faktor;
//+ (UIImage*)imageNamed:(NSString *)name;
+ (UIImage*)imageNamedUniversal:(NSString*)name;
+ (UIImage*)imageWithContentsOfFileUniversal:(NSString *)fileName;
//+ (UIImage*)imageWithContentsOfFileUniversal:(NSString *)fileName extension:(NSString*)extension;

+ (UIImage*)imageWithContentsOfFileName:(NSString *)fileName;
@end
