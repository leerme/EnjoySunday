//
//  CollectionCell.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "CollectionCell.h"
#import "ClassifyModel.h"
#import "UIButton+WebCache.h"
#import "Masonry.h"


@interface CollectionCell ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *buttonArray;
@end


@implementation CollectionCell

+(instancetype)collectionCellWithTableView:(UITableView *)tableView
{
    NSString * className = NSStringFromClass([self class]);
    
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    
    //如果有可重用的返回,如果没有可重用的创建一个新的返回
    return [tableView dequeueReusableCellWithIdentifier:className];
}

- (void)awakeFromNib {
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator  = NO;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    NSMutableArray *buttonArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    
    for (NSInteger i = 0 ; i < dataArray.count; i++) {
        
        CollectionsModel *data = dataArray[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.layer.cornerRadius = 10;
        button.clipsToBounds = YES;
        
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:data.banner_image_url] forState:UIControlStateNormal];
        
        [self.scrollView addSubview:button];
        
        [buttonArray addObject:button];
        
        [button addTarget:self action:@selector(sectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    self.buttonArray = buttonArray;
    for (NSUInteger i = 0 ; i < buttonArray.count ; i++ )
    {
        UIButton *button = self.buttonArray[i];
        UIButton * lastButton = i==0?nil:self.buttonArray[i-1];


        if (!lastButton) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.scrollView.mas_top);
                make.left.equalTo(self.scrollView.mas_left).offset(10);
                make.width.equalTo(@(150));
                make.height.equalTo(@(80));
            }];
        }
        else {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastButton.mas_top);
                make.left.equalTo(lastButton.mas_right).offset(10);
                make.width.equalTo(@(150));
                make.height.equalTo(@(80));
            }];
        }
    }
    self.scrollView.contentSize = CGSizeMake(650, 78);
}

- (void)sectionButtonClicked:(UIButton *)button
{
    CollectionsModel *data = self.dataArray[button.tag];
    
    [self.delegate collectionCellButtonClickWithIndex:button.tag withID:data.ID];
}

- (IBAction)modeButtonClicked:(id)sender {
    
    [self.delegate collectionCellButtonClickWithIndex:10 withID:@(100)];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


@end
