//
//  MoreAppView.m
//  TinyKitchen
//
//  Created by  on 25.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "MoreAppView.h"

@implementation MoreAppView

@synthesize delegate;
@synthesize iconImg, description,title,isfeatured;

// 高度不确定，宽度和屏幕等宽

/*
 iphone:
 bar: 32
 icon: 
 */


- (void)setIconImg:(UIImage *)_iconImg{
	icon.image = _iconImg;
}

- (void)setDescription:(NSString *)_description{
	descriptionV.text = _description;
}

- (void)setTitle:(NSString *)_title{
	titleL.text = _title;
}

- (void)setIsfeatured:(BOOL)_isfeatured{
	featureMaske = [[UIImageView alloc]initWithFrame:CGRectMake(0, 32, 100, 30)];
	featureMaske.image = [UIImage imageWithContentsOfFileUniversal:@"appIconFeature.png"];
	[self addSubview:featureMaske];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
		bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, isPad?64:32)];
		bar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"More_bar_bg.png"]];
		
		titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, isPad?64:32)];
		titleL.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"More_bar_bg.png"]];
		titleL.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:20];
		titleL.textColor = [UIColor colorWithHEX:@"d67600"];
		titleL.textAlignment = UITextAlignmentCenter;
		
		icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 75, 75)];
		
		
		descriptionV = [[UITextView alloc]initWithFrame:CGRectMake(100, 32, 375, frame.size.height-32)];
//		descriptionV = [[UITextView alloc]initWithFrame:CGRectMake(200, 64, frame.size.width-250, frame.size.height-64)];
		descriptionV.backgroundColor = [UIColor clearColor];
		descriptionV.font = [UIFont fontWithName:@"Chalkboard SE" size:10];
		descriptionV.textColor = [UIColor whiteColor];
		descriptionV.editable = NO;
		descriptionV.userInteractionEnabled = NO;
		
		[self addSubview:titleL];
		[self addSubview:icon];
		[self addSubview:descriptionV];
		
		[self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)]];
    }
    return self;
}

- (void)handleTap:(UITapGestureRecognizer*)gesture{
	L();
	[delegate moreAppViewDidClicked:self];
}

@end
