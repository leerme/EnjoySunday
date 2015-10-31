//
//  DetailBottomView.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/24.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "DetailBottomView.h"

@implementation DetailBottomView

+(id)detailBottomView
{
    return [[self alloc] init];
}

-(id)init
{
    if(self=[super init])
    {
        self.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-25, [UIScreen mainScreen].bounds.size.width, 25);
    }
    return self;
}

-(void)setModel:(DetailModel *)model
{
    _model=model;
    NSArray *array=@[model.likes_count,model.shares_count,model.comments_count];
    NSArray *a=@[@"喜欢：",@"分享：",@"评论："];
    CGFloat btnX=[UIScreen mainScreen].bounds.size.width/3;
    for (int i=0; i<array.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*btnX, 0, btnX, self.frame.size.height);
        [self addSubview:btn];
        btn.tag=i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=[UIColor whiteColor];
        [btn setTitle:[NSString stringWithFormat:@"%@%@",a[i],[array[i] stringValue]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.layer.borderWidth=0.3;
    }
}
-(void)btnClick:(UIButton *)btn
{
    NSLog(@"%ld",btn.tag);
    [self.delegate detailBottomViewWithIndex:btn.tag];
    
}
@end
