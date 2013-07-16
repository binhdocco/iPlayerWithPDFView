//
//  ViewController.h
//  iPlayer
//
//  Created by binhdocco on 10/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIWebView() 
    - (void) _setWebGLEnabled: (BOOL)newValue;
@end


@interface ViewController : UIViewController <UIWebViewDelegate> {

    IBOutlet UIButton *closeBtn;
    IBOutlet UIWebView *pdfview;
    IBOutlet UIWebView *webview;
}

@property(nonatomic, retain) IBOutlet UIWebView *webview;
@property(nonatomic, retain) IBOutlet UIWebView *pdfview;
@property(nonatomic, retain) IBOutlet UIButton *closeBtn;
- (IBAction)closePdf:(id)sender;

- (void) loadPdf: (NSString *) pdfPath;
- (NSString *) getAppPath;
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

@end
