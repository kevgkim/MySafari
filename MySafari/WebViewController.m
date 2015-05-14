//
//  ViewController.m
//  MySafari
//
//  Created by Kevin on 5/13/15.
//  Copyright (c) 2015 Kevin. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *networkActivityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.scrollView.delegate = self;
// WHAT IS THIS ABOVE CODE SAYING?

//    self.title = @"wuttup";


}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.networkActivityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.networkActivityIndicator stopAnimating];
    self.networkActivityIndicator.hidden = true;
    if ([self.webView canGoBack]) {
        self.backButton.enabled = YES;
    } else {
        self.backButton.enabled = NO;
    }
    if ([self.webView canGoForward]) {
        self.forwardButton.enabled = YES;
    } else {
        self.forwardButton.enabled = NO;
    }
//  This is to set the navigation bar title = current webpage
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navBar.title = title;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    

//    WHAT IS RESIGNFIRSTRESPONDER?
    [textField resignFirstResponder];
   [self loadRequestWithText:textField.text];
    return YES;
}
- (IBAction)onBackButtonPressed:(UIButton *)sender {
    [self.webView goBack];

}
- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    [self.webView goForward];
}
- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {
    [self.webView stopLoading];
}
- (IBAction)onReloadButtonPressed:(UIButton *)sender {
    [self.webView reload];
}

-(void)loadRequestWithText: (NSString *)text {
    if ([text containsString:@"http://"]) {
//    WHY NO STATEMENT AFTER IF?
//        WHY CAN'T I GET THE HTTP TO SET?
    } else {
        text = [NSString stringWithFormat:@"http://%@", text];
    }
    NSURL *url = [NSURL URLWithString:text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
- (IBAction)onNewFeatureButtonPressed:(UIButton *)sender {

    UIAlertView *alertView = [[UIAlertView alloc]init];
    alertView.title = @"Coming soon!";
    [alertView addButtonWithTitle:@"Nice"];
    [alertView show];
    alertView.delegate = self;
//    WHAT IS THIS ABOVE CODE SAYING?
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
        NSLog(@"Bottom reached");

    }

    if(scrollView.contentOffset.y <= 0.0) {
        NSLog(@"Top reached");
    }

}


@end
