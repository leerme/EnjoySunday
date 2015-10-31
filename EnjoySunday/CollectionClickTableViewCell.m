//
//  CollectionClickTableViewCell.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "CollectionClickTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface CollectionClickTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation CollectionClickTableViewCell

+(instancetype)collectionClickCellWithTableView:(UITableView *)tableView
{
    NSString * className = NSStringFromClass([self class]);
    
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    //如果有可重用的返回,如果没有可重用的创建一个新的返回
    return [tableView dequeueReusableCellWithIdentifier:className];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(ClassifyClickModel *)model
{
    _model = model;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    [self.likeButton setTitle:[model.likes_count stringValue] forState:UIControlStateNormal];
    [self.titleLabel setText:model.title];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
