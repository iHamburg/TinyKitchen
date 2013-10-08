//
//  Timer.h
//  TinyKitchen
//
//  Created by  on 17.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"

@interface Timer : UIView{
	UILabel *label;
	int indexOfString;
}

@property (nonatomic, strong) NSArray *strings;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) float duration;

- (void)run;
- (void)stop;
@end
