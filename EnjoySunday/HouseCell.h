//
//  HouseCell.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^collectionCellButtonClickBlock)(NSInteger index , NSNumber *ID);


@interface HouseCell : UITableViewCell

@property (nonatomic, weak) NSArray * dataArray;

+(instancetype)houseCellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) collectionCellButtonClickBlock buttonClickBlock;

@end
