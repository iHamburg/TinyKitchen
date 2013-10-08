//
//  ImageManager.m
//  TinyKitchen
//
//  Created by  on 13.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "ImageManager.h"

@implementation ImageManager
+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	
	return sharedInstance;
	
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

- (UIImage*)imgWithWhiteEffect:(UIImage*)img{
	CIImage *beginImage = [CIImage imageWithCGImage:img.CGImage];
	
	CIImage *output = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, beginImage,
					   @"inputContrast", [NSNumber numberWithFloat:0.9],nil].outputImage;
							 
  	
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef cgiimage = [context createCGImage:output fromRect:output.extent];
    
//    CGFloat scale = isRetina?2.0:1.0;
    UIImage *newImage = [UIImage imageWithCGImage:cgiimage scale:1.0 orientation:UIImageOrientationUp];
	
    CGImageRelease(cgiimage);
	
    NSLog(@"white image:%@,img.scale:%f",NSStringFromCGSize(newImage.size),newImage.scale);
    return newImage;
}

- (UIImage*)imgWithMaskImage:(UIImage*)maskImg bgImg:(UIImage*)bgImg{
	CGSize size = maskImg.size;
	CGRect rect = CGRectMake(0, 0, size.width, size.height);
	
	UIGraphicsBeginImageContextWithOptions(size, NO, 0); //No－》可以有透明，alpha， // 0->scale根据device默认！
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGImageRef alphaImage = CGImageRetain(maskImg.CGImage);
	
	CGImageRef image = CGImageRetain(bgImg.CGImage);
	
	
	CGFloat height = size.height;
	CGContextTranslateCTM(context, 0.0, height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	CGContextSaveGState(context);
	CGContextClipToMask(context, rect, alphaImage);
	CGContextDrawImage(context, rect, image);
	
	CGImageRelease(image);
	CGImageRelease(alphaImage);
	
	UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return im;
}

- (UIImage*)imgWithCIBlend:(UIImage*)sourceImg bgImg:(UIImage*)bgImg{
	CIImage *beginImage = [CIImage imageWithCGImage:sourceImg.CGImage];
//	CIImage *bgImage = [CIImage imageWithCGImage:bgImg.CGImage];
	
	//这两个的大小应该一样！
	
//    CIImage *blackAndWhite = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, beginImage, @"inputBrightness", [NSNumber numberWithFloat:0.0], @"inputContrast", [NSNumber numberWithFloat:1.1], @"inputSaturation", [NSNumber numberWithFloat:0.0], nil].outputImage;
  
	//没有screen，multipy？
	CIImage *output = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, beginImage,
					   @"inputContrast", [NSNumber numberWithFloat:0.6],nil].outputImage; 
	
	//这个是必须的
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgiimage = [context createCGImage:output fromRect:output.extent];
    
//    CGFloat scale = isRetina?2.0:1.0;
//    UIImage *newImage = [UIImage imageWithCGImage:cgiimage scale:scale orientation:UIImageOrientationUp];

	return [UIImage imageWithCGImage:cgiimage];
}

- (UIImage*)imgWithBlend:(CGBlendMode)mode Souce:(UIImage *)sourceImg destinateImg:(UIImage*)destinateImg{
	
	
	
//	CGContextSetFillColorWithColor(context, destinationColor.CGColor);
//	CGContextFillRect(context, CGRectMake(110.0, 20.0, 100.0, 100.0));
//	// Set up our blend mode
//	CGContextSetBlendMode(context, blendMode);
//	// And draw a rect with the "foreground" color - this is the "Source" for the blending formulas
//	CGContextSetFillColorWithColor(context, sourceColor.CGColor);
//	CGContextFillRect(context, CGRectMake(60.0, 45.0, 200.0, 50.0));
	
	NSLog(@"souceImg:%@",sourceImg);
	
	CGSize size = sourceImg.size;
	CGRect rect = CGRectMake(0, 0, size.width, size.height);
	
	UIGraphicsBeginImageContextWithOptions(size, NO, 0); //No－》可以有透明，alpha， // 0->scale根据device默认！
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGImageRef sourceImage = CGImageRetain(sourceImg.CGImage);
	
	CGImageRef destinateImage = CGImageRetain(destinateImg.CGImage);
	
	
	CGFloat height = size.height;
	CGContextTranslateCTM(context, 0.0, height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
//	CGContextSaveGState(context);
	CGContextClipToMask(context, rect, sourceImage);
	CGContextDrawImage(context, rect, sourceImage);
	CGContextSetBlendMode(context, mode);
	CGContextDrawImage(context, rect, destinateImage);
	
	CGImageRelease(destinateImage);
	CGImageRelease(sourceImage);
	
	UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return im;
}
@end
