//
//  TopNavView.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "TopNavView.h"
#import "NSString+Frame.h"
#import "Masonry.h"
#define btnW ([UIScreen mainScreen].bounds.size.width-75)/4

@interface TopNavView()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *topScrollView;
@property(nonatomic,strong)UIScrollView *contentScrollView;
@property(nonatomic,copy)NSMutableArray *labelArray;
@property(nonatomic)UIView *indicatorView;
@property(nonatomic) BOOL isClick;

@property(nonatomic)UIView *dropDownNavView;
@property(nonatomic)UIView *dropDownContentView;
@property(nonatomic)UILabel *label;
@property(nonatomic)UIButton *btn;
@property(nonatomic)NSMutableArray *selectBtnArray;
@property(nonatomic)NSMutableArray *noSelectBtnArray;

@end

@implementation TopNavView

+(id)topNavView
{
    return [[self alloc]init];
}

-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray=titleArray;
    _isClick=YES;
    _labelArray=[NSMutableArray array];

    _noSelectBtnArray=[NSMutableArray array];
    _selectBtnArray=[NSMutableArray array];
    CGFloat topX=0;
    CGFloat topY=0;
    CGFloat topW=[UIScreen mainScreen].bounds.size.width-40;
    CGFloat topH=40;
    
    _topScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(topX , topY, topW, topH)];
    [self addSubview:_topScrollView];
    _topScrollView.backgroundColor=[UIColor whiteColor];
    _topScrollView.showsHorizontalScrollIndicator=NO;

    for(int i=0;i<titleArray.count;i++)
    {
        UILabel *label=[[UILabel alloc] init];
        [_topScrollView addSubview:label];
        label.textColor=[UIColor grayColor];
        label.text=titleArray[i];
        label.font=[UIFont systemFontOfSize:15];
        label.userInteractionEnabled=YES;
        label.textAlignment=NSTextAlignmentCenter;
        label.tag=i;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClicked:)];
        [label addGestureRecognizer:tap];
        [_labelArray addObject:label];
        
    }
    UILabel *lastView;
    for (int i=0; i<_labelArray.count; i++) {
        UILabel *label=_labelArray[i];
        lastView= i>0? _labelArray[i-1]:nil;
        CGFloat labelW=[(NSString *)_titleArray[i] widthWithFont:[UIFont systemFontOfSize:15]];
        if(!lastView)
        {
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(10));
                make.top.equalTo(@(0));
                make.width.equalTo(@(labelW));
                make.height.equalTo(@(35));
            }];
        }else
        {
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastView.mas_right).offset(20);
                make.top.equalTo(@(0));
                make.width.equalTo(@(labelW));
                make.height.equalTo(@(35));
            }];
        }
    }
    
    _indicatorView=[[UIImageView alloc] initWithFrame:CGRectMake(10, topH-4, [(NSString *)_titleArray[0] widthWithFont:[UIFont systemFontOfSize:15]], 2)];
    [self.topScrollView addSubview:_indicatorView];
    _indicatorView.backgroundColor=GLOBLE_COLOR;
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame=CGRectMake(topW, 0, topH, topH);
    [self addSubview:rightButton];
    [rightButton setImage:[UIImage imageNamed:@"AppIcon29x29"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //rightImageView.image=[UIImage imageNamed:@"AppIcon29x29"];
    //设置scollView的contensize
    _topScrollView.contentSize=CGSizeMake(topW+10 , 0);
    UILabel *label = _labelArray[0];
    label.textColor=GLOBLE_COLOR;
    [self addDropDown];
   
}
-(void)addDropDown
{
    
    _dropDownNavView=[[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width-40, 0)];
    [self.superview addSubview:_dropDownNavView];
    _dropDownNavView.backgroundColor=[UIColor whiteColor];
    _label =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    [self.dropDownNavView addSubview:_label];
    _label.text=@"切换频道";
    _label.textColor=[UIColor lightGrayColor];
    _label.hidden=YES;
    _label.font=[UIFont systemFontOfSize:15];
    _btn=[UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-120, 0, 100, 40);
    [_btn setTitle:@"排序或删除" forState:UIControlStateNormal];
    [_btn setTitleColor:GLOBLE_COLOR forState:UIControlStateNormal];
    [self.dropDownNavView addSubview:_btn];
    _btn.titleLabel.font=[UIFont systemFontOfSize:15];
    _btn.hidden=YES;
    
    _dropDownContentView=[[UIView alloc] initWithFrame:CGRectMake(0, 40+64, [UIScreen mainScreen].bounds.size.width, 0)];
    _dropDownContentView.backgroundColor=[UIColor whiteColor];
    [self.superview addSubview:_dropDownContentView];
    
    CGFloat intorval=15;
    CGFloat y=0;
    CGFloat x=0;
    for(int i=0;i<_titleArray.count;i++)
    {
        y=i>3?50:10;
        x=i>3?intorval:i*(btnW+intorval)+intorval;
        UIButton *b=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.dropDownContentView addSubview:b];
        [b setTitle:_titleArray[i] forState:UIControlStateNormal];
        [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        b.titleLabel.font=[UIFont systemFontOfSize:15];
        b.layer.borderWidth=0.5;
        b.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [b addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        b.layer.cornerRadius=4;
        b.clipsToBounds=YES;
        b.frame=CGRectMake(x, y, btnW, 30);
        b.hidden=YES;
        [_selectBtnArray addObject:b];
    }
}

-(void)btnClick:(UIButton *)btn
{
    

}

-(void)rightButtonClick:(UIButton*)btn
{
    if(_isClick)
    {
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform=CGAffineTransformMakeRotation(M_PI);
            CGRect frame=_dropDownNavView.frame;
            frame.size.height=40;
            _dropDownNavView.frame=frame;
            _label.hidden=NO;
            _btn.hidden=NO;
           
        }];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame=_dropDownContentView.frame;
            frame.size.height=[UIScreen mainScreen].bounds.size.height-40;
            _dropDownContentView.frame=frame;
            for(int i=0;i<_selectBtnArray.count;i++)
            {
                UIButton *btn=(UIButton*)_selectBtnArray[i];
                btn.hidden=NO;
            }
        }];
    }else
    {
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform=CGAffineTransformMakeRotation(2*M_PI);
            CGRect frame=_dropDownNavView.frame;
            frame.size.height=0;
            _label.hidden=YES;
            _btn.hidden=YES;
            _dropDownNavView.frame=frame;
        
        }];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame=_dropDownContentView.frame;
            frame.size.height=0;
            _dropDownContentView.frame=frame;
            for(int i=0;i<_selectBtnArray.count;i++)
            {
                UIButton *btn=(UIButton*)_selectBtnArray[i];
                btn.hidden=YES;
            }
        }];
    }
    _isClick=!_isClick;
    
}

