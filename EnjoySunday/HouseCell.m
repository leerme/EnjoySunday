//
//  HouseCell.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "HouseCell.h"
#import "ClassifyModel.h"
#import "UIButton+WebCache.h"

@interface HouseCell ()

@property (weak, nonatomic) IBOutlet UIButton *diyButton;
@property (weak, nonatomic) IBOutlet UIButton *kitchenButton;
@property (weak, nonatomic) IBOutlet UIButton *movieButton;
@property (weak, nonatomic) IBOutlet UIButton *partyButton;


@end

@implementation HouseCell

+(instancetype)houseCellWithTableView:(UITableView *)tableView
{
    NSString * className = NSStringFromClass([self class]);
    
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    
    //如果有可重用的返回,如果没有可重用的创建一个新的返回
    return [tableView dequeueReusableCellWithIdentifier:className];
}

- (void)awakeFromNib {
    
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    AllModel *model1 = dataArray[0];
    self.diyButton.tag = 0;
    [self.diyButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model1.icon_url] forState:UIControlStateNormal];

    AllModel *model2 = dataArray[1];
    self.kitchenButton.tag = 1;
    [self.kitchenButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model2.icon_url] forState:UIControlStateNormal];
    
    AllModel *model3 = dataArray[2];
    self.movieButton.tag = 2;
    [self.movieButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model3.icon_url] forState:UIControlStateNormal];
    
    AllModel *model4 = dataArray[3];
    self.partyButton.tag = 3;
    [self.partyButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model4.icon_url] forState:UIControlStateNormal];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)DIYButtonClicked:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    AllModel *model = self.dataArray[button.tag];
    
    if (self.buttonClickBlock)
    {
        self.buttonClickBlock(button.tag,model.ID);
    }
}


@end
