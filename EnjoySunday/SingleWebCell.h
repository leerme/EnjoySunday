//
//  SingleWebCell.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/24.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleClickedModel.h"

@interface SingleWebCell : UITableViewCell


@property (nonatomic, strong) SingleClickedModel *model;

@property (nonatomic, copy) void(^singWebCellFinishLoadBlock)(CGFloat height);

@end
