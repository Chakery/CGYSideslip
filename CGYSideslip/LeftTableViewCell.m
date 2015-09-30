//
//  LeftTableViewCell.m
//  侧滑
//
//  Created by qf on 9/21/15.
//  Copyright (c) 2015 Chakery. All rights reserved.
//

#import "LeftTableViewCell.h"

@interface LeftTableViewCell ()
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *itemTitleLabel;
@end

@implementation LeftTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark --- 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self line];
        [self setMainView];
    }
    return self;
}

#pragma mark --- 主要UI
-(void)setMainView{
    //图片
    _headImageView = [[UIImageView alloc]init];
    _headImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_headImageView];
    NSArray *headArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_headImageView(36)]" options:0 metrics:nil views:@{@"_headImageView":_headImageView}];
    [self addConstraints:headArray];
    headArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[_headImageView(36)]" options:0 metrics:nil views:@{@"_headImageView":_headImageView}];
    [self addConstraints:headArray];
    
    //标题
    _itemTitleLabel = [[UILabel alloc]init];
    _itemTitleLabel.font = [UIFont systemFontOfSize:16];
    _itemTitleLabel.textColor = [UIColor whiteColor];
    _itemTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_itemTitleLabel];
    NSArray *titleArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_headImageView]-10-[_itemTitleLabel]-20-|" options:0 metrics:nil views:@{@"_itemTitleLabel":_itemTitleLabel,@"_headImageView":_headImageView}];
    [self addConstraints:titleArray];
    titleArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_itemTitleLabel(20)]" options:0 metrics:nil views:@{@"_itemTitleLabel":_itemTitleLabel}];
    [self addConstraints:titleArray];
}

#pragma mark --- 分割线
-(void)line{
    UIImageView *lineImageView = [[UIImageView alloc]init];
    lineImageView.backgroundColor = [UIColor whiteColor];
    lineImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lineImageView];
    NSArray *lineArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[lineImageView]-2-|" options:0 metrics:nil views:@{@"lineImageView":lineImageView}];
    [self addConstraints:lineArray];
    lineArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lineImageView(1)]-1-|" options:0 metrics:nil views:@{@"lineImageView":lineImageView}];
    [self addConstraints:lineArray];
}

#pragma mark --- 给UI赋值
-(void)setCellWithItem:(LeftItem *)item{
    if (item.image && ![item.image isEqualToString:@""]) {
        if (_showRadius) {
            _headImageView.layer.masksToBounds = YES;
            _headImageView.layer.cornerRadius = 18;
        }
        _headImageView.image = [UIImage imageNamed:item.image];
    } else {
        NSArray *titleArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_itemTitleLabel]-20-|" options:0 metrics:nil views:@{@"_itemTitleLabel":_itemTitleLabel}];
        [self addConstraints:titleArray];
    }
    _itemTitleLabel.text = item.name;
}

@end
