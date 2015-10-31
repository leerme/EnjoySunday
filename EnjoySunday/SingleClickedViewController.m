//
//  SingleClickedViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/24.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "SingleClickedViewController.h"
#import "AFNetworking.h"
#import "ZJModelTool.h"
#import "NetInterface.h"
#import "SingleClickedModel.h"
#import "SingleCnotentCell.h"
#import "NSString+Frame.h"
#import "SingleWebCell.h"
#import "SGActionView.h"
#import "UMSocial.h"

@interface SingleClickedViewController ()<UMSocialUIDelegate>

@property (nonatomic, strong) SingleClickedModel *model;
@property (nonatomic, copy) NSString *url;
@property (nonatomic) CGFloat rowHeight;
@end

@implementation SingleClickedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.url = [NSString stringWithFormat:SINGLE_MAIN_CLICK_URL,[self.ID stringValue]];
    [self loadDataFromServer];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(rightClicked)];
}

- (void)rightClicked
{
    NSLog(@"dd");
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
             SingleClickedModel *model = [SingleClickedModel singleClickedModelWithDict:dicts];
             self.model = model;
             [self.tableView reloadData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (self.rowHeight != 0) {
            return self.rowHeight;
        }
        return 875;
    }
    
    float nameHeight = [self.model.name heightWithFont:[UIFont systemFontOfSize:17] withinWidth:self.view.bounds.size.width - 16];
    
    float contentHeight = [self.model.desc heightWithFont:[UIFont systemFontOfSize:17] withinWidth:self.view.bounds.size.width - 16];
    
//    if (self.rowHeight != 0) {
//        return self.rowHeight;
//    }
    return nameHeight + contentHeight + 357;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section!=1) {
        return 0;
    }
    
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section!=1) {
        return nil;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 1, 30)];
    view.backgroundColor = [UIColor lightGrayColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"图文介绍" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.frame = CGRectMake(0, 0, self.view.bounds.size.width/2, 30);
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"评论" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.frame = CGRectMake(self.view.bounds.size.width/2 + 1, 0, self.view.bounds.size.width/2 - 2, 30);
    
    [button1 setBackgroundColor:[UIColor whiteColor]];
    [button2 setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:button1];
    [view addSubview:button2];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SingleCnotentCell *cell = [SingleCnotentCell singleCnotentCellWithTableView:tableView];
        cell.model = self.model;
        return cell;
    }
    
    SingleWebCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[SingleWebCell alloc] init];
    }
    cell.model = self.model;
    cell.singWebCellFinishLoadBlock = ^(CGFloat height){
        
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.rowHeight = height;
    };
    return cell;
}



@end
