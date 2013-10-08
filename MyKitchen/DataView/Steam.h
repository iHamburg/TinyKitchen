//
//  Steam.h
//  TinyKitchen
//
//  Created by  on 08.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Sprite.h"

//应该有2个view不停的交替上升

@interface Steam : Sprite{

	UIImageView *v1, *v2, *v3;
}

@property (nonatomic, assign) float duration;

- (void)runSubviewHover:(UIView*)v;

@end
