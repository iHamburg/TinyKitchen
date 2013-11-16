//
//  PatientalGateValidator.h
//  3in1KidsGames
//
//  Created by AppDevelopper on 13-10-22.
//
//

#import <Foundation/Foundation.h>





typedef void (^ValidatorCompletionHandler)(BOOL completed);

@interface ParentalGateValidator : NSObject<UIAlertViewDelegate>{
    
    int sum;
    ValidatorCompletionHandler completionHandler;
}

@property (nonatomic, copy)  ValidatorCompletionHandler completionHandler;



- (void)validate;


@end

