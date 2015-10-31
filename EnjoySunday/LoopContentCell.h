//
//  LoopContentCell.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SundayContentModel.h"
@interface LoopContentCell : UITableViewCell

@property(nonatomic)LoopContentModel *model;

+(id)loopContentCellWithTableView:(UITableView *)tableView;

@end
