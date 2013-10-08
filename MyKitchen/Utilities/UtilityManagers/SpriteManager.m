//
//  SpriteManager.m
//  SportTraining
//
//  Created by  on 10.03.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "SpriteManager.h"



@interface SpriteManager() {

    
}


@end

@implementation SpriteManager



+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	
	return sharedInstance;
	
}

- (id)init{
	if (self = [super init]) {
	

	}
	return self;
}

#pragma mark -
@end
