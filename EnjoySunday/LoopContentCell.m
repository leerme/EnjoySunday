//
//  LoopContentCell.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "LoopContentCell.h"
#import "UIKit+AFNetworking.h"
@interface LoopContentCell()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LoopContentCell

+(id)loopContentCellWithTableView:(UITableView *)tableView
{
    NSString *className=NSStringFromClass([self class]);
    [tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
}

-(void)setModel:(LoopContentModel *)model
{
    [self.image setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    self.image.layer.cornerRadius=3;
    self.image.clipsToBounds=YES;
    
    [self.zanButton setTitle:[model.likes_count stringValue] forState:UIControlStateNormal];
    self.zanButton.layer.cornerRadius=12.5;
    self.zanButton.clipsToBounds=YES;
    
    
    self.titleLabel.text=model.title;
    
}

- (IBAction)zanButtonClick:(id)sender {
    
    
}

@end