-(void)setViewArray:(NSArray *)viewArray
{
    _viewArray=viewArray;
    CGFloat contentX=0;
    CGFloat contentY=40;
    CGFloat contentW=self.frame.size.width;
    CGFloat contentH=self.frame.size.height-40;
    
    self.contentScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(contentX, contentY, contentW, contentH)];
    
    
    [self addSubview:self.contentScrollView];
    
    for(int i=0;i<viewArray.count;i++)
    {
        [self.contentScrollView addSubview:viewArray[i]];
        ((UIView *)viewArray[i]).frame=CGRectMake(i*contentW, 0, contentW, contentH);
    }
    self.contentScrollView.showsHorizontalScrollIndicator=NO;
    self.contentScrollView.pagingEnabled=YES;
    self.contentScrollView.contentSize=CGSizeMake(_viewArray.count*self.frame.size.width, 0);
    self.contentScrollView.delegate=self;
    [self bringSubviewToFront:_dropDownContentView];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x/self.frame.size.width;
    for (UILabel *label in _labelArray) {
        label.textColor=[UIColor grayColor];
    }
    UILabel *label=(UILabel *)_labelArray[index];
    label.textColor=GLOBLE_COLOR;
    if(label.tag>=2)
    {
        [UIView animateWithDuration:0.2 animations:^{
            _topScrollView.contentOffset=CGPointMake((label.tag-2) *label.frame.size.width, 0);
        }];
    }
    CGRect frame=_indicatorView.frame;
    frame.origin.x=label.frame.origin.x;
    frame.size.width=label.frame.size.width;
    [UIView animateWithDuration:0.2 animations:^{
        _indicatorView.frame=frame;
    }];
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x/self.frame.size.width;

    [self.delegate topNavViewWithTag:index];
}


-(void)labelClicked:(UITapGestureRecognizer *)tap
{
    for (UILabel *label in _labelArray) {
        label.textColor=[UIColor grayColor];
    }
    UILabel *label=(UILabel *)tap.view;
    label.textColor=GLOBLE_COLOR;
    
    if(label.tag>=2)
    {
        [UIView animateWithDuration:0.2 animations:^{
            _topScrollView.contentOffset=CGPointMake((label.tag-2) *label.frame.size.width, 0);
            
            
        }];
    }
    CGRect frame=_indicatorView.frame;
    frame.origin.x=label.frame.origin.x;
    frame.size.width=label.frame.size.width;
    [UIView animateWithDuration:0.2 animations:^{
        _indicatorView.frame=frame;
        
        self.contentScrollView.contentOffset=CGPointMake(label.tag*self.frame.size.width, 0);
    }];
    
    [self.delegate topNavViewWithTag:label.tag];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame=CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    
}


@end
