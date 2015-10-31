//
//  SingleCnotentCell.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/24.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "SingleCnotentCell.h"
#import "UIButton+WebCache.h"
#import "UITableViewCell+initcell.h"
#import "NSString+Frame.h"

@interface SingleCnotentCell ()

@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelConstraintHeight;

@end

@implementation SingleCnotentCell

+(instancetype)singleCnotentCellWithTableView:(UITableView *)tableView
{
    return [self cellWithTableView:tableView];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(SingleClickedModel *)model
{
    _model = model;
    [self.iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.cover_image_url] forState:UIControlStateNormal];
    self.iconButton.userInteractionEnabled = NO;
    
    self.nameLabel.text = model.name;
    self.priceLabel.text = model.price;
    self.contentLabel.text = model.desc;
    
    float nameHeight = [self.model.name heightWithFont:[UIFont systemFontOfSize:17] withinWidth:self.bounds.size.width - 16];
    self.nameLabelConstraintHeight.constant = nameHeight;
    float contentHeight = [self.model.desc heightWithFont:[UIFont systemFontOfSize:17] withinWidth:self.bounds.size.width - 16];
    self.contentLabelConstraintHeight.constant = contentHeight;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
