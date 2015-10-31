//
//  CollectionClickTableViewCell.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassifyClickModel.h"

@interface CollectionClickTableViewCell : UITableViewCell

@property (nonatomic, strong) ClassifyClickModel *model;

+(instancetype)collectionClickCellWithTableView:(UITableView *)tableView;

@end
