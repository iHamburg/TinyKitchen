/*
    File: MyView.m
Abstract: MyView several subviews, each of which can be moved by gestures. Illustrates handling gesture events, incluing multiple gestures.
 Version: 1.13

 */

#import <QuartzCore/QuartzCore.h>
#import "ControlView.h"



@implementation ControlView

@synthesize delegate;

#pragma mark -
#pragma mark === Setting up and tearing down ===
#pragma mark

// adds a set of gesture recognizers to one of our piece subviews
- (void)addGestureRecognizersToPiece:(UIView *)piece
{
	// 怎么取消这个panGesture?
	
//	[piece remov]
	
//	UIRotationGestureRecognizer* rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotatePiece:)];
//    
//	UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scalePiece:)];
//    [pinchGesture setDelegate:self];
//  	
	
//	UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
//    [tapGesture setNumberOfTapsRequired:2];
//    
//	UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    [tap setNumberOfTapsRequired:1];
    
	UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    [panGesture setMaximumNumberOfTouches:1];
    [panGesture setDelegate:self];
	if ([delegate respondsToSelector:@selector(leftSwipeOnDelegate)]) {
		[panGesture requireGestureRecognizerToFail:[delegate leftSwipeOnDelegate]];
		[panGesture requireGestureRecognizerToFail:[delegate rightSwipeOnDelegate]];
	}
	  	

//	UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressed:)];
	

//	[piece addGestureRecognizer:rotationGesture];
//	
//	[piece addGestureRecognizer:pinchGesture];
//	
//	[piece addGestureRecognizer:tapGesture];
//	
//	[piece addGestureRecognizer:tap];
	
	[piece addGestureRecognizer:panGesture];
	
//	[piece addGestureRecognizer:longPressGesture];

    
}




#pragma mark -  === Utility methods  ===
// scale and rotation transforms are applied relative to the layer's anchor point
// this method moves a gesture recognizer's view's anchor point between the user's fingers
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
   
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        
		CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
//		NSLog(@"locationInsuperView:%@",NSStringFromCGPoint(locationInSuperview));
		
		piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
		
		
        piece.center = locationInSuperview;
		
		
    }
}


// ensure that the pinch, pan and rotate gesture recognizers on a particular view can all recognize simultaneously
// prevent other gesture recognizers from recognizing simultaneously
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    
    // if the gesture recognizers's view isn't one of our pieces, don't allow simultaneous recognition
//    if (gestureRecognizer.view != firstPieceView && gestureRecognizer.view != secondPieceView && gestureRecognizer.view != thirdPieceView)
//        return NO;
	//    
    // if the gesture recognizers are on different views, don't allow simultaneous recognition
//    if (gestureRecognizer.view != otherGestureRecognizer.view)
//        return NO;  
    
    // if either of the gesture recognizers is the long press, don't allow simultaneous recognition
	//    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
	//        return NO;
    
    return YES;
//    return NO;
}


// display a menu with a single item to allow the piece's transform to be reset
//- (void)showResetMenu:(UILongPressGestureRecognizer *)gestureRecognizer
//{
//    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
//        UIMenuController *menuController = [UIMenuController sharedMenuController];
//        UIMenuItem *resetMenuItem = [[UIMenuItem alloc] initWithTitle:@"Reset" action:@selector(resetPiece:)];
//        CGPoint location = [gestureRecognizer locationInView:[gestureRecognizer view]];
//        
//        [self becomeFirstResponder];
//        [menuController setMenuItems:[NSArray arrayWithObject:resetMenuItem]];
//        [menuController setTargetRect:CGRectMake(location.x, location.y, 0, 0) inView:[gestureRecognizer view]];
//        [menuController setMenuVisible:YES animated:YES];
//        
//        selectedPiece = (EditableView*)[gestureRecognizer view];
//        
//    }
//}


