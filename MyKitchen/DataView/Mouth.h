//
//  Mouth.h
//  TinyKitchen
//
//  Created by  on 11.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "AnimationPart.h"

@interface Mouth : AnimationPart{
	UIImageView *eatingV;
}

@property (nonatomic, strong) UIImage *openImg;
@property (nonatomic, strong) NSArray *eatingParts;

- (void)runOpen;
- (void)runClose;
- (void)runEating;
- (void)runOpenBack;
@end
