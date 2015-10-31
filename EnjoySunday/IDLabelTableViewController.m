//
//  IDLabelTableViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/30.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "IDLabelTableViewController.h"

@interface IDLabelTableViewController ()
@property (nonatomic) NSInteger ID;

@property (weak, nonatomic) IBOutlet UIImageView *imageOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageThree;
@property (weak, nonatomic) IBOutlet UIImageView *imageFour;
@property (weak, nonatomic) IBOutlet UIImageView *imageFive;

@end

@implementation IDLabelTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ID = 0;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setID:(NSInteger)ID
{
    self.imageOne.hidden   = (ID -0) == 0 ? NO : YES;
    self.imageTwo.hidden   = (ID -1) == 0 ? NO : YES;
    self.imageThree.hidden = (ID -2) == 0 ? NO : YES;
    self.imageFour.hidden  = (ID -3) == 0 ? NO : YES;
    self.imageFive.hidden  = (ID -4) == 0 ? NO : YES;
}
#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [[NSUserDefaults standardUserDefaults] setObject:@"初中生" forKey:@"ID"];
        self.ID = indexPath.row;
    }else if (indexPath.row == 1){
        [[NSUserDefaults standardUserDefaults] setObject:@"高中生" forKey:@"ID"];
        self.ID = indexPath.row;
    }else if (indexPath.row == 2){
        [[NSUserDefaults standardUserDefaults] setObject:@"大学生" forKey:@"ID"];
        self.ID = indexPath.row;
    }else if (indexPath.row == 3){
        [[NSUserDefaults standardUserDefaults] setObject:@"职场新人" forKey:@"ID"];
        self.ID = indexPath.row;
    }else if (indexPath.row == 4){
        [[NSUserDefaults standardUserDefaults] setObject:@"资深工作者" forKey:@"ID"];
        self.ID = indexPath.row;
    }
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
