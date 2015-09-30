//
//  ViewController.m
//  侧滑
//
//  Created by qf on 9/21/15.
//  Copyright (c) 2015 Chakery. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "CGYViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CGYViewController *slideslip;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //*******************************************************************
    //                              使用方法
    //*******************************************************************
    //  1.导入头文件 CGYViewController.h
    //  2.创建左边视图的item，需要传递 LeftItem 类
    //  3.创建需要切换的视图
    //  4.调用侧滑的初始化方法
    //  5.设置相关属性
    //  6.添加到当前视图上
    //    [self.view addSubview:_slideslip.view];
    //    [self addChildViewController:_slideslip];
    //*******************************************************************
    LeftItem *item1 = [[LeftItem alloc]init];
    item1.name = @"第一页";
    item1.image = @"lable_edit.png";
    LeftItem *item2 = [[LeftItem alloc]init];
    item2.name = @"第二页";
    item2.image = @"lable_share.png";
    
    OneViewController *one = [[OneViewController alloc]init];
    TwoViewController *two= [[TwoViewController alloc]init];
    
    _slideslip = [[CGYViewController alloc]initWithLeftItem:@[item1, item2] withViewControllers:@[one, two]];
    _slideslip.showShadow = YES;//是否显示阴影
    _slideslip.fixMainView = YES;//是否固定主视图
    _slideslip.showMask = YES;//是否显示遮罩
    _slideslip.showRadius = YES;//是否显示圆形图片
    [self.view addSubview:_slideslip.view];
    [self addChildViewController:_slideslip];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
