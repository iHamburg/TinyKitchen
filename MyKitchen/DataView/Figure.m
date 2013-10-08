//
//  Figure.m
//  TinyKitchen
//
//  Created by  on 30.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Figure.h"

@implementation Figure

@synthesize eatingPosition,mouthPosition;
@synthesize figureIndex, selectedTaste, durationOfEating;



- (void)load{
	[super load];
	
	// mouthPosiitonV是test，最后可以删掉
	mouthPositionV = [[UIView alloc]initWithFrame:mouthPosition];
	mouthPositionV.backgroundColor = [UIColor blueColor];
	mouthPositionV.alpha = 0.5;

	animationDistance = isPad?8:4;
	moveDuration = 0.8;
}



#pragma mark - Run

- (void)runBack{
	
	[head runBack];
	[eyes runBack];
	[mouth runBack];
	[leftBrow runBack];
	[rightBrow runBack];
}
- (void)runSeeWindow{

	
	[self playUp];
	[eyes runLeft];
	
}


- (void)runUnhappyWithoutFood{
	[self runSound:FigureSoundBad];
	[head runDownBack];
	[eyes runDownBack];
	
}
- (void)runHappyWithFood{

	[self runSound:FigureSoundYummy];
	[head runDownBack];
	[eyes runDownBack];
	[mouth runOpenBack];
	
}

/*
 
 只有在runWaitingEat的时候会cancel runsit
 */
- (void)runSit{
	

	
//	L();
//	
//
	int actionIndex = arc4random()%9;
//	NSLog(@"actionIndex:%d",actionIndex);
	if (actionIndex == 0) {
		[self playDown];
	}
	else if(actionIndex == 1){
		[self playLeft];
	}
	else if(actionIndex == 2){
		[self playUp];
	}
	else if(actionIndex == 3){
		[self playRight];
	}
	else if(actionIndex == 4){
		[self playLeftUp];
	}
	else if(actionIndex == 5){
		[self playLeftDown];
	}
	else if(actionIndex == 6){
		[self playRightUp];
	}
	else if(actionIndex == 7){
		[self playRightDown];
	}
	else if(actionIndex == 8){
		[self runBack];
	}

	
	//不停的绝对位移
	[self performSelector:@selector(runSit) withObject:nil afterDelay:0.8];
	
}

- (void)runWaitingForEat{
//	L();
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	
	[mouth runOpen];

}

/*
 
 吃的时候sit的动作会累计下来？吃完了一起出现？
 */

- (void)runEat{
	[self runSound:FigureSoundEating];
	
	//嘴动，自动停止
	[mouth runEating];
	
	//提前显示mouth表情会有2个mouth
	[self performSelector:@selector(playAfterEat) withObject:nil afterDelay:durationOfEating];
}

- (void)playAfterEat{
	L();
	NSLog(@"selectedTaste:%d",selectedTaste);
	
	if (selectedTaste == FoodTasteGood) { // happy
		[self runSound:FigureSoundGood];
		[self runHappy];
	}
	else if(selectedTaste == FoodTasteNotGood){ // sad
		[self runSound:FigureSoundBad];
		[self runSad];
	}
	else if(selectedTaste == FoodTasteYummy){ //yummy
		[self runSound:FigureSoundYummy];
		[self runYummy];
	}
//	[head runBack];
	
//	[self performSelector:@selector(runSit) withObject:nil afterDelay:1];
}

- (void)runCloseMouth{
	[mouth normal];
}

- (void)runHappy{
	L();
    for (AnimationPart *part in animationParts) {
        [part happy];
    }
	
	
	[head runUpBack];
	[eyes runUpBack];
	[leftBrow runUpBack];
	[rightBrow runUpBack];
	
}
- (void)runSad{
	L();
//	[self runs]
    for (AnimationPart *part in animationParts) {
        [part sad];
    }
	
	[leftBrow runDownBack];
	[rightBrow runDownBack];
	arc4random()%2?[eyes runLeftBack]:[eyes runRightBack];
//	[eyes runLeftBack];
	[head runDownBack];
}
- (void)runYummy{
	L();
    for (AnimationPart *part in animationParts) {
        [part yummy];
    }
	
	[head runDownBack];
	[eyes runDownBack];
	[leftBrow runUpBack];
	[rightBrow runUpBack];
	
	
}

- (void)runEyesWithPoint:(CGPoint)point{
	float maxValue = 3.14;
	float angle = atan2f(point.x-eyesPoint.x, point.y-eyesPoint.y);
//	NSLog(@"angle:%f",angle);
	
	//down: 0, right: 1.5; up 3;-3; left:-1.5
	
	if (angle<0.125*maxValue&&angle>-0.125*maxValue) { //下方
		[eyes runDown];
	}
	else if(angle<3.0/8*maxValue && angle>1.0/8*maxValue){ //rightdown
		[eyes runRightDown];
	}
	else if(angle<5.0/8*maxValue && angle>3.0/8*maxValue){ //rightdown
		[eyes runRight];
	}
	else if(angle<7.0/8*maxValue && angle>5.0/8*maxValue){ //rightdown
		[eyes runRightUp];
	}
	else if(angle>7.0/8*maxValue || angle<-7.0/8*maxValue){ //rightdown
		[eyes runUp];
	}
	else if(angle>-3.0/8*maxValue && angle<-1.0/8*maxValue){ //rightdown
		[eyes runLeftDown];
	}
	else if(angle>-5.0/8*maxValue && angle<-3.0/8*maxValue){ //rightdown
		[eyes runLeft];
	}
	else if(angle>-7.0/8*maxValue && angle<-5.0/8*maxValue){ //rightdown
		[eyes runLeftUp];
	}
}


