//
//  ViewController.m
//  CJAdveriseDemo
//
//  Created by chenjie on 16/8/11.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ViewController.h"
#import "CJAdverisementView.h"
#import "CJWebViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * adverises = @[@"welcome_0.png",@"welcome_1.png",@"welcome_2.png",@"welcome_3.png"];
    
    CJAdverisementView * adverisement = [CJAdverisementView shareAdverise];
    adverisement.frame = self.view.frame;
    adverisement.numOfAdverises = adverises;
    [self.view addSubview:adverisement];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tapWedViewAdverise:) name:@"tapImageView" object:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)tapWedViewAdverise:(NSNotification *)notification{
    NSArray * array = @[@"http://www.baidu.com",@"http://www.sina.com.cn",@"http://www.youku.com",@"http://www.tudou.com"];
    NSLog(@"%@",notification.userInfo);
    NSDictionary * dictionary = notification.userInfo;
    NSInteger index = [dictionary[@"tapNum"] integerValue];
    
    CJWebViewController * webViewController = [[CJWebViewController alloc]init];
    webViewController.url = array[index];
    [self presentViewController:webViewController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
