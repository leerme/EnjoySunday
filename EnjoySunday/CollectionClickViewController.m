//
//  CollectionClickViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "CollectionClickViewController.h"
#import "AFNetworking.h"
#import "NetInterface.h"    
#import "ClassifyClickModel.h"
#import "CollectionClickTableViewCell.h"
#import "AllClickedViewController.h"

@interface CollectionClickViewController ()

@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CollectionClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    self.url = [NSString stringWithFormat:CLASSIFY_COLLECTION_CLICK_URL,[self.ID intValue]];
    [self loadDataFromServer];
    
}

- (void) loadDataFromServer
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:self.url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
                 NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                 
                 if (!objects) {
                     return;
                 }
            
                 NSDictionary * dicts = objects[@"data"];
                 NSArray *dataArray = dicts[@"posts"];
             
                 for (NSDictionary * dict in dataArray) {
                     
                     ClassifyClickModel *model = [ClassifyClickModel classifyClickModelWithDict:dict];
                     
                     [self.dataArray addObject:model];
                 }
             
                [self.tableView reloadData];
             }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         }
     ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionClickTableViewCell *cell = [CollectionClickTableViewCell collectionClickCellWithTableView:tableView];
    ClassifyClickModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassifyClickModel *model = self.dataArray[indexPath.row];
    AllClickedViewController *avc = [[AllClickedViewController alloc] init];
    avc.text = model.title;
    avc.imageUrl = model.cover_image_url;
    avc.contentUrl = model.content_url;
    [self.navigationController pushViewController:avc animated:YES];
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
