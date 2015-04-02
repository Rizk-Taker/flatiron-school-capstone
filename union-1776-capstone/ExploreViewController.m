//
//  ExploreViewController.m
//  union-1776-capstone
//
//  Created by Bert Carr on 4/1/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "ExploreViewController.h"

@interface ExploreViewController ()

- (IBAction)forwardTapped:(id)sender;
- (IBAction)backTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *UIForward;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *UIBack;

@end

@implementation ExploreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.UIBack.enabled = NO;
    [self.UIBack setTintColor:[UIColor clearColor]];
    self.UIForward.enabled = NO;
    [self.UIForward setTintColor:[UIColor clearColor]];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:self.webView];
    
    [self.webView setNavigationDelegate:self];
    [self.webView setUIDelegate:self];
    
    NSString *exploreURLString = [NSString stringWithFormat:@"http://dev.1776union.io/union/explore/index"];
    
    NSURL *exploreURL = [NSURL URLWithString:exploreURLString];
    
    NSURLRequest *exploreRequest = [NSURLRequest requestWithURL:exploreURL];
    
    [self.webView loadRequest:exploreRequest];
    
    [self.webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ( [keyPath isEqualToString:@"loading"] )
    {
        self.UIBack.enabled = self.webView.canGoBack;
        if (self.webView.canGoBack)
        {
            [self.UIBack setTintColor:[UIColor blueColor]];
        }
        else
        {
            [self.UIBack setTintColor:[UIColor clearColor]];
        }

        self.UIForward.enabled = self.webView.canGoForward;
        if (self.webView.canGoForward)
        {
            [self.UIForward setTintColor:[UIColor blueColor]];
        }
        else
        {
            [self.UIForward setTintColor:[UIColor clearColor]];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)forwardTapped:(id)sender
{
    if ([self.webView canGoForward])
    {
        [self.webView goForward];
    }
}

- (IBAction)backTapped:(id)sender
{
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }
}

@end