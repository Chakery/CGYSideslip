//
//  LeftTableViewCell.h
//  侧滑
//
//  Created by qf on 9/21/15.
//  Copyright (c) 2015 Chakery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftItem.h"

@interface LeftTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL showRadius;//是否显示左侧视图图片圆角
-(void)setCellWithItem:(LeftItem *)item;

@end
