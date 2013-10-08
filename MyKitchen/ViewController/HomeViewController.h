//
//  HomeViewController.h
//  MyKitchen
//
//  Created by  on 29.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
#import "RootViewController.h"

@interface HomeViewController : UIViewController<SpriteDelegate>{
	UIButton *infoB;
	UIButton *moreB;
	UIButton *startB;
	UIButton *sprecherB;
    Sprite *start;

	
}

@property (nonatomic, unsafe_unretained) RootViewController *rootVC;
@end
