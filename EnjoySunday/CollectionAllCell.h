//
//  CollectionAllCell.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassifyModel.h"

@interface CollectionAllCell : UITableViewCell
@property (nonatomic ,strong) CollectionsModel *model;

+(instancetype)collectionAllCellWithTableView:(UITableView *)tableView;

@end
