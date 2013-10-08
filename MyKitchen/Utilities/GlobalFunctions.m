//
//  GlobalFunctions.m
//  KidsLearn
//
//  Created by  on 18.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//


#import "GlobalFunctions.h"
#import "Category.h"


CGFloat _h,_w,_hAdBanner;
CGRect _r,_containerRect;

void saveArchived(id obj, NSString *name){
	
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
								 initForWritingWithMutableData:data];
	[archiver encodeObject:obj forKey:name];
	[archiver finishEncoding];
	[data writeToFile:[NSString dataFilePath:name] atomically:YES];
	
}

id loadArchived(NSString* name){
	
	NSString *filePath = [NSString dataFilePath:name];
	//	NSLog(@"filePath:%@",filePath);
	id obj = nil;
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		
		NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
										 initForReadingWithData:data];
		obj = [unarchiver decodeObjectForKey:name];
		[unarchiver finishDecoding];
	}
	return obj;
}

BOOL isPaid(void){
	BOOL flag;
#ifdef FREE
	flag = NO;
#else
	flag= YES;
#endif
	return flag;
}


BOOL IsBitZero(int a, int n)
{
    a = a>>n;
	
    if( (a & 1) == 0 )
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

