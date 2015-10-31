//
//  SingleViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "SingleMainViewController.h"
#import "MJRefresh.h"
#import "SingleMainModel.h"
#import "ClassifyPath.h"
#import "AFNetworking.h"
#import "NetInterface.h"
#import "SingleMainCell.h"
#import "UIImageView+WebCache.h"
#import "SingleClickedViewController.h"


@interface SingleMainViewController ()

@property (nonatomic) NSString * cachePath;
@property (nonatomic) NSString * url;
@property (nonatomic) NSMutableArray * dataArray;

@end

@implementation SingleMainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.cachePath = [ClassifyPath singleMianCachePath];
    self.dataArray = [[NSMutableArray alloc] init];
    self.url = SINGLE_MAIN_URL;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.cachePath]) {
        [self loadDataFromCache];
    }
    else {
        [self loadDataFromServer];
    }

}

- (void) headerRefresh
{
    [self loadDataFromServer];
}

- (void) loadDataFromCache
{
    NSData * fileData = [NSData dataWithContentsOfFile:self.cachePath];
    NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:nil];
    if (!objects) {
        return;
    }
    
    [self.dataArray removeAllObjects];
    
    NSDictionary * dicts = objects[@"data"];
    NSArray *dataArray = dicts[@"items"];
    
    for (NSDictionary *dict in dataArray) {
        NSDictionary *dictss = dict[@"data"];
              SingleMainModel *model = [SingleMainModel singleMainModelWithDict:dictss];
            [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
}


- (void) loadDataFromServer
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:self.url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self.tableView.header endRefreshing];
             if (responseObject) {
                 [[NSFileManager defaultManager] removeItemAtPath:self.cachePath error:nil];
                 
                 [operation.responseData writeToFile:self.cachePath atomically:NO];
                 
                 [self loadDataFromCache];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Url failed: %@", self.url);
             [self.tableView.header endRefreshing];
         }
     ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count/2;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SingleMainCell *cell=[SingleMainCell singleMainCellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for(int i=0;i<2;i++)
    {
        SingleMainModel *model=self.dataArray[indexPath.row*2+i];
        if (i==0) {
            cell.leftModel = model;
        }else{
            cell.rightModel = model;
        }
    }
    
    cell.imageClickBlock = ^(NSNumber *ID){
        NSLog(@"%@",[ID stringValue]);
        
        SingleClickedViewController *vc = [[SingleClickedViewController alloc] init];
        vc.ID = ID;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
