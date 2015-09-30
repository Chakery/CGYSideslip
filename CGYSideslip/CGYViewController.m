//
//  CGYViewController.m
//  侧滑
//
//  Created by qf on 9/21/15.
//  Copyright (c) 2015 Chakery. All rights reserved.
//

#import "CGYViewController.h"
#import "LeftViewController.h"

@interface CGYViewController ()
@property (nonatomic, strong) UIViewController *tempViewController;//临时保存当前的VC
@property (nonatomic, strong) LeftViewController *leftViewController;
@property (nonatomic, strong) UIViewController *mainViewController;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *views;
@end

@implementation CGYViewController

#pragma mark --- 注册通知
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationChange:) name:@"CGYViewControllerClickNotification" object:nil];
}

-(instancetype)initWithLeftItem:(NSArray *)itemArray withViewControllers:(NSArray *)viewControllerArray{
    if (self = [super init]) {
        _items = itemArray;
        _views = viewControllerArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMainView];
    [self setLeftView];
    [self setGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --- 主vc
-(void)setMainView{
    _mainViewController = [[UIViewController alloc]init];
    _mainViewController.view.frame = (CGRect){0,0,self.view.frame.size.width,self.view.frame.size.height};
    _mainViewController.view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_mainViewController.view];
    [self addChildViewController:_mainViewController];
    
    //默认显示第一个页面
    if (_views.count > 0) {
        [_mainViewController addChildViewController:_views[0]];
        [_mainViewController.view addSubview:[_views[0] view]];
    }
}

#pragma mark --- 左侧vc
-(void)setLeftView{
    _leftViewController = [[LeftViewController alloc]init];
    _leftViewController.view.frame = (CGRect){-240,0,240,self.view.frame.size.height};
    if (_leftViewColor) {
        _leftViewController.view.backgroundColor = _leftViewColor;
    } else {
        _leftViewController.view.backgroundColor = [UIColor colorWithRed:67.0/255 green:173.0/255 blue:250.0/255 alpha:1];
    }
    if (_items.count > 0) {
        _leftViewController.items = _items;
    }
    _leftViewController.showRadius = _showRadius;
    [self.view addSubview:_leftViewController.view];
    [self addChildViewController:_leftViewController];
    [self.view bringSubviewToFront:_leftViewController.view];
} 

#pragma mark --- 手势
-(void)setGestureRecognizer{
    UISwipeGestureRecognizer *showSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showLeftView)];
    [_mainViewController.view addGestureRecognizer:showSwipe];
    UISwipeGestureRecognizer *hiddenSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenLeftView)];
    hiddenSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [_mainViewController.view addGestureRecognizer:hiddenSwipe];
    UITapGestureRecognizer *mainTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenLeftView)];
    [_mainViewController.view addGestureRecognizer:mainTap];
}

#pragma mark --- 显示左侧
-(void)showLeftView{
    //显示遮罩
    [self showViewMask];
    
    [UIView animateWithDuration:0.3 animations:^{
        //左侧向右推
        CGRect r = _leftViewController.view.frame;
        r.origin.x = 0;
        r.size.width = 250;
        _leftViewController.view.frame = r;
        
        //显示阴影
        [self showViewShadow];
        
        //主VC向右推
        if (!_fixMainView) {
            CGRect r2 = _mainViewController.view.frame;
            r2.origin.x = 250;
            _mainViewController.view.frame = r2;
        }
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            //左侧向右推
            CGRect r = _leftViewController.view.frame;
            r.origin.x = 0;
            r.size.width = 230;
            _leftViewController.view.frame = r;
            
            //主VC向右推
            if (!_fixMainView) {
                CGRect r2 = _mainViewController.view.frame;
                r2.origin.x = 230;
                _mainViewController.view.frame = r2;
            }
        } completion:^(BOOL finished) {
            //左侧向右推
            CGRect r = _leftViewController.view.frame;
            r.origin.x = 0;
            r.size.width = 240;
            _leftViewController.view.frame = r;
            
            //主VC向右推
            if (!_fixMainView) {
                CGRect r2 = _mainViewController.view.frame;
                r2.origin.x = 240;
                _mainViewController.view.frame = r2;
            }
        }];
    }];
}

#pragma mark --- 隐藏左侧
-(void)hiddenLeftView{
    [UIView animateWithDuration:0.3 animations:^{
        //还原左侧
        CGRect r = _leftViewController.view.frame;
        r.origin.x = -240;
        _leftViewController.view.frame = r;
        
        //隐藏阴影
        [self hiddenViewShadow];
        
        //还原主vc
        if (!_fixMainView) {
            CGRect r2 = _mainViewController.view.frame;
            r2.origin.x = 0;
            _mainViewController.view.frame = r2;
        }
        
        //隐藏遮罩
        [self hiddenViewMask];
    }];
}

#pragma mark --- 通知
-(void)notificationChange:(NSNotification *)notification{
    //隐藏左侧栏
    [self hiddenLeftView];
    //移除之前的vc
    if (_tempViewController) {
        [_tempViewController.view removeFromSuperview];
        [_tempViewController removeFromParentViewController];
        _tempViewController = nil;
    }
    //创建需要显示的vc
    int index = [notification.object intValue];
    _tempViewController = _views[index];
    [_mainViewController.view addSubview:[_views[index] view]];
    [_mainViewController addChildViewController:_views[index]];
}

#pragma mark --- 显示阴影
-(void)showViewShadow{
    if (_showShadow) {
        _leftViewController.view.layer.shadowColor = [[UIColor blackColor]CGColor];
        _leftViewController.view.layer.shadowOffset = (CGSize){2, 2};
        _leftViewController.view.layer.shadowOpacity = 0.2;
        _leftViewController.view.layer.shadowRadius = 4;
    }
}

#pragma mark --- 隐藏阴影
-(void)hiddenViewShadow{
    if (_showShadow) {
        _leftViewController.view.layer.shadowColor = [[UIColor clearColor]CGColor];
        _leftViewController.view.layer.shadowOffset = (CGSize){0, 0};
        _leftViewController.view.layer.shadowOpacity = 0;
        _leftViewController.view.layer.shadowRadius = 0;
    }
}

#pragma mark --- 显示遮罩
-(void)showViewMask{
    if (_showMask) {
        UIView *maskView = [[UIView alloc]init];
        maskView.frame = _mainViewController.view.bounds;
        maskView.tag = 2000;
        maskView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
        [_mainViewController.view addSubview:maskView];
    }
}

#pragma mark --- 隐藏遮罩
-(void)hiddenViewMask{
    if (_showMask) {
        UIView *maskView = (UIView *)[_mainViewController.view viewWithTag:2000];
        [maskView removeFromSuperview];
    }
}

@end
