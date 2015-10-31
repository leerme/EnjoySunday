//
//  SettingViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/29.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "SettingViewController.h"
#import "UMSocial.h"
#import "SGActionView.h"

@interface SettingViewController ()<UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UILabel *type;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Gender"]&&[[NSUserDefaults standardUserDefaults] objectForKey:@"Gender"]) {
        self.type.text = [NSString stringWithFormat:@"%@   %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Gender"],[[NSUserDefaults standardUserDefaults] objectForKey:@"ID"]];
    }else{
        self.type.text = @"";
    }
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.045 green:0.681 blue:0.850 alpha:1.000];
    self.title = @"设置";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(action)];
}

- (void)action
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)share
{
    NSArray *loginType = @[UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToSina,UMShareToWechatSession,UMShareToQQ];
    
    NSArray *shareArray=@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToSina,UMShareToTencent,UMShareToSms,UMShareToEmail];
    
    
    [SGActionView showGridMenuWithTitle:@"分享到"
                             itemTitles:@[ @"微信好友",@"朋友圈",@"QQ空间",@"QQ好友",@"新浪微博",@"腾讯微博",@"短信",@"邮件"]
                                 images:@[ [UIImage imageNamed:@"UMS_wechat_icon"],
                                           [UIImage imageNamed:@"UMS_wechat_timeline_icon"],
                                           [UIImage imageNamed:@"UMS_qzone_icon"],
                                           [UIImage imageNamed:@"UMS_qq_icon"],
                                           [UIImage imageNamed:@"UMS_sina_icon"],
                                           [UIImage imageNamed:@"UMS_tencent_icon"],[UIImage imageNamed:@"UMS_sms_icon"],
                                           [UIImage imageNamed:@"UMS_email_icon"],]
                         selectedHandle:^(NSInteger index){
                             NSLog(@"%ld",index);
                             
                             [[UMSocialControllerService defaultControllerService] setShareText:@"哈哈哈哈" shareImage:nil socialUIDelegate:self];
                             
                             [UMSocialSnsPlatformManager getSocialPlatformWithName:shareArray[index]].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
                             
                             //                             UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:loginType[index]];
                             //
                             //                             snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService], YES, ^(UMSocialResponseEntity *response){
                             //                                 if (response.responseCode == UMSResponseCodeSuccess) {
                             //
                             UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:loginType[index]];
                             
                             NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                             
                             //                                     //B.显示用户信息
                             //                                     //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
                             //                                     [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                             //
                             //                                         NSLog(@"SnsInformation is %@",response.data);
                             //                                         NSLog(@"%@",response.data[@"location"]);
                             //                                     }];
                             //                                     
                             //                                 }
                             //                                 
                             //                             });
                         }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self share];
        }
    }
}


//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 1;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"PingFeng"]) {
        NSLog(@"fdsafds");
        //PingFengViewController *vc = [segue destinationViewController];
    }
}


@end
