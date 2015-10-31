//
//  SingleCnotentCell.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/24.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleClickedModel.h"

@interface SingleCnotentCell : UITableViewCell

@property (nonatomic,strong) SingleClickedModel *model;

@property (nonatomic) CGFloat rowHeight;

+(instancetype)singleCnotentCellWithTableView:(UITableView *)tableView;

@end
