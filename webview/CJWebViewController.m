//
//  CJWebViewController.m
//  CJAdveriseDemo
//
//  Created by chenjie on 16/8/15.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJWebViewController.h"

@interface CJWebViewController()

@end

@implementation CJWebViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"CJWebViewController--%@",self.url);
    
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-64)];
    webView.backgroundColor = [UIColor yellowColor];
    webView.scalesPageToFit = YES;
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 20, 50, 50);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)btnClick:(UIButton *)button{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

@end
