//
//  SingleMainCell.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "SingleMainCell.h"
#import "UIImageView+WebCache.h"
#import "UITableViewCell+initcell.h"

@interface SingleMainCell ()

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftLikeCountLabel;

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *rightNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLickCountLabel;

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@end


@implementation SingleMainCell

+(instancetype)singleMainCellWithTableView:(UITableView *)tableView
{
    return [self cellWithTableView:tableView];
}



- (void)awakeFromNib {
    
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTap:)];
    [self.leftView addGestureRecognizer:leftTap];
    
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTap:)];
    [self.rightView addGestureRecognizer:rightTap];
}
- (void)leftTap:(UITapGestureRecognizer *)tap
{
    if (self.imageClickBlock) {
        self.imageClickBlock(self.leftModel.ID);
    }
}
- (void)rightTap:(UITapGestureRecognizer *)tap
{
    if (self.imageClickBlock) {
        self.imageClickBlock(self.rightModel.ID);
    }
}

- (void)setLeftModel:(SingleMainModel *)leftModel
{
    _leftModel = leftModel;
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftModel.cover_image_url]];
    self.leftNameLabel.text = leftModel.name;
    self.leftPriceLabel.text = [NSString stringWithFormat:@"￥%@",leftModel.price];
    self.leftLikeCountLabel.text = [leftModel.favorites_count stringValue];
}


- (void)setRightModel:(SingleMainModel *)rightModel
{
    _rightModel = rightModel;
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightModel.cover_image_url]];
    self.rightNameLabel.text = rightModel.name;
    self.rightPriceLabel.text = [NSString stringWithFormat:@"￥%@",rightModel.price];
    self.rightLickCountLabel.text = [rightModel.favorites_count stringValue];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