// animate back to the default anchor point and transform
- (void)resetPiece:(UIMenuController *)controller
{
    CGPoint locationInSuperview = [selectedPiece convertPoint:CGPointMake(CGRectGetMidX(selectedPiece.bounds), CGRectGetMidY(selectedPiece.bounds)) toView:[selectedPiece superview]];
    
    [[selectedPiece layer] setAnchorPoint:CGPointMake(0.5, 0.5)];
    [selectedPiece setCenter:locationInSuperview];
    
    [UIView beginAnimations:nil context:nil];
    [selectedPiece setTransform:CGAffineTransformIdentity];
    [UIView commitAnimations];
}



// UIMenuController requires that we can become first responder or it won't display
- (BOOL)canBecomeFirstResponder
{
    return YES;
	
}

#pragma mark -
#pragma mark === Touch handling  ===
#pragma mark


// shift the piece's center by the pan amount
// reset the gesture recognizer's translation to {0, 0} after applying so the next callback is a delta from the current position
- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{
	
    if ([delegate respondsToSelector:@selector(willPanPiece:inView:)]) {
		if (![delegate willPanPiece:gestureRecognizer inView:self]) {
			return;
		}	
	}
    
	// nur für CardEdit.lock
	UIView *piece = [gestureRecognizer view];
    
	
	[self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
	
    
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }


	
  }

// rotate the piece by the current rotation
// reset the gesture recognizer's rotation to 0 after applying so the next callback is a delta from the current rotation
- (void)rotatePiece:(UIRotationGestureRecognizer *)gestureRecognizer
{


//    if ([delegate respondsToSelector:@selector(willRotatePiece:inView:)]) {
//		[delegate willRotatePiece:gestureRecognizer inView:self];
//	}
	
//	EditableView *piece = (EditableView*)[gestureRecognizer view];
//	if (piece.locked) {
//		return;
//	}
	
	[self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformRotate([[gestureRecognizer view] transform], [gestureRecognizer rotation]);
        [gestureRecognizer setRotation:0];

    }
    
    
}

// scale the piece by the current scale
// reset the gesture recognizer's rotation to 0 after applying so the next callback is a delta from the current scale
- (void)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer
{


//	if ([delegate respondsToSelector:@selector(willScalePiece:inView:)]) {
//		[delegate willScalePiece:gestureRecognizer inView:self];
//	}
    
//	EditableView *piece = (EditableView*)[gestureRecognizer view];
//	if (piece.locked) {
//		return;
//	}
	
	[self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
		
		
        [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
        [gestureRecognizer setScale:1];

    }
}

- (void)handleTap:(UITapGestureRecognizer*)gesture{
	
}

- (void)handleDoubleTap:(UITapGestureRecognizer*)gesture{
    L();

	
}
- (void)handleLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer{
	if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
		
//        UIMenuController *menuController = [UIMenuController sharedMenuController];
//		
//		
//        CGPoint location = [gestureRecognizer locationInView:[gestureRecognizer view]];
        
        [self becomeFirstResponder];
		
//		selectedPiece = (EditableView*)[gestureRecognizer view];
//		
//		[menuController setMenuItems:selectedPiece.menuArray];
//        [menuController setTargetRect:CGRectMake(location.x, location.y, 0, 0) inView:[gestureRecognizer view]];
//        [menuController setMenuVisible:YES animated:YES];
        
    }
}


#pragma mark - Menu


- (void)menuLockPiece:(UIMenuController *)controller{
	
	if ([delegate respondsToSelector:@selector(handleMenuAction:withPiece:)])
		[delegate handleMenuAction:MA_Lock withPiece:selectedPiece];
}

- (void)menuUnlockPiece:(UIMenuController *)controller{
//	L();
	
	if ([delegate respondsToSelector:@selector(handleMenuAction:withPiece:)])
		[delegate handleMenuAction:MA_Unlock withPiece:selectedPiece];

}

- (void)menuSetBackground:(UIMenuController *)controller{
	L();

	if ([delegate respondsToSelector:@selector(handleMenuAction:withPiece:)])
		[delegate handleMenuAction:MA_SetBG withPiece:selectedPiece];

}

- (void)menuEdit:(UIMenuController*)controller{
	L();
	
	if ([delegate respondsToSelector:@selector(handleMenuAction:withPiece:)])
		[delegate handleMenuAction:MA_Edit withPiece:selectedPiece];

}

@end
