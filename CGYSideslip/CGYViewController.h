//
//  CGYViewController.h
//  侧滑
//
//  Created by qf on 9/21/15.
//  Copyright (c) 2015 Chakery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftItem.h"

@interface CGYViewController : UIViewController
@property (nonatomic, assign) BOOL fixMainView;//住视图是否跟着推动
@property (nonatomic, assign) BOOL showShadow;//是否显示阴影
@property (nonatomic, assign) BOOL showMask;//是否显示遮罩
@property (nonatomic, strong) UIColor *leftViewColor;//左边视图的背景颜色
@property (nonatomic, assign) BOOL showRadius;//是否显示左侧视图图片圆角

-(instancetype)initWithLeftItem:(NSArray *)itemArray withViewControllers:(NSArray *)viewControllerArray;

@end
