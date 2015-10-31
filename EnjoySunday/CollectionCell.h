//
//  CollectionCell.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionCellDelegate <NSObject>

- (void)collectionCellButtonClickWithIndex:(NSInteger) index withID :(NSNumber *)ID;

@end

@interface CollectionCell : UITableViewCell

@property (nonatomic, weak) NSArray * dataArray;
@property (nonatomic, weak) id<CollectionCellDelegate> delegate;
+(instancetype)collectionCellWithTableView:(UITableView *)tableView;

@end
