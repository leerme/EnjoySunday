//
//  CollectionAllTableViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "CollectionAllTableViewController.h"
#import "AFNetworking.h"
#import "ClassifyPath.h"
#import "NetInterface.h"
#import "ClassifyModel.h"
#import "CollectionAllCell.h"
#import "CollectionClickViewController.h"

@interface CollectionAllTableViewController ()

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic) NSString * cachePath;

@end

@implementation CollectionAllTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.cachePath = [ClassifyPath collectionAllCachePath];
    self.dataArray = [[NSMutableArray alloc] init];
    
    self.tableView.rowHeight = 170;
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.cachePath]) {
        [self loadDataFromCache];
    }
    else {
        [self loadDataFromServer];
        
    }

    
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
    NSArray *dataArray = dicts[@"collections"];
    
    for (NSDictionary * dict in dataArray) {
        
        CollectionsModel *model = [CollectionsModel collectionsModelWithDict:dict];
        [self.dataArray addObject:model];
        
    }
    [self.tableView reloadData];
}


- (void) loadDataFromServer
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:CLASSIFY_ALL_COLLEXTION_CLICK_URL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             if (responseObject) {
                 [[NSFileManager defaultManager] removeItemAtPath:self.cachePath error:nil];
                 
                 [operation.responseData writeToFile:self.cachePath atomically:NO];
                 [self loadDataFromCache];
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

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionAllCell *cell = [CollectionAllCell collectionAllCellWithTableView:tableView];
    CollectionsModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionsModel *model = self.dataArray[indexPath.row];
    CollectionClickViewController *vc = [[CollectionClickViewController alloc] init];
    vc.ID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
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
