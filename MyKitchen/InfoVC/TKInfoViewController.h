//
//  TKInfoViewController.h
//  TinyKitchen
//
//  Created by AppDevelopper on 13-10-9.
//  Copyright (c) 2013年 Xappsoft. All rights reserved.
//

#import "InfoViewController.h"

@interface TKInfoViewController : InfoViewController{
    
	UIButton *aboutB,*recommendB,*supportB,*facebookB,*twitterB, *downloadB, *instructionB;
	UIButton *myecardB,*tinyKitchenB,*ncsB, *firstAppB;
	UIImageView *binder, *ribbon,*featureV;
	UIScrollView *scrollView;
	UILabel *otherAppL;
	UITextView *textV;
    
	CGFloat width,height;

}

@end
