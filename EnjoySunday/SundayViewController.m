//
//  SundayViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "SundayViewController.h"
#import "TopNavView.h"
#import "LoopView.h"
#import "SundayCachePath.h"
#import "AFNetworking.h"
#import "SelectContentView.h"
#import "SundayContentModel.h"
#import "MJRefresh.h"
#import "LoopContentViewController.h"
#import "OtherContentView.h"
#import "DetailViewController.h"
#import "SearchViewController.h"
@interface SundayViewController ()<SelectContentViewDelegate,TopNavViewDelegate,OtherContentViewDelegate>

@property(nonatomic)TopNavView *topNavView;
@property(nonatomic)SelectContentView *selectContentView;

@property(nonatomic)OtherContentView *sundayView;
@property(nonatomic)OtherContentView *tasteView;
@property(nonatomic)OtherContentView *expView;
@property(nonatomic)OtherContentView *tripView;



@property(nonatomic)NSMutableArray *contentDataArray;
@property(nonatomic)NSMutableArray *loopViewDataArray;
//@property(nonatomic)NSMutableArray *detailArray;
@property(nonatomic)NSArray *pageArray;
@property(nonatomic)int pageOff;

@end

@implementation SundayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBar];
    _contentDataArray=[[NSMutableArray alloc] init];
    _loopViewDataArray=[[NSMutableArray alloc] init];
    _pageArray=@[@"12",@"15",@"13",@"14"];
    _pageOff=20;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.topNavView=[TopNavView topNavView];
    [self.view addSubview:self.topNavView];
    self.topNavView.delegate=self;
    self.topNavView.titleArray=@[@"精选",@"周末逛店",@"尝美食",@"体验课",@"周边游"];
    //精选界面
    self.selectContentView=[SelectContentView selectContentView];
    //[self.view addSubview:self.selectContentView];
    self.selectContentView._delegate=self;
    //周末逛店界面
    self.sundayView=[OtherContentView otherContentView];
    self.sundayView._delegate=self;
    //尝美食界面
    self.tasteView=[OtherContentView otherContentView];
    self.tasteView._delegate=self;
    //体验课
    self.expView=[OtherContentView otherContentView];
    self.expView._delegate=self;
    //周边游
    self.tripView=[OtherContentView otherContentView];
    self.tripView._delegate=self;
    self.topNavView.viewArray=@[_selectContentView,_sundayView,_tasteView,_expView,_tripView];

    
    [self addRefresh];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[SundayCachePath sundayCachePath]]) {
        [self loadDataFromSelectTableViewCache];
    }else
    {
        [self loadDataFromServer:SELECTION_URL];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:[SundayCachePath loopCachePath]]) {
        [self loadDataFromSelectLoopCache];
    }else
    {
        [self loadDataFromServer:LOOPVIEW_URL];
    }
    
    
    
}
-(void)createNavBar
{
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem=right;
}

-(void)search
{
    SearchViewController *search=[[SearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

-(void)otherContentViewWithID:(NSString *)key
{
    DetailViewController *detail=[[DetailViewController alloc] init];
    detail.url=[NSString stringWithFormat:DETAIL_URL,key];
    [self.navigationController pushViewController:detail animated:YES];
}
-(void)topNavViewWithTag:(NSInteger)index
{
    //NSLog(@"%ld",index);
    switch (index) {
        case 1:
            self.sundayView.count=_pageArray[0];
            break;
        case 2:
            self.tasteView.count=_pageArray[1];
            break;
        case 3:
            self.expView.count=_pageArray[2];
            break;
        default:
            self.tripView.count=_pageArray[3];
            break;
    }
    
}

//selectContentView的代理实现
-(void)selectContentViewWithID:(NSString *)key
{
    LoopContentViewController *loopContent=[[LoopContentViewController alloc] init];
    
    loopContent.url=[NSString stringWithFormat:LOOPCLICK_URL,key];
    [self.navigationController pushViewController:loopContent animated:YES];
    
}

-(void)selectContentViewWithTabelViewID:(NSString *)key
{
    DetailViewController *detail=[[DetailViewController alloc] init];
    detail.url=[NSString stringWithFormat:DETAIL_URL,key];
    [self.navigationController pushViewController:detail animated:YES];
    
}

-(void)addRefresh
{
    self.selectContentView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    self.selectContentView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}

-(void)headerRefresh
{
    [self loadDataFromServer:SELECTION_URL];
}



-(void)footerRefresh
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:SELECTION_REFRESH_URL,_pageOff];
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self.selectContentView.footer endRefreshing];
             if (responseObject) {
                 //[self loadDataFromSelectTableViewCache];
                 NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
                 if (!objects) {
                     return;
                 }
                 NSDictionary *dic=objects[@"data"];
                 NSArray *array=dic[@"items"];
                 for(NSDictionary *dic in array)
                 {
                     SundayContentModel *model=[SundayContentModel sundayContentModelWithDict:dic];
                     [self.contentDataArray addObject:model];
                 }
                 //NSLog(@"%ld",self.contentDataArray.count);
                 self.selectContentView.dataArray=self.contentDataArray;
                 [self.selectContentView reloadData];
                 _pageOff+=20;
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self.selectContentView.footer endRefreshing];
         }
     ];

}

//本地加载- 精选 -LoopView数据
- (void) loadDataFromSelectLoopCache
{
    NSData * fileData = [NSData dataWithContentsOfFile:[SundayCachePath loopCachePath]];
    NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:nil];
    if (!objects) {
        return;
    }
    
    [self.loopViewDataArray removeAllObjects];
    
    NSDictionary *dic=objects[@"data"];
    NSArray *array=dic[@"banners"];
    for(NSDictionary *dic in array)
    {
         LoopViewModel *model=[LoopViewModel loopViewModelWithDict:dic];
         [_loopViewDataArray addObject:model];
    }
   
    self.selectContentView.loopDataArray=self.loopViewDataArray;

}
//本地加载- 精选 -tableView数据
- (void) loadDataFromSelectTableViewCache
{
    NSData * fileData = [NSData dataWithContentsOfFile:[SundayCachePath sundayCachePath]];
    NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:nil];
    if (!objects) {
        return;
    }
    
    [self.contentDataArray removeAllObjects];
    
    NSDictionary *dic=objects[@"data"];
    NSArray *array=dic[@"items"];
    for(NSDictionary *dic in array)
    {
        SundayContentModel *model=[SundayContentModel sundayContentModelWithDict:dic];
        [self.contentDataArray addObject:model];
    }
    self.selectContentView.dataArray=self.contentDataArray;
    
}

//服务器下载数据
- (void) loadDataFromServer:(NSString *)url
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self.selectContentView.header endRefreshing];
             if (responseObject) {
                 if([url isEqualToString:LOOPVIEW_URL])
                 {
                     [[NSFileManager defaultManager] removeItemAtPath:[SundayCachePath loopCachePath] error:nil];
                     
                     [operation.responseData writeToFile:[SundayCachePath loopCachePath] atomically:NO];
                     
                     [self loadDataFromSelectLoopCache];
                     
                 }else if([url isEqualToString:SELECTION_URL])
                 {
                     [[NSFileManager defaultManager] removeItemAtPath:[SundayCachePath sundayCachePath] error:nil];
                     
                     [operation.responseData writeToFile:[SundayCachePath sundayCachePath] atomically:NO];

                     [self loadDataFromSelectTableViewCache];
                 }
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self.selectContentView.header endRefreshing];
         }
     ];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
