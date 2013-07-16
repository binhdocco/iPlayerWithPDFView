//
//  ViewController.m
//  iPlayer
//
//  Created by binhdocco on 10/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController
@synthesize webview;
@synthesize pdfview;
@synthesize closeBtn;

- (IBAction)closePdf:(id)sender {
    [pdfview setHidden:YES];
    [webview setHidden:NO];
    [closeBtn setHidden:YES];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval: 10.0];
	[pdfview loadRequest:request];
}

- (void) loadPdf: (NSString *) pdfUrl {
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:pdfUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval: 10.0];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:pdfUrl]];
    [pdfview loadRequest:request];
}

- (NSString *) getAppPath {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"app_data"];
    //path = [path stringByAppendingString:@"/app_path/"];
    return path;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    webview.allowsInlineMediaPlayback = TRUE;
	webview.mediaPlaybackRequiresUserAction = FALSE;
    
    //enable webgl
    @try {
        id webDoc = [webview performSelector: @selector(_browserView)];
        id bwv = [webDoc performSelector: @selector(webView)];
        [bwv _setWebGLEnabled: YES];
        
    } @catch(NSException *e) {
        NSLog(@"WebGL not supported.");
    }
    //end enable
    
    [pdfview setHidden:YES];
    [closeBtn setHidden:YES];
    webview.delegate = self;
    
    NSString *url = [self getAppPath];
    //url = [url stringByAppendingString:@"index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval: 10.0];
     
    [webview loadRequest:request];
    NSLog(@"appPath: %@", url);
}

- (void)viewDidUnload
{
    pdfview = nil;
    closeBtn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.webview = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    return NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	NSString *path = [[[request URL] absoluteString] copy];
     NSLog(@"LOAD PAGE: %@", path);
    if ([[path lowercaseString] hasSuffix:@".pdf"]) {
        [self loadPdf:path];
        [webView setHidden:YES];
        [pdfview setHidden:NO];
        [closeBtn setHidden:NO];
     
     return FALSE;
     }
	
	//NSString *url = [[request URL] absoluteString];
	//urlField.text = url;
	return TRUE;
}

@end
