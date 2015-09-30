//
//  LeftViewController.m
//  侧滑
//
//  Created by qf on 9/21/15.
//  Copyright (c) 2015 Chakery. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftTableViewCell.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --- 设置tableView
-(void)setTableview{
    _tableview = [[UITableView alloc]init];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.bounces = NO;
    _tableview.showsHorizontalScrollIndicator = NO;
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.translatesAutoresizingMaskIntoConstraints = NO;
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    //约束
    NSArray *tableArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableview]-0-|" options:0 metrics:nil views:@{@"_tableview":_tableview}];
    [self.view addConstraints:tableArray];
    tableArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-104-[_tableview]-0-|" options:0 metrics:nil views:@{@"_tableview":_tableview}];
    [self.view addConstraints:tableArray];
    
}

#pragma mark --- tableView协议（显示cell）
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LeftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.showRadius = _showRadius;
    if (_items.count > 0) {
        [cell setCellWithItem:_items[indexPath.row]];
    }
    return cell;
}

#pragma mark --- tableView协议（行数）
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

#pragma mark --- tableView协议（行高）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark --- tableView协议（选中）
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CGYViewControllerClickNotification" object:[NSString stringWithFormat:@"%ld", indexPath.row]];
    
}

@end
