//
//  Controller.m
//  SportTraining
//
//  Created by  on 10.03.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Controller.h"


@implementation Controller

@synthesize figureIndex;

@synthesize ofen,pan,pot,microwelle;

- (id)init{
	if (self = [super init]) {
        
		[FoodManager sharedInstance];
		[AudioController sharedInstance];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(save)
													 name:UIApplicationWillResignActiveNotification
												   object: [UIApplication sharedApplication]];
		
//		NSLog(@"r in controller # %@",NSStringFromCGRect(_r));
		ofen = [[Ofen alloc]initWithFrame:kFrameUniversalHorizont];
		pot = [[Pot alloc]initWithFrame:kFrameUniversalHorizont];
		pan = [[Pan alloc]initWithFrame:kFrameUniversalHorizont];
		microwelle = [[Microwelle alloc]initWithFrame:kFrameUniversalHorizont];
	}
	return self;
}

+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	
	return sharedInstance;
	
}

+ (id)maschineWithType:(MaschineType)type{
	Maschine *maschine;
	if (type == MaschineOfen) {
		
	}
	return maschine;
}

- (void)save{
	L();
	[[NSUserDefaults standardUserDefaults]synchronize];
}

- (UIImage *)makeImageBW:(UIImage*)img
{
    CIImage *beginImage = [CIImage imageWithCGImage:img.CGImage];
	
    CIImage *blackAndWhite = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, beginImage, @"inputBrightness", [NSNumber numberWithFloat:0.0], @"inputContrast", [NSNumber numberWithFloat:1.1], @"inputSaturation", [NSNumber numberWithFloat:0.0], nil].outputImage;
    CIImage *output = [CIFilter filterWithName:@"CIExposureAdjust" keysAndValues:kCIInputImageKey, blackAndWhite, @"inputEV", [NSNumber numberWithFloat:0.7], nil].outputImage; 
	
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef cgiimage = [context createCGImage:output fromRect:output.extent];
    
    CGFloat scale = isRetina?2.0:1.0;
    UIImage *newImage = [UIImage imageWithCGImage:cgiimage scale:scale orientation:UIImageOrientationUp];
	
    CGImageRelease(cgiimage);
	
    
    return newImage;
}


@end
