//
//  MineViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "MineViewController.h"
#import "NetInterface.h"
#import "LoginViewController.h"
#import "UIKit+AFNetworking.h"
#import "SettingViewController.h"


@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    CGRect _bgViewFrame;
    CGRect _iconFrame;
    CGRect _nameFrame;
}
@property(nonatomic)UITableView *tableView;
@property(nonatomic)UIImageView *iconView;
@property(nonatomic)UILabel *nameLabel;
@property(nonatomic)UIView  *indicatorView;
@property(nonatomic)UIImageView *backgroundView;
@property(nonatomic)UIView *bgView;
@end

@implementation MineViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self createNav];
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"icon"])
    {
        [_iconView setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"icon"]]];
        _nameLabel.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
        _tableView.scrollEnabled=YES;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    _tableView.scrollEnabled=NO;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.contentInset=UIEdgeInsetsMake(186, 0, 0, 0);
    
    _backgroundView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    _bgViewFrame=_backgroundView.frame;
    _backgroundView.userInteractionEnabled=YES;
    _backgroundView.image=[UIImage imageNamed:@"Me_ProfileBackground.jpg"];
    [self.view addSubview:_backgroundView];
    
    [self createBgView];
    _tableView.tableHeaderView=_bgView;
    
    _iconView=[[UIImageView alloc] initWithFrame:CGRectMake(130, 70, 50, 50)];
    [_backgroundView addSubview:_iconView];
    _iconView.center=_backgroundView.center;
    _iconFrame=_iconView.frame;
    _iconView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick:)];
    [_iconView addGestureRecognizer:tap];
    _iconView.image=[UIImage imageNamed:@"box_05"];
    _iconView.layer.cornerRadius=25;
    _iconView.clipsToBounds=YES;

    
    _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconView.frame)+5, self.view.frame.size.width, 30)];
    _nameFrame=_nameLabel.frame;
    [_backgroundView addSubview:_nameLabel];
    _nameLabel.textColor=[UIColor whiteColor];
    _nameLabel.textAlignment=NSTextAlignmentCenter;
    _nameLabel.text=@"点击图片登陆";
    
    
}
-(void)createBgView
{
    _bgView=[[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 40)];
    NSArray *array=@[@"商品",@"攻略"];
    for(int i=0;i<2;i++)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame=CGRectMake(i*self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 40);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=[UIColor whiteColor];
        btn.layer.borderWidth=0.8;
        btn.tag=i;
        btn.layer.borderColor=[UIColor grayColor].CGColor;
        [_bgView addSubview:btn];
    }
    _indicatorView=[[UIView alloc] initWithFrame:CGRectMake(0,38, self.view.frame.size.width/2, 2)];
    _indicatorView.backgroundColor=GLOBLE_COLOR;
    [_bgView addSubview:_indicatorView];
    
}

-(void)iconClick:(UITapGestureRecognizer *)tap
{
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"icon"])
    {
        [self pushLogin];
    }else
    {
        UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出" otherButtonTitles:nil];
        [sheet showInView:self.view];
    }
}

-(void)pushLogin
{
    LoginViewController *login=[[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icon"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"name"];
        _iconView.image=[UIImage imageNamed:@"box_05"];
        _nameLabel.text=@"点击图片登陆";
    }
}
-(void)createNav
{
    self.navigationItem.title=@"";
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"🔔" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtn)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn)];
}

-(void)leftBtn
{
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"icon"])
    {
        [self pushLogin];
    }else
    {
//        UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出" otherButtonTitles:nil];
//        [sheet showInView:self.view];
    }

}

-(void)rightBtn
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SettingStoryboard" bundle:nil];
    SettingViewController *svc=[storyboard instantiateViewControllerWithIdentifier:@"Setting"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:svc];
    [self presentViewController:nav animated:YES completion:nil];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY=scrollView.contentOffset.y+250;
    CGRect bgFrame=_backgroundView.frame;
    CGRect iconFrame=_iconView.frame;
       //
    if(offsetY<0)
    {
       // NSLog(@"%f   %f",bgFrame.size.width-bgFrame.origin.x-376,offsetY);
        iconFrame.size.width=_iconFrame.size.width - offsetY/3;
        
        CGRect nameFrame=_nameLabel.frame;
        nameFrame.origin.y=_nameFrame.origin.y-offsetY/3;
        nameFrame.size.height=_nameFrame.size.height-offsetY;
        _nameLabel.frame=nameFrame;
        _nameLabel.font=[UIFont systemFontOfSize:17-offsetY/25];
    }else
    {
        iconFrame.size.width=_iconFrame.size.width - offsetY/10;
        _nameLabel.alpha=1-offsetY/60;
    }
    
    bgFrame.size.height=_bgViewFrame.size.height-offsetY;
    _backgroundView.frame=bgFrame;
    
    iconFrame.size.height=iconFrame.size.width;
    _iconView.frame=iconFrame;
    _iconView.center=_backgroundView.center;
    _iconView.layer.cornerRadius=_iconView.frame.size.width/2;
    _iconView.clipsToBounds=YES;
    
    offsetY=offsetY>-100?offsetY:-100;
    offsetY=offsetY<180?offsetY:180;
    scrollView.contentOffset=CGPointMake(0, offsetY-250);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height-300;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
//    NSArray *array=@[@"商品",@"攻略"];
//    for(int i=0;i<2;i++)
//    {
//        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:array[i] forState:UIControlStateNormal];
//        btn.titleLabel.font=[UIFont systemFontOfSize:15];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        btn.frame=CGRectMake(i*self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 40);
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        btn.backgroundColor=[UIColor whiteColor];
//        btn.layer.borderWidth=0.8;
//        btn.tag=i;
//        btn.layer.borderColor=[UIColor grayColor].CGColor;
//        [bgView addSubview:btn];
//    }
//    _indicatorView=[[UIView alloc] initWithFrame:CGRectMake(0,38, self.view.frame.size.width/2, 2)];
//    _indicatorView.backgroundColor=GLOBLE_COLOR;
//    [bgView addSubview:_indicatorView];
//    return bgView;
//}

-(void)btnClick:(UIButton *)btn
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame=_indicatorView.frame;
        frame.origin.x=btn.tag*self.view.frame.size.width/2;
        _indicatorView.frame=frame;
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc] init];
    cell.textLabel.text=@"";
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0) {
//        [self performSegueWithIdentifier:@"PingFeng" sender:nil];
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    
//    
//}


@end
