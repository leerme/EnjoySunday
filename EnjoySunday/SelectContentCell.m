//
//  SelectContentCell.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "SelectContentCell.h"
#import "UIKit+AFNetworking.h"
@interface SelectContentCell()
{
    BOOL  _one;
    BOOL  _two;
}
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;
@property (weak, nonatomic) IBOutlet UILabel *oneLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoLabel;
@property (weak, nonatomic) IBOutlet UIButton *oneZanBtn;

@property (weak, nonatomic) IBOutlet UIButton *twoZanBtn;

@property (weak, nonatomic) IBOutlet UILabel *oneZanLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoZanLabel;
@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *twoView;

@end

@implementation SelectContentCell

+(id)selectContentCellWithTableView:(UITableView *)tableView
{
    NSString *className=NSStringFromClass([self class]);
    [tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
}

-(void)setModel:(NSArray *)model
{
    _one=YES;
    _two=YES;
    _model=model;
    _oneView.layer.cornerRadius=14.5;
    _oneView.clipsToBounds=YES;
    
    _twoView.layer.cornerRadius=14.5;
    _twoView.clipsToBounds=YES;
    
  
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneImageClick:)];
    _oneImageView.userInteractionEnabled=YES;
    [_oneImageView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoImageClick:)];
    _twoImageView.userInteractionEnabled=YES;
    [_twoImageView addGestureRecognizer:tap1];
    if(model.count==1)
    {
        SundayContentModel *m=model[0];
        
       // [_oneZanBtn setTitle:[m.likes_count stringValue] forState:UIControlStateNormal];
        _oneImageView.image=nil;
        [_oneZanBtn setImage:[UIImage imageNamed:@"whiteFavourite"] forState:UIControlStateNormal];
        _oneZanLabel.text=[m.likes_count stringValue];
        _oneImageView.layer.cornerRadius=3;
        _oneImageView.clipsToBounds=YES;
        //NSLog(@"%@,%@",[self getDate:m.created_at], m.cover_image_url);
        [_oneImageView setImageWithURL:[NSURL URLWithString:m.cover_image_url]];
        
        self.dateLabel.text=[self getDate:m.created_at];
        
        _oneLabel.text=m.title;
        _twoImageView.hidden=YES;
        _twoLabel.hidden=YES;
        _twoZanBtn.hidden=YES;
        _twoZanLabel.hidden=YES;
        _twoView.hidden=YES;
        
    }else
    {
        _oneImageView.image=nil;
       // [_oneZanBtn setTitle:[((SundayContentModel*)model[1]).likes_count stringValue] forState:UIControlStateNormal];
        _oneImageView.layer.cornerRadius=3;
        _oneImageView.clipsToBounds=YES;
        [_oneImageView setImageWithURL:[NSURL URLWithString:((SundayContentModel*)model[1]).cover_image_url]];
        _oneZanLabel.text=[((SundayContentModel*)model[1]).likes_count stringValue];
        _oneLabel.text=((SundayContentModel*)model[1]).title;
        _twoImageView.hidden=NO;
        _twoLabel.hidden=NO;
        _twoZanBtn.hidden=NO;
        _twoZanLabel.hidden=NO;
        _twoView.hidden=NO;
        _twoImageView.image=nil;
        //[_oneZanBtn setTitle:[((SundayContentModel*)model[0]).likes_count stringValue] forState:UIControlStateNormal];
        _twoImageView.layer.cornerRadius=3;
        _twoImageView.clipsToBounds=YES;
        [_twoZanBtn setImage:[UIImage imageNamed:@"whiteFavourite"] forState:UIControlStateNormal];
        _twoZanLabel.text=[((SundayContentModel*)model[0]).likes_count stringValue];
        [_twoImageView setImageWithURL:[NSURL URLWithString:((SundayContentModel*)model[0]).cover_image_url]];
        _twoLabel.text=((SundayContentModel*)model[0]).title;
        self.dateLabel.text=[self getDate:((SundayContentModel*)model[0]).created_at];
    }
    
    
}

-(void)oneImageClick:(UITapGestureRecognizer *)tap
{
    SundayContentModel *model = [self.model lastObject];
    
    self.imageClick(model);
}

-(void)twoImageClick:(UITapGestureRecognizer *)tap
{
    SundayContentModel *model = [self.model firstObject];
    self.imageClick(model);
}
-(NSString *)getDate:(NSNumber *)num
{
    NSInteger time=[num integerValue];
    
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *f=[NSDateFormatter new];
    [f setDateFormat:@"MM d EEEE"];
    
    NSString *str=[f stringFromDate:date];
    NSArray *array=[str componentsSeparatedByString:@" "];
    
    NSString *d=[NSString stringWithFormat:@"%@月%@日 %@",array[0],array[1],[self getweek:array[2]]];
    return d;
}
- (IBAction)oneZanClick:(id)sender {
    if(_one)
    {
        [_oneZanBtn setImage:[UIImage imageNamed:@"redFavourite"] forState:UIControlStateNormal];
        int i=[((SundayContentModel*)[_model lastObject]).likes_count intValue];
        _oneZanLabel.text=[NSString stringWithFormat:@"%d",i+1];
    }else
    {
        [_oneZanBtn setImage:[UIImage imageNamed:@"whiteFavourite"] forState:UIControlStateNormal];
        _oneZanLabel.text=[((SundayContentModel*)[_model lastObject]).likes_count stringValue];
    }
    _one=!_one;
}

- (IBAction)twoZanClick:(id)sender {
    if(_two)
    {
        [_twoZanBtn setImage:[UIImage imageNamed:@"redFavourite"] forState:UIControlStateNormal];
        int i=[((SundayContentModel*)[_model firstObject]).likes_count intValue];
        _twoZanLabel.text=[NSString stringWithFormat:@"%d",i+1];
    }else
    {
        [_twoZanBtn setImage:[UIImage imageNamed:@"whiteFavourite"] forState:UIControlStateNormal];
         _twoZanLabel.text=[((SundayContentModel*)[_model firstObject]).likes_count stringValue];
    }
    _two=!_two;
}




-(NSString*)getweek:(NSString *)week
{
    NSString*weekStr=nil;
    if([week isEqualToString:@"Sunday"])
    {
        weekStr=@"星期天";
    }else if([week isEqualToString:@"Monday"]){
        weekStr=@"星期一";
        
    }else if([week isEqualToString:@"Tuesday"]){
        weekStr=@"星期二";
        
    }else if([week isEqualToString:@"Wednesday"]){
        weekStr=@"星期三";
        
    }else if([week isEqualToString:@"Thursday"]){
        weekStr=@"星期四";
        
    }else if([week isEqualToString:@"Friday"]){
        weekStr=@"星期五";
        
    }else if([week isEqualToString:@"Saturday"]){
        weekStr=@"星期六";
        
    }
    return weekStr;
}


@end
