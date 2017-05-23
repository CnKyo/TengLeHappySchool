//
//  ViewController.m
//  TengleHappySchool
//
//  Created by mwi01 on 2017/5/23.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "ViewController.h"
#import "WKWebViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *mBtn = [UIButton new];
    mBtn.backgroundColor = [UIColor redColor];
    mBtn.frame = CGRectMake(100, 100, 100, 100);
    [mBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mBtn];
    
}
- (void)btnAction{
    WKWebViewController *web = [[WKWebViewController alloc] init];
    [web loadWebHTMLSring:@"index1"];
    [self.navigationController pushViewController:web animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
