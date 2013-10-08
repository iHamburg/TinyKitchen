//
//  MyStoreObserver.m
//  SignatureN
//
//  Created by fanshao on 09-9-1.
//  Copyright 2009 Sensky. All rights reserved.
//

#import "MyStoreObserver.h"
#import "RootViewController.h"

@implementation MyStoreObserver


@synthesize delegate;

+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	
	return sharedInstance;
	
}

- (id)init{
	if (self = [super init]) {
		[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
	}
	return self;
}


- (void) requestProductWithIdendifier:(NSString*)iden delegate:(id<IAPDelegate>)_delegate{
	
	L();
	SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers: [NSSet setWithObject: iden]];
    
    request.delegate = self;
	[request start];
	delegate = _delegate;
}

- (void) checkRestoredItemsWithDelegate:(id<IAPDelegate>)_delegate{
	delegate = _delegate;
	[[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}



#pragma mark - UIALertView
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
	NSLog(@"button:%d",buttonIndex);

		if (buttonIndex == 1) { 
			NSLog(@"buy");
			[[LoadingView sharedLoadingView] addInView:[delegate viewForLoading]];
			[self requestProductWithIdendifier:kIAPFullVersion delegate:delegate];
			
		}
		else if(buttonIndex == 2){ // restore
			NSLog(@"restore");
			[[LoadingView sharedLoadingView] addInView:[delegate viewForLoading]];
			[self checkRestoredItemsWithDelegate:delegate];
			
		}

//	NSLog(@"end of alert in Mystore");
}



#pragma mark - Product Request

/*
 only one iap at a time
 */
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
	
	NSArray *myProduct = response.products;
	NSLog(@"the count of products is %d", [myProduct count]);
	// populate UI
    
	//	for(SKProduct *product in myProduct){
	//        NSLog(@"Product title: %@" , product.localizedTitle);
	//        NSLog(@"Product description: %@" , product.localizedDescription);
	////        NSLog(@"Product price: %@" , product.localizedPrice);
	//        NSLog(@"Product id: %@" , product.productIdentifier);
	//		
	//	}
	
	if (ISEMPTY(myProduct)) {
		[[LoadingView sharedLoadingView]removeView];		
		return;
	}
    SKProduct *product = [myProduct objectAtIndex:0];
	NSLog(@"Product id: %@" , product.productIdentifier);
	
	SKPayment *payment = [SKPayment paymentWithProduct:product];
	
	[[SKPaymentQueue defaultQueue] addPayment:payment];
	
	
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
	[[LoadingView sharedLoadingView] removeView];
	
    NSLog(@"did fail Request,%@",[error localizedDescription]);
	UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@"Alert" message:[error localizedDescription] delegate:nil cancelButtonTitle:NSLocalizedString(@"Close",nil) otherButtonTitles:nil];
	
	[alerView show];
}



#pragma mark - Store Response


- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
	L();
	for (SKPaymentTransaction* transaction in transactions)
	{
		
		switch (transaction.transactionState)
		{
			case SKPaymentTransactionStatePurchased:
				//NSLog(@"Complete Transaction");
				[self completeTransaction:transaction];
				break;
			case SKPaymentTransactionStateFailed:
				//   NSLog(@"State Failed");
				[self failedTransaction:transaction];
				break;
			case SKPaymentTransactionStateRestored:
                NSLog(@"state restored");
				[self restoreTransaction:transaction];
				break;
			default:
				//                NSLog(@"unknown state");
				break;
		}
	}
	
	[[LoadingView sharedLoadingView] removeView];
}



- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue{
	
	
    L();
//	[[LoadingView sharedLoadingView] removeFromSuperview];
//	purchasedItemIDs = [[NSMutableArray alloc] init];
//	
//	NSLog(@"received restored transactions: %i", queue.transactions.count);
//	
//	//只有一个iap
//	if (queue.transactions.count == 0) {
//		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:LString(@"Warning") message:LString(@"No item restored") delegate:nil cancelButtonTitle:LString(@"Cancel") otherButtonTitles: nil];
//		[alert show];
//	}
//	
//	

	[[LoadingView sharedLoadingView] removeFromSuperview];
	//	purchasedItemIDs = [[NSMutableArray alloc] init];
	
	NSLog(@"received restored transactions: %i", queue.transactions.count);
	
	//只有一个iap
	if (queue.transactions.count == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:LString(@"Warning") message:LString(@"No item restored") delegate:nil cancelButtonTitle:LString(@"Cancel") otherButtonTitles: nil];
		[alert show];
	}
	else{
		[[RootViewController sharedInstance]IAPDidRestored];
	}
	

}

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    L();
	
	[[LoadingView sharedLoadingView] removeFromSuperview];
	
	NSLog(@"Error:%@\n%@",[error localizedDescription],[error localizedFailureReason]);
}



- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
   	
	[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    NSString *aidentifier = transaction.payment.productIdentifier;
	NSLog(@"Transaction complete id:%@",aidentifier);
	
	[[NSUserDefaults standardUserDefaults]setBool:YES forKey:aidentifier];
	
	[[NSUserDefaults standardUserDefaults]synchronize];
	
	[[RootViewController sharedInstance]IAPDidFinished:aidentifier];
	
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
	//[[NSNotificationCenter defaultCenter] postNotificationName:@"faliedTransaction" object:nil];
    
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        // Optionally, display an error here.
        [UIAlertView showAlert:@"Error" msg:@"Transaction failed! Please try it again later." cancel:@"Cancel"];
		
		NSLog(@"error:%@",[transaction.error localizedDescription]);
    }
    
    L();
	[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
	
    
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction{
	L();
	[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    NSString *iden = transaction.payment.productIdentifier;
	NSLog(@"Transaction restored id:%@",iden);
	
	[[NSUserDefaults standardUserDefaults]setBool:YES forKey:iden];
	
	[[NSUserDefaults standardUserDefaults]synchronize];
}


#pragma mark - Public

- (void) showFullVersionAlert{
	identifier = kIAPFullVersion;
	delegate = nil;
	
	if (!fullVersionAlert) {

		fullVersionAlert = [[UIAlertView alloc]initWithTitle:isPad?SIAPTitlePad:nil message:isPad?SIAPMsgPad:SIAPMsgPhone delegate:self cancelButtonTitle:LString(@"Cancel") otherButtonTitles:LString(@"Buy"),LString(@"Restore"), nil];
		
	}
	[fullVersionAlert show];
}


@end
