//
//  OutCell.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "OutCell.h"
#import "ClassifyModel.h"
#import "UIButton+WebCache.h"

@interface OutCell ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;



@end

@implementation OutCell


+(instancetype)outCellWithTableView:(UITableView *)tableView
{
    NSString * className = NSStringFromClass([self class]);
    
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    
    //如果有可重用的返回,如果没有可重用的创建一个新的返回
    return [tableView dequeueReusableCellWithIdentifier:className];
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    AllModel *model1 = dataArray[0];
    self.button1.tag = 0;
    [self.button1 sd_setBackgroundImageWithURL:[NSURL URLWithString:model1.icon_url] forState:UIControlStateNormal];
    
    AllModel *model2 = dataArray[1];
    self.button2.tag = 1;
    [self.button2 sd_setBackgroundImageWithURL:[NSURL URLWithString:model2.icon_url] forState:UIControlStateNormal];
    
    AllModel *model3 = dataArray[2];
    self.button3.tag = 2;
    [self.button3 sd_setBackgroundImageWithURL:[NSURL URLWithString:model3.icon_url] forState:UIControlStateNormal];
    
    AllModel *model4 = dataArray[3];
    self.button4.tag = 3;
    [self.button4 sd_setBackgroundImageWithURL:[NSURL URLWithString:model4.icon_url] forState:UIControlStateNormal];
    
    AllModel *model5 = dataArray[4];
    self.button5.tag = 4;
    [self.button5 sd_setBackgroundImageWithURL:[NSURL URLWithString:model5.icon_url] forState:UIControlStateNormal];
    
    AllModel *model6 = dataArray[5];
    self.button6.tag = 5;
    [self.button6 sd_setBackgroundImageWithURL:[NSURL URLWithString:model6.icon_url] forState:UIControlStateNormal];
    
}

- (IBAction)buttonClick:(UIButton *)sender {
    UIButton *button = (UIButton *)sender;
    AllModel *model = self.dataArray[button.tag];
    
    if (self.buttonClickBlock)
    {
        self.buttonClickBlock(button.tag,model.ID);
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
