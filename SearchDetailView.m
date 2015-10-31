//
//  SearchDetailView.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/27.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "SearchDetailView.h"
#import "NetInterface.h"
#import "AFNetworking.h"
#import "SundayContentModel.h"
#import "SearchCollectionViewCell.h"
@interface SearchDetailView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic)UIView *indicatorView;
@property(nonatomic)UICollectionView *collectionView;
@property(nonatomic)NSMutableArray *dataArray;

@end

@implementation SearchDetailView

+(id)searchDetailView
{
    return [[self alloc] init];
}

-(id)init
{
    if(self=[super init])
    {
        self.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _dataArray=[NSMutableArray array];
        [self createUI];
        
    }
    return self;
}

-(void)setUrl:(NSString *)url
{
    _url=url;
    [self loadDataFromServe];
}

-(void)loadDataFromServe
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:_url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (responseObject) {
                 //[self loadDataFromSelectTableViewCache];
                 NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
                 if (!objects) {
                     return;
                 }
                 [_dataArray removeAllObjects];
                 NSDictionary *dic=objects[@"data"];
                 NSArray *array=dic[@"items"];
                 for (NSDictionary *dic in array) {
                     SearchModel *model=[SearchModel searchModelWithDict:dic];
                     [_dataArray addObject:model];
                 }
                 _collectionView.delegate=self;
                 _collectionView.dataSource=self;
             }
             [self.collectionView reloadData];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error){
         }
     ];

}
-(void)createUI
{
    NSArray *array=@[@"商品",@"攻略"];
    for(int i=0;i<2;i++)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.frame=CGRectMake(i*self.frame.size.width/2, 0, self.frame.size.width/2, 40);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderWidth=0.8;
        btn.tag=i;
        btn.layer.borderColor=[UIColor grayColor].CGColor;
    }
    _indicatorView=[[UIView alloc] initWithFrame:CGRectMake(0,38, self.frame.size.width/2, 2)];
    [self addSubview:_indicatorView];
    _indicatorView.backgroundColor=GLOBLE_COLOR;
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize=CGSizeMake(self.frame.size.width/2-10, 200);
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 10, 0, 0);
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height-40) collectionViewLayout:flowLayout];
    [self addSubview:_collectionView];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCollectionViewCell *cell=[SearchCollectionViewCell searchCollectionViewCellWithCollectionView:collectionView andIndexPath:indexPath];
    SearchModel *model=_dataArray[indexPath.row];
    cell.model=model;
    return cell;
}

-(void)btnClick:(UIButton *)btn
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame=_indicatorView.frame;
        frame.origin.x=btn.tag*self.frame.size.width/2;
        _indicatorView.frame=frame;
    }];
    if(btn.tag==1)
    {
        _collectionView.hidden=YES;
    }else
    {
        _collectionView.hidden=NO;
    }
    
}
@end
