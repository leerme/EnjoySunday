//
//  SearchCollectionViewCell.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/27.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "SearchCollectionViewCell.h"
#import "UIKit+AFNetworking.h"
#import "NetInterface.h"
@interface SearchCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *zanLabel;



@end

@implementation SearchCollectionViewCell

+(id)searchCollectionViewCellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath
{
    NSString *className=NSStringFromClass([self class]);
    [collectionView registerNib:[UINib nibWithNibName:className bundle:nil] forCellWithReuseIdentifier:className];
    return [collectionView dequeueReusableCellWithReuseIdentifier:className forIndexPath:indexPath];
}

-(void)setModel:(SearchModel *)model
{
    [_titleView setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    
    _titleLabel.text=model.desc;
    
    _priceLabel.textColor=GLOBLE_COLOR;
    _priceLabel.text=[NSString stringWithFormat:@"￥%@",model.price];
    
    _zanLabel.text=[model.favorites_count stringValue];
}
@end
