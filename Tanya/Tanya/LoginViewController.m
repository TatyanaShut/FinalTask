//
//  LoginViewController.m
//  FinalTask
//
//  Created by Tatyana Shut on 20.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "LoginViewController.h"
#import "AccessToken.h"
#import "ViewController.h"


@interface LoginViewController () <UIWebViewDelegate>
@property (nonatomic, copy) LoginCompleytionBlock completionBlock;
@property(nonatomic,assign) UIWebView *webView;
@end

@implementation LoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlRequest = [[NSString alloc]initWithFormat:@"https://unsplash.com/oauth/authorize?client_id=9332410230f83ee1f35c5b4d9acedc94b3686e1dfd51faf93fd58005b4a961e8&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=public&response_type=code"];
    }
    return self;
}
- (id) initWithCompletionBlock:(void(^)(AccessToken *token)) completionBlock; {
    
    self = [super init];
    if (self) {
        self.completionBlock = completionBlock;
    }
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"Login";
    CGRect r = self.view.bounds;
    r.origin = CGPointZero;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:r];
    [self.view addSubview:webView];
    self.webView  = webView;
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
   
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
    
    
    NSURL *url= [NSURL URLWithString:self.urlRequest];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView.delegate = self;
    [webView loadRequest: request];
}
- (void) donePointAction {
    ViewController *vc = [[ViewController alloc]init];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                         [self.navigationController pushViewController:vc animated:NO];
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                     }];
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if([[request URL] absoluteString].length == 113){

        AccessToken *token = [[AccessToken alloc]init];
        NSString *query = [[request URL] description];
        NSArray *array = [query componentsSeparatedByString:@"?"];
    
        if([array count] >1){
            query = [array lastObject];
        }
        NSArray *value = [query componentsSeparatedByString:@"="];
        token.token = [value lastObject];
        self.webView.delegate = nil;
        if(self.completionBlock) {
            self.completionBlock(token);
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            ViewController *vc = [[ViewController alloc]init];
            [UIView animateWithDuration:0.75
                             animations:^{
                                 [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                                 [self.navigationController pushViewController:vc animated:NO];
                                 [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                             }];
        });
        
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePointAction)];
    }

    return YES;
}
@end

