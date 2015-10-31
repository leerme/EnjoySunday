//
//  LoginViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/29.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "LoginViewController.h"
#import "UMSocial.h"
#import "SGActionView.h"
#import "NetInterface.h"
#import "RegisterViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *SecretText;
@property (weak, nonatomic) IBOutlet UIButton *sinaButn;
@property (weak, nonatomic) IBOutlet UIButton *weixinButn;
@property (weak, nonatomic) IBOutlet UIButton *qqButn;
@property (weak, nonatomic) IBOutlet UILabel *forgetLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(nonatomic)NSInteger index;
@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated
{
//    self.navigationController.navigationBar.backgroundColor=GLOBLE_COLOR;
    self.tabBarController.tabBar.hidden=YES;
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}
-(void)viewWillDisappear:(BOOL)animated
{
    //    self.navigationController.navigationBar.backgroundColor=GLOBLE_COLOR;
    self.tabBarController.tabBar.hidden=NO;
//    [self.navigationController.navigationBar setShadowImage:nil];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    [_loginBtn setBackgroundColor:GLOBLE_COLOR];
}
- (IBAction)loginBtnClick:(id)sender {
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"name"])
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil  message:@"用户名不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if([_phoneText.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]] && [_SecretText.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil  message:@"用户名或密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

-(void)createNav
{
    self.title=@"登陆";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(regist)];
}
-(void)regist
{
    RegisterViewController *regist=[[RegisterViewController alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
}
-(void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setIndex:(NSInteger)index
{
    NSArray *loginType = @[UMShareToSina,UMShareToWechatSession,UMShareToQQ];
  
     UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:loginType[index-1]];
     
     snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService], YES, ^(UMSocialResponseEntity *response){
         if (response.responseCode == UMSResponseCodeSuccess) {
             
             UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:loginType[index -1]];
             
             NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
             [[NSUserDefaults standardUserDefaults] setObject:snsAccount.userName forKey:@"name"];
             [[NSUserDefaults standardUserDefaults] setObject:snsAccount.iconURL forKey:@"icon"];
             //B.显示用户全部信息
             //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
//             [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
//                 
//                 NSLog(@"SnsInformation is %@",response.data);
//                 NSLog(@"%@",response.data[@"location"]);
//             }];
             [self.navigationController popViewControllerAnimated:YES];
             
         }
         
     });
}
- (IBAction)sinaBtnClick:(id)sender {
    self.index=1;
}


- (IBAction)weixinBtnClick:(id)sender {
    self.index=2;
}


- (IBAction)qqBtnClick:(id)sender {
    self.index=3;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
