//
//  MoreAppView.h
//  TinyKitchen
//
//  Created by  on 25.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"

@protocol MoreAppViewDelegate;

@interface MoreAppView : UIView{
	UIView *bar;
	UIImageView *icon;
	UIImageView *featureMaske;
	UITextView *descriptionV;
	UILabel *titleL;
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *iconImg;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, assign) BOOL isfeatured;

@property (nonatomic, unsafe_unretained) id<MoreAppViewDelegate>delegate;
@end

@protocol MoreAppViewDelegate <NSObject>

- (void)moreAppViewDidClicked:(MoreAppView*)moreAppView;

@end