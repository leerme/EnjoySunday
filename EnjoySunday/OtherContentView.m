//
//  OtherContentView.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "OtherContentView.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "NetInterface.h"
#import "SundayContentModel.h"
#import "LoopContentCell.h"
@interface OtherContentView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)NSString *url;

@property(nonatomic)NSMutableArray *dataArray;

@end

@implementation OtherContentView
+(id)otherContentView
{
    return [[self alloc] init];
}
-(id)init
{
    if(self=[super init])
    {
        _dataArray=[NSMutableArray array];
        //self.backgroundColor=[UIColor blueColor];
        self.frame=CGRectMake(0, 106, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height-106-49);
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self addRefresh];
    }
    return self;
}

-(void)setCount:(NSString *)count
{
    _count=count;
    [self headerRefresh];
}
-(void)addRefresh
{
    self.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    self.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}

-(void)headerRefresh
{
//    UIActivityIndicatorView *action=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [self addSubview:action];
//    action.center=self.center;
//    [action startAnimating];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:OTHERCONTENT_URL,self.count]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self.header endRefreshing];
             if (responseObject) {
                 NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
                 if (!objects) {
                     return;
                 }
                 
                 [_dataArray removeAllObjects];
                 NSDictionary *dic=objects[@"data"];
                 NSArray *array=dic[@"items"];
                 self.url=((NSDictionary*)dic[@"paging"])[@"next_url"];
                 for(NSDictionary *d in array)
                 {
                     LoopContentModel *model=[LoopContentModel loopContentModelWithDict:d];
                     [_dataArray addObject:model];
                 }
                 if([NSStringFromClass([self.url class]) isEqualToString:@"NSNull"])
                 {
                     [self.footer removeFromSuperview];
                 }
                 self.delegate=self;
                 self.dataSource=self;
                 [self reloadData];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self.header endRefreshing];
         }
     ];

}
-(void)footerRefresh
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:self.url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self.footer endRefreshing];
             if (responseObject) {
                 NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
                 if (!objects) {
                     return;
                 }
                 
                 NSDictionary *dic=objects[@"data"];
                 NSArray *array=dic[@"items"];
                 self.url=((NSDictionary*)dic[@"paging"])[@"next_url"];
                 
                 for(NSDictionary *d in array)
                 {
                     LoopContentModel *model=[LoopContentModel loopContentModelWithDict:d];
                     [_dataArray addObject:model];
                 }
                 
                 if([NSStringFromClass([self.url class]) isEqualToString:@"NSNull"])
                 {
                     [self.footer removeFromSuperview];
                 }
                 else
                 {
                     [self footerRefresh];
                     self.delegate=self;
                     self.dataSource=self;
                     [self reloadData];
                 }
                 
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error){
             [self.footer endRefreshing];
         }
     ];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoopContentCell *cell = [LoopContentCell loopContentCellWithTableView:tableView];
    LoopContentModel *model=_dataArray[indexPath.row];
    cell.model=model;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoopContentModel *model=_dataArray[indexPath.row];
    [self._delegate otherContentViewWithID:[model.ID stringValue]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
@end
