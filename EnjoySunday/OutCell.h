//
//  OutCell.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^collectionCellButtonClickBlock)(NSInteger index , NSNumber *ID);

@interface OutCell : UITableViewCell

@property (nonatomic, weak) NSArray * dataArray;

@property (nonatomic, copy) collectionCellButtonClickBlock buttonClickBlock;

+(instancetype)outCellWithTableView:(UITableView *)tableView;

@end
