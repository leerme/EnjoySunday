//
//  SingleMainCell.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleMainModel.h"


typedef void(^singleMainCellImageClickBlock)(NSNumber *ID);

@interface SingleMainCell : UITableViewCell

@property (nonatomic, strong)SingleMainModel *leftModel;
@property (nonatomic, strong)SingleMainModel *rightModel;

@property (nonatomic, copy)singleMainCellImageClickBlock imageClickBlock;

+(instancetype)singleMainCellWithTableView:(UITableView *)tableView;

@end
