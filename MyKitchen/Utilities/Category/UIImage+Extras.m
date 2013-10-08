//
//  UIImage+Extras.m
//  Supercry
//
//  Created by AppDevelopper on 14.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImage+Extras.h"
#import "Macros.h"
#import <QuartzCore/QuartzCore.h>

static inline CGSize swapWidthAndHeight(CGSize size)
{
    CGFloat  swap = size.width;
    
    size.width  = size.height;
    size.height = swap;
    
    return size;
}
@implementation UIImage (Extras)

#pragma mark -
#pragma mark Scale and crop image
//
//static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
//                                 float ovalHeight)
//{
//    float fw, fh;
//    if (ovalWidth == 0 || ovalHeight == 0) {
//        CGContextAddRect(context, rect);
//        return;
//    }
//	
//    
//    CGContextSaveGState(context);
//    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
//    CGContextScaleCTM(context, ovalWidth, ovalHeight);
//    fw = CGRectGetWidth(rect) / ovalWidth;
//    fh = CGRectGetHeight(rect) / ovalHeight;
//    
//    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
//    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
//    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
//    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
//    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
//	
//    
//    CGContextClosePath(context);
//    CGContextRestoreGState(context);
//}

//
//+ (id) createRoundedRectImage:(UIImage*)image size:(CGSize)size
//{
//    // the size of CGContextRef
//    int w = size.width;
//    int h = size.height;
//    
//    UIImage *img = image;
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
//    CGRect rect = CGRectMake(0, 0, w, h);
//    
//    CGContextBeginPath(context);
//   // addRoundedRectToPath(context, rect, 10, 10);
//    addRoundedRectToPath(context, rect, 12, 12);
//    CGContextClosePath(context);
//    CGContextClip(context);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    return [UIImage imageWithCGImage:imageMasked];
//}
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;        
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) 
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) 
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5; 
        }
        else 
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }       
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) 
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*)imageByScalingAndCroppingForWidth:(float)width{

    float oWidth = self.size.width;
    float oHeight = self.size.height;
    float height = width*oHeight/oWidth;
    
    CGSize targetSize = CGSizeMake(width, height);

    return [self imageByScalingAndCroppingForSize:targetSize];    
}



-(UIImage*)rotate:(UIImageOrientation)orient
{
    CGRect             bnds = CGRectZero;
    UIImage*           copy = nil;
    CGContextRef       ctxt = nil;
    CGRect             rect = CGRectZero;
    CGAffineTransform  tran = CGAffineTransformIdentity;
    
    bnds.size = self.size;
    rect.size = self.size;
    
    switch (orient)
    {
        case UIImageOrientationUp:
            return self;
            
        case UIImageOrientationUpMirrored:
            tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            tran = CGAffineTransformMakeTranslation(rect.size.width,
                                                    rect.size.height);
            tran = CGAffineTransformRotate(tran, degreesToRadians(180.0));
            break;
            
        case UIImageOrientationDownMirrored:
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            tran = CGAffineTransformScale(tran, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeft:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            tran = CGAffineTransformRotate(tran, degreesToRadians(-90.0));
            break;
            
        case UIImageOrientationLeftMirrored:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(rect.size.height,
                                                    rect.size.width);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(-90.0));
            break;
            
        case UIImageOrientationRight:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(90.0));
            break;
            
        case UIImageOrientationRightMirrored:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeScale(-1.0, 1.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(90.0));
            break;
            
        default:
            // orientation value supplied is invalid
            assert(false);
            return nil;
    }
    
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
    
    switch (orient)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctxt, -1.0, 1.0);
            CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(ctxt, 1.0, -1.0);
            CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
            break;
    }
    
    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(ctxt, rect, self.CGImage);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}

+ (UIImage*)imageWithView:(UIView*)view{
	UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	return aImage;
}

+ (UIImage*)imageWithView:(UIView*)view faktor:(float)faktor{
	CGSize originSize = view.bounds.size;
	CGSize newSize = CGSizeMake(originSize.width * faktor, originSize.height * faktor);
	
	UIGraphicsBeginImageContext(newSize);
    CGContextRef imageContext = UIGraphicsGetCurrentContext();
	
	
	// mirroring context
	//	CGContextTranslateCTM(imageContext, 0.0, imageSize.height);
	
	CGContextScaleCTM(imageContext, faktor, faktor);
	
	
    [view.layer renderInContext: imageContext];
    UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
    return viewImage;
	
}


// 图片都是～ipad和@2x～ipad，如果是iphone,没有ddd。png,只有ddd~ipad.png，img是nil,所以自动加上～ipad
+ (UIImage*)imageNamedUniversal:(NSString*)name{ //ddd.png
//	NSLog(@"imageNamed:name:%@",name);

	
	UIImage *img = [UIImage imageNamed:name];
	
	if (!img) {
		NSString *prefix = [name stringByDeletingPathExtension];
//		NSLog(@"prefix:%@",prefix);
		NSString *extention = [name substringFromIndex:[name length]-3];
//		NSLog(@"extention:%@",extention);
		
		NSString *newImgName = [NSString stringWithFormat:@"%@~ipad.%@",prefix,extention];
//		NSLog(@"new ImgName:%@",newImgName);
		img = [UIImage imageNamed:newImgName];
	}
	
	return img;
}

+ (UIImage*)imageWithContentsOfFileUniversal:(NSString *)fileName{
	NSString *prefix = [fileName stringByDeletingPathExtension];
	NSString *extension = [fileName substringFromIndex:[fileName length]-3];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:prefix ofType:extension];
//	NSLog(@"filename:%@,imageNamed:name:%@",fileName,path);
	UIImage *img;
	if (!path) {
		prefix = [NSString stringWithFormat:@"%@~ipad",prefix];
		
		path = [[NSBundle mainBundle] pathForResource:prefix ofType:extension];
//		NSLog(@"new prefix:%@, extension:%@,new path:%@",prefix,extension, path);
	}
	
	img = [UIImage imageWithContentsOfFile:path];
	return img;
	

}


/**
 
 有@2x的Path的前提是有非高清的图片！
 */
+ (UIImage*)imageWithContentsOfFileName:(NSString *)fileName{
	
	NSString *prefix = [fileName stringByDeletingPathExtension];
	NSString *extension = fileName.pathExtension;
	
	NSString *path = [[NSBundle mainBundle]pathForResource:prefix ofType:extension];
	
	UIImage *img = [UIImage imageWithContentsOfFile:path];
	
//	NSLog(@"imageName # %@,img # %@",fileName,img);
	return img;
}
@end