#pragma mark - Intern Action

- (void)playUp{
	[head runUp];
	[eyes runUp];
	[leftBrow runUp];
	[rightBrow runUp];
	
}
- (void)playDown{
	[head runDown];
	[eyes runDown];
	[leftBrow runDown];
	[rightBrow runDown];
}
- (void)playLeft{
	[head runLeft];
	[eyes runLeft];
	[leftBrow runLeft];
	[rightBrow runLeft];
}
- (void)playRight{
	[head runRight];
	[eyes runRight];
	[leftBrow runRight];
	[rightBrow runRight];
}

- (void)playLeftUp{
	[head runLeftUp];
	[eyes runLeftUp];
}
- (void)playLeftDown{
	[head runLeftDown];
	[eyes runLeftDown];
}
- (void)playRightUp{
	[head runRightUp];
	[eyes runRightUp];
}
- (void)playRightDown{
	[head runRightDown];
	[eyes runRightDown];
}
- (void)playUpBack{
	[head runUpBack];
	[eyes runUpBack];
	[leftBrow runUpBack];
	[rightBrow runUpBack];
}
- (void)playDownBack{
	[head runDownBack];
	[eyes runDownBack];
	[leftBrow runDownBack];
	[rightBrow runDownBack];

}
- (void)playLeftBack{
	[head runLeftBack];
	[eyes runLeftBack];
	[leftBrow runLeftBack];
	[rightBrow runLeftBack];

}
- (void)playRightBack{
	[head runRightBack];
	[eyes runRightBack];
	[leftBrow runRightBack];
	[rightBrow runRightBack];

}

-(void)playLeftUpBack{
	[head runLeftUpBack];
	[eyes runLeftUpBack];
}
- (void)playLeftDownBack{
	[head runLeftDownBack];
	[eyes runLeftDownBack];
}
- (void)playRightUpBack{
	[head runRightUpBack];
	[eyes runRightUpBack];
}
- (void)playRightDownBack{
	[head runRightDownBack];
	[eyes runRightDownBack];
}

- (void)playBigBack{
	

	head.backgroundColor = [UIColor redColor];
//	[head runBigBack];
//	NSLog(@"before eyes:%@",eyes);
	[eyes runBigBack];
//	NSLog(@"After eyes:%@",eyes);
}

- (void)playHeadLeftRight{
	[UIView animateWithDuration:kActionHeadDuration/2 animations:^{
		[head moveOrigin:CGPointMake(-15, 0)];
		
	} completion:^(BOOL finished) {
		if (stopFlag) {
			return;
		}
		[UIView animateWithDuration:kActionHeadDuration animations:^{
			[head moveOrigin:CGPointMake(30, 0)];
		} completion:^(BOOL finished) {
			if (stopFlag) {
				return;
			}
			[UIView animateWithDuration:kActionHeadDuration/2 animations:^{
				[head moveOrigin:CGPointMake(-15, 0)];
			} completion:^(BOOL finished) {
				
			}];
		}];
	}];
	
	
}
- (void)playHeadUpDown{
	[UIView animateWithDuration:kActionHeadDuration/2 animations:^{
		[head moveOrigin:CGPointMake(0, -15)];
				
	} completion:^(BOOL finished) {
		if (stopFlag) {
			return;
		}
		[UIView animateWithDuration:kActionHeadDuration animations:^{
			[head moveOrigin:CGPointMake(0, 30)];
		} completion:^(BOOL finished) {
			if (stopFlag) {
				return;
			}
			[UIView animateWithDuration:kActionHeadDuration/2 animations:^{
				[head moveOrigin:CGPointMake(0, -15)];
			} completion:^(BOOL finished) {
				
			}];
		}];
	}];

	
}
#pragma mark -


// 这个可以用observer或是notification
- (void)toEatStatus{
	initialFrame = eatingPosition;
	self.frame = initialFrame;

	//head要改变initialframe的size
	head.initialFrame = CGRectMake(0, 0, initialFrame.size.width, initialFrame.size.height);
	eyes.initialFrame = CGRectMake(0, 0, initialFrame.size.width, initialFrame.size.height);
	leftBrow.initialFrame = CGRectMake(0, 0, initialFrame.size.width, initialFrame.size.height);
	rightBrow.initialFrame = CGRectMake(0, 0, initialFrame.size.width, initialFrame.size.height);
	}


- (void)runSound:(FigureSoundType)type{
	
//	NSLog(@"audioIDs:%@",audioIDs);
	NSLog(@"runsound:%d",type);
	
	SystemSoundID soundid = audioIDs[type];
	AudioServicesPlaySystemSound(soundid);

}

- (FoodTasteType)willEatFood:(Food*)food{
	
	// 不同的figure会根据食物的不同状态来选择吃不吃
	return FoodTasteGood;
}

- (Food*)wantFood{
	
	//从喜爱的食物category中随即找一个
	
	return nil;
	
}


+ (NSString*)NSStringFromFigureIndex:(FigureIndex)index{
//	FigureNinja,
//	FigureCat,
//	FigureLion,
//	FigurePinguin

	NSString *figure;
	switch (index) {
		case FigureNinja:
			figure = @"Ninja";
			break;
		case FigureCat:
			figure = @"Cat";
			break;
		case FigureLion:
			figure = @"Lion";
			break;
		case FigurePinguin:
			figure = @"Pinguin";
			break;
		default:
			break;
	}
	
	return figure;
}

@end
