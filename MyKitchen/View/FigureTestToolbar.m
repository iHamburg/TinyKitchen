//
//  FigureTestToolbar.m
//  TinyKitchen
//
//  Created by  on 23.08.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "FigureTestToolbar.h"

@implementation FigureTestToolbar

@synthesize vc;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		
	
		UIBarButtonItem *bb0 = [[UIBarButtonItem alloc] initWithTitle:@"0" style:UIBarButtonItemStyleBordered target:vc action:@selector(toolbarButtonPressed:)];
		bb0.tag = kTagFigureTest0;
		
		UIBarButtonItem *manageBB = [[UIBarButtonItem alloc] initWithTitle:@"1" style:UIBarButtonItemStyleBordered target:vc action:@selector(toolbarButtonPressed:)];
		manageBB.tag = kTagFigureTest1;
		
		UIBarButtonItem *textBB = [[UIBarButtonItem alloc] initWithTitle:@"2" style:UIBarButtonItemStyleBordered target:vc action:@selector(toolbarButtonPressed:)];
		textBB.tag = kTagFigureTest2;	
		
		UIBarButtonItem *previewBB = [[UIBarButtonItem alloc] initWithTitle:@"3" style:UIBarButtonItemStyleBordered target:vc action:@selector(toolbarButtonPressed:)];
		previewBB.tag = kTagFigureTest3;
		
		UIBarButtonItem *mapBB = [[UIBarButtonItem alloc] initWithTitle:@"4" style:UIBarButtonItemStyleBordered target:vc action:@selector(toolbarButtonPressed:)];
		mapBB.tag = kTagFigureTest4;
		
		UIBarButtonItem *elcBB = [[UIBarButtonItem alloc] initWithTitle:@"5" style:UIBarButtonItemStyleBordered target:vc action:@selector(toolbarButtonPressed:)];
		elcBB.tag = kTagFigureTest5;
		
		UIBarButtonItem *bb6 = [[UIBarButtonItem alloc] initWithTitle:@"6" style:UIBarButtonItemStyleBordered target:vc action:@selector(toolbarButtonPressed:)];
		bb6.tag = kTagFigureTest6;
		
		UIBarButtonItem *bb7 = [[UIBarButtonItem alloc] initWithTitle:@"7" style:UIBarButtonItemStyleBordered target:vc action:@selector(toolbarButtonPressed:)];
		bb7.tag = kTagFigureTest7;
		
		UIBarButtonItem *bb8 = [[UIBarButtonItem alloc] initWithTitle:@"8" style:UIBarButtonItemStyleBordered target:vc action:@selector(toolbarButtonPressed:)];
		bb8.tag = kTagFigureTest8;
	
		UIBarButtonItem *bb9 = [[UIBarButtonItem alloc] initWithTitle:@"9" style:UIBarButtonItemStyleBordered target:vc action:@selector(toolbarButtonPressed:)];
		bb9.tag = kTagFigureTest9;
		
		UIBarButtonItem *bb10 = [[UIBarButtonItem alloc] initWithTitle:@"10" style:UIBarButtonItemStyleBordered target:vc action:@selector(toolbarButtonPressed:)];
		bb10.tag = kTagFigureTest10;
		
		UIBarButtonItem *bb11 = [[UIBarButtonItem alloc] initWithTitle:@"11" style:UIBarButtonItemStyleBordered target:vc action:@selector(toolbarButtonPressed:)];
		bb11.tag = kTagFigureTest11;
		
		UIBarButtonItem *bb12 = [[UIBarButtonItem alloc] initWithTitle:@"12" style:UIBarButtonItemStyleBordered target:vc action:@selector(toolbarButtonPressed:)];
		bb12.tag = kTagFigureTest12;
		
		UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		UIBarButtonItem *flexible = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		
		fixed.width = isPad?10:0;
		
		NSArray *coverItems = [NSArray arrayWithObjects:flexible,bb0,manageBB,textBB,previewBB,mapBB,elcBB,bb6,bb7,bb8,bb9,bb10,bb11,bb12,flexible,nil];
		self.items = coverItems;
		

    }
    return self;
}

- (IBAction)toolbarButtonPressed:(id)sender{
    
}

@end
