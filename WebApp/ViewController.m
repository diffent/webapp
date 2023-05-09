//
//  ViewController.m
//
//  Created by bk on 3/8/23.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString * mainBundlePath = [[NSBundle mainBundle] bundlePath];
    
    NSString * topPath = [mainBundlePath stringByAppendingString:@"/web/index.html"];
    
     self.webView.navigationDelegate = self;
     self.webView.UIDelegate = self;
     [self.webView.configuration.preferences setValue:@"TRUE" forKey:@"allowFileAccessFromFileURLs"];
     NSURL *url = [NSURL fileURLWithPath:topPath];
     
     UIView * v = self.view;
     
     [self.webView loadFileURL:url allowingReadAccessToURL:url.URLByDeletingLastPathComponent];
    [self.view addSubview:self.webView];
    
    self.webView.scrollView.scrollEnabled = NO;
    
    self.webView.scrollView.delegate = self;
        
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    printf("did scroll offset %f %f\n", scrollView.contentOffset.x, scrollView.contentOffset.y);
    
    CGPoint contentOffset;
    contentOffset.x = 0;
    contentOffset.y = 0;
    scrollView.contentOffset = contentOffset; // a big ole FU to them
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return nil;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler
{
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        if (navigationAction.request.URL) {
            NSLog(@"%@", navigationAction.request.URL.host);
            if (true || ![navigationAction.request.URL.resourceSpecifier containsString:@"ex path"]) {
                if ([[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL]) {
                    [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
                    decisionHandler(WKNavigationActionPolicyCancel);
                }
            } else {
                decisionHandler(WKNavigationActionPolicyAllow);
            }
        }
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

@end
