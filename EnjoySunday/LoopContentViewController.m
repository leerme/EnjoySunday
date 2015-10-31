//
//  LoopContentViewContent.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "LoopContentViewController.h"
#import "LoopContentCell.h"
#import "SundayContentModel.h"
#import "AFNetworking.h"
#import "NetInterface.h"
#import "DetailViewController.h"
@interface LoopContentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic)NSMutableArray *dataArray;
@end

@implementation LoopContentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray=[NSMutableArray array];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self loopImageClickLoadDataFromServer];
}

-(void)loopImageClickLoadDataFromServer
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
                 NSDictionary *dic=objects[@"data"];
                 NSArray *array=dic[@"posts"];
                 for(NSDictionary *d in array)
                 {
                     LoopContentModel *model=[LoopContentModel loopContentModelWithDict:d];
                     [_dataArray addObject:model];
                     
                 }
                 self.title = dic[@"title"];
                 [self.tableView reloadData];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error){
         }
     ];
    
}


#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail=[[DetailViewController alloc] init];
    LoopContentModel *model=_dataArray[indexPath.row];
    detail.url=[NSString stringWithFormat:DETAIL_URL,[model.ID stringValue]];
    
    [self.navigationController pushViewController:detail animated:YES];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LoopContentCell *cell = [LoopContentCell loopContentCellWithTableView:tableView];
    LoopContentModel *model=_dataArray[indexPath.row];
    cell.model=model;
   // cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
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
