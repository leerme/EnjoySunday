//
//  SearchCollectionViewCell.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/27.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SundayContentModel.h"
@interface SearchCollectionViewCell : UICollectionViewCell

@property(nonatomic)SearchModel *model;
+(id)searchCollectionViewCellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath;

@end
