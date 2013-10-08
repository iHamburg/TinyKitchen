//
//  ImageManager.h
//  TinyKitchen
//
//  Created by  on 13.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utilities.h"

@interface ImageManager : NSObject

+(id)sharedInstance;


- (UIImage *)makeImageBW:(UIImage*)img;

- (UIImage*)imgWithMaskImage:(UIImage*)maskImg bgImg:(UIImage*)bgImg;

- (UIImage*)imgWithBlend:(CGBlendMode)mode Souce:(UIImage *)sourceImg destinateImg:(UIImage*)destinateImg;

- (UIImage*)imgWithWhiteEffect:(UIImage*)img;

- (UIImage*)imgWithCIBlend:(UIImage*)sourceImg bgImg:(UIImage*)bgImg;
@end
