//
//  CollectionAllCell.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "CollectionAllCell.h"
#import "UITableViewCell+initcell.h"
#import "UIImageView+WebCache.h"

@interface CollectionAllCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@end

@implementation CollectionAllCell

+(instancetype)collectionAllCellWithTableView:(UITableView *)tableView
{
    return [self cellWithTableView:tableView];
}

- (void)setModel:(CollectionsModel *)model
{
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    _title.text = model.title;
    _subTitle.text = model.subtitle;
}

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
