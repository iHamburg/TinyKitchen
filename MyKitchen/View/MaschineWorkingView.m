//
//  MaschineWorkingView.m
//  TinyKitchen
//
//  Created by  on 30.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "MaschineWorkingView.h"


@implementation MaschineWorkingView

@synthesize vc,back,food,figure,maschineType;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		
		container = [[UIView alloc]initWithFrame:_containerRect];
		
		[self setBGView:@"small_appliances_BG.jpg"];		
        back = [[Sprite alloc]initWithFrame:isPad?CGRectMake(10, 10, 100, 100):CGRectMake(10, 10, 50, 50)];
        back.delegate = self;

		Controller *controller = [Controller sharedInstance];

		ofen = [[Controller sharedInstance]ofen];
		ofen.delegate = nil;
		pot = [[Controller sharedInstance]pot];
		pot.delegate = nil;
		pan = controller.pan;
		pan.delegate = nil;
		microwelle = controller.microwelle;
		microwelle.delegate = nil;
		
		maschines = [NSArray arrayWithObjects:ofen,pot,pan,microwelle, nil];

		
//		NSLog(@"ofen # %@",ofen);
		[self addSubview:container];
		[self addSubview:back];
	
		
    }
    return self;
}


- (void)setup{
    
    //predefined: maschineType,food,figure
    
	
    figure = [[Controller sharedInstance]figureIndex];
	
    if (figure == FigureCat) {
        back.image = [UIImage imageNamedUniversal:@"Figures_icon_cat.png"];
    }
    else if(figure == FigureLion){
        back.image = [UIImage imageNamedUniversal:@"Figures_icon_lion.png"];
    }
    else if(figure == FigureNinja){
        back.image = [UIImage imageNamedUniversal:@"Figures_icon_ninjia.png"];
    }
    else if (figure == FigurePinguin) {
        back.image = [UIImage imageNamedUniversal:@"Figures_icon_pinguin.png"];
    }
	
	
	for (Maschine *aMaschine in maschines) {
//			NSLog(@"maschine # %@",aMaschine);
		[aMaschine removeFromSuperview];
		if (aMaschine.type == maschineType) {
			
			// maschine和food不可能完全正交，所以food放到maschine内是可以的
			maschine = aMaschine;
			maschine.food = food; 
			
//			maschine.center = CGPointMake(_w/2, _h/2);
//			[self insertSubview:maschine belowSubview:back];
			[container addSubview:aMaschine];
			
		}
	}

//	NSLog(@"maschine before play# %@",maschine);
    [maschine play];
	
	//back 收缩

	[AnimationManager scale:back withScale:1.2 times:1];
	
//	NSLog(@"maschine # %@",maschine);
}


#pragma mark - SpriteDelegate
- (void)spriteDidClicked:(Sprite *)sprite{
	if (sprite == back) {

		//maschine cancel performSelector:stop, and stop it now

		[NSObject cancelPreviousPerformRequestsWithTarget:maschine];
		
		//这里会对food进行处理，或者是拿出来处理？
		[maschine stopImmediately];

		[vc getFoodFromWorkingView:food];
		
		maschine.food = nil;
	}
}
@end
