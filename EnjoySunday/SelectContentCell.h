//
//  SelectContentCell.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SundayContentModel.h"
@interface SelectContentCell : UITableViewCell

@property(nonatomic)NSArray *model;
@property(nonatomic,copy) void(^imageClick)(SundayContentModel *);

+(id)selectContentCellWithTableView:(UITableView *)tableView;

@end
