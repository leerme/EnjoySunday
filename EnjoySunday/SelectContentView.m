//
//  SelectContentView.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "SelectContentView.h"
#import "LoopView.h"
#import "SundayContentModel.h"
#import "SelectContentCell.h"
@interface SelectContentView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)LoopView *loopView;
//@property(nonatomic)UITableView *tableView;

@end

@implementation SelectContentView

+(id)selectContentView
{
    return [[self alloc] init];
}

-(id)init
{
    if(self=[super init])
    {
        self.frame=CGRectMake(0, 106, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height-106-49);
        self.loopView=[LoopView loopView];
    }
    return self;
}

-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray=nil;
    NSMutableArray *array=[NSMutableArray new];
    for(int i=1;i<dataArray.count;i++)
    {
        SundayContentModel *new=dataArray[i];
        SundayContentModel *old=dataArray[i-1];
        if([[self getDate:new.created_at] isEqualToString:[self getDate:old.created_at]])
        {
            NSArray *a=@[new,old];
            [array addObject:a];
            i++;
        }else
        {
            NSArray *b=@[old];
            [array addObject:b];
            if(i==dataArray.count-1)
            {
                NSArray *c=@[new];
                [array addObject:c];
            }
        }
    }
   // NSLog(@"%ld",array.count);
    _dataArray=array;
    
    self.tableHeaderView=self.loopView;
    self.delegate=self;
    self.dataSource=self;
    self.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
}

-(void)setLoopDataArray:(NSArray *)loopDataArray
{
    _loopDataArray=loopDataArray;
    NSMutableArray *array=[NSMutableArray new];
    for(int i=0;i<loopDataArray.count;i++)
    {
        LoopViewModel *model=loopDataArray[i];
        [array addObject:model.image_url];
        //NSLog(@"%@",model.image_url);
    }
    // NSLog(@"%@",array);
    __weak typeof(self) ws= self;
    [self.loopView setImageClick:^(NSInteger index) {
//        if(self._delegate && [self respondsToSelector:@selector(selectContentViewWithID:)])
//        {
            LoopViewModel *model = loopDataArray[index];
            [ws._delegate selectContentViewWithID:[model.target_id stringValue]];
//        }
    }];

    self.loopView.imageArray=array;
    
}
#pragma mark --tableView DataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectContentCell *cell=[SelectContentCell selectContentCellWithTableView:tableView];
    
    if(indexPath.row<_dataArray.count)
    {
        NSArray *model=_dataArray[indexPath.row];
    
        cell.backgroundColor=[UIColor colorWithWhite:0.868 alpha:1.000];
    
        cell.model=model;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [cell setImageClick:^(SundayContentModel *model) {
           NSLog(@"%@",[model.ID stringValue]);
            [self._delegate selectContentViewWithTabelViewID:[model.ID stringValue]];
        }];
    }
    return cell;
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((NSArray *)_dataArray[indexPath.row]).count==1?200:360;
}


//-(void)willMoveToSuperview:(UIView *)newSuperview
//{
//    self.frame=CGRectMake(0, 106, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height-106);
//    
//}
@end
