//
//  TwoViewController.m
//  侧滑
//
//  Created by qf on 9/21/15.
//  Copyright (c) 2015 Chakery. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    UILabel *label = [[UILabel alloc]initWithFrame:(CGRect){10, 100, 300, 20}];
    label.text = @"这里真的是第二个页面";
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
