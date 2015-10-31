//
//  FanKuiTableViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/30.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "FanKuiTableViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface FanKuiTableViewController ()<UITextViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, weak) MBProgressHUD *hud;
@property (nonatomic, weak) UIButton *button;
@end

@implementation FanKuiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.textField.delegate = self;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside   ];
    self.button = button;
    
    NSLog(@"%d",(self.textView.text.length > 0 && self.textField.text.length > 0));
    
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.button];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"!!!");
    [self.textField resignFirstResponder];
    [self.textView resignFirstResponder];

    if (!(self.textView.text.length > 0 && self.textField.text.length > 0)) {
        [self.button setTitle:@"" forState:UIControlStateNormal];
    }else{
        [self.button setTitle:@"完成" forState:UIControlStateNormal];
    }
    return YES;

}

- (void)rightClick:(UIButton *)button
{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.tableView];
    hud.labelText = @"正在提交";
    [self.tableView addSubview:hud];
    self.hud = hud;
    [self.hud show:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://api.guozhoumoapp.com/v1/feedbacks" parameters:@{@"contact" : self.textField.text , @"content" : self.textView.text , @"device" : @"iPhone8%2C1" , @"os" : @"9.0.2" , @"version" : @"1.0%20%289%29"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"dfas");
        [self performSelector:@selector(hudHidden) withObject:nil afterDelay:3.0];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)hudHidden
{
    self.hud.labelText = @"提交成功";
    [self.hud show:NO];
    [self.hud hide:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
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
