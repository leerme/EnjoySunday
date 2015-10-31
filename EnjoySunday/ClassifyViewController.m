//
//  ClassifyViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "ClassifyViewController.h"
#import "NetInterface.h"
#import "AFNetworking.h"
#import "ClassifyPath.h"
#import "ClassifyModel.h"
#import "CollectionCell.h"
#import "HouseCell.h"
#import "OutCell.h"
#import "CollectionClickViewController.h"
#import "AllTableViewController.h"
#import "CollectionAllTableViewController.h"

@interface ClassifyViewController ()<CollectionCellDelegate>

@property (nonatomic,strong) NSMutableArray *collectionDataArray;
@property (nonatomic,strong) NSMutableArray *houseDataArray;
@property (nonatomic,strong) NSMutableArray *outDataArray;

@property (nonatomic) NSString * collectionCachePath;
@property (nonatomic) NSString * allCachePath;
@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionCachePath = [ClassifyPath classifyCachePath];
    self.allCachePath = [ClassifyPath allCachePath];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.collectionDataArray = [[NSMutableArray alloc] init];
    self.houseDataArray = [[NSMutableArray alloc] init];
    self.outDataArray = [[NSMutableArray alloc] init];
//    [self loadDataFromServer];
//    [self loadDataFromServer];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.collectionCachePath]) {
        [self loadCollectionDataFromCache];
    }
    else {
        [self loadCollectionDataFromServer];

    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.allCachePath]) {
        [self loadAllDataFromCache];
    }
    else {
        [self loadAllDataFromServer];
    }
}

- (void) loadAllDataFromCache
{
    
    NSData * fileData = [NSData dataWithContentsOfFile:self.allCachePath];
    NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:nil];
    
    if (!objects) {
        return;
    }
    
    [self.houseDataArray removeAllObjects];
    [self.outDataArray removeAllObjects];
    
    NSDictionary * dicts = objects[@"data"];
    
    NSDictionary *dictionary = dicts[@"channel_groups"][0];
    NSArray *dataArray = dictionary[@"channels"];
    
    for (NSDictionary * dict in dataArray) {
        
        AllModel *model = [AllModel allModelWithDict:dict];
        [self.houseDataArray addObject:model];
        
    }
    
    NSDictionary *dictionary1 = dicts[@"channel_groups"][1];
    NSArray *dataArr = dictionary1[@"channels"];
    
    for (NSDictionary * dict in dataArr) {
        
        AllModel *model = [AllModel allModelWithDict:dict];
        [self.outDataArray addObject:model];
    }
    [self.tableView reloadData];
}


- (void) loadAllDataFromServer
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:CLASSIFY_INANDOUT_URL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             if (responseObject) {
                 [[NSFileManager defaultManager] removeItemAtPath:self.allCachePath error:nil];
                 
                 [operation.responseData writeToFile:self.allCachePath atomically:NO];
                 
                 [self loadAllDataFromCache];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         }
     ];
}



- (void) loadCollectionDataFromCache
{
    NSData * fileData = [NSData dataWithContentsOfFile:self.collectionCachePath];
    NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:nil];
    
    if (!objects) {
        return;
    }
    
    [self.collectionDataArray removeAllObjects];
    
    NSDictionary * dicts = objects[@"data"];
    
    NSArray *dataArray = dicts[@"collections"];
    
    for (NSDictionary * dict in dataArray) {
        CollectionsModel *model = [CollectionsModel collectionsModelWithDict:dict];
        
        model.mainTitle = objects[@"title"];
        
        [self.collectionDataArray addObject:model];
        
    }
    
    [self.tableView reloadData];
}


- (void) loadCollectionDataFromServer
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:CLASSIFY_CONLECTION_URL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
             if (responseObject) {
                 [[NSFileManager defaultManager] removeItemAtPath:self.collectionCachePath error:nil];
                 
                 [operation.responseData writeToFile:self.collectionCachePath atomically:NO];

                 [self loadCollectionDataFromCache];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         }
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)collectionCellButtonClickWithIndex:(NSInteger)index withID:(NSNumber *)ID
{
    if (index == 10) {
        CollectionAllTableViewController *vc = [[CollectionAllTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    CollectionClickViewController *vc = [[CollectionClickViewController alloc] init];
    vc.ID = ID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        CollectionCell *cell = [CollectionCell collectionCellWithTableView:tableView];
        cell.delegate = self;
        cell.dataArray = self.collectionDataArray;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 1){
        HouseCell *cell = [HouseCell houseCellWithTableView:tableView];
        cell.dataArray = self.houseDataArray;
        
        cell.buttonClickBlock = ^(NSInteger index , NSNumber *ID) {
            AllTableViewController *vc = [[AllTableViewController alloc] init];
            vc.ID = ID;
            [self.navigationController pushViewController:vc animated:YES];
        };
        
            
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    OutCell *cell = [OutCell outCellWithTableView:tableView];
    cell.dataArray = self.outDataArray;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.buttonClickBlock = ^(NSInteger index , NSNumber *ID) {
        AllTableViewController *vc = [[AllTableViewController alloc] init];
        vc.ID = ID;
        [self.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==  0) {
        return 120;
    }else if(indexPath.section == 1){
        return 150;
    }
    return 264;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 10)];
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}

@end
