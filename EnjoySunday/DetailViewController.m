//
//  DetailViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "DetailBottomView.h"
#import "Masonry.h"
#import "ShareAppView.h"
#import "UMSocial.h"
#define btnW ([UIScreen mainScreen].bounds.size.width-160)/3
@interface DetailViewController ()<UIScrollViewDelegate,ShareAppViewDelegate,UMSocialUIDelegate,DetailBottomViewDelegate>
{
    int index;
    UIView *bgView;
    BOOL isShare;
}
@property(nonatomic)DetailModel *model;
@property(nonatomic)UIWebView *web;
@property(nonatomic)UIImageView *image;
@property(nonatomic)UITableView *tableView;
@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)CGRect f;
@property(nonatomic)CGRect l;
@property(nonatomic)CGRect bottomFrame;
@property(nonatomic)CGSize bgViewSize;
@property(nonatomic)DetailBottomView *detailBottomView;
@property(nonatomic)ShareAppView *shareView;
@end

@implementation DetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
//    [self.web.scrollView removeObserver:self forKeyPath:@"contentSize"];
    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"攻略详情";
    //NSLog(@"%@",self.model);
    isShare=YES;
    self.shareView=[ShareAppView shareAppView];
    [self.view addSubview:self.shareView];
    self.shareView.delegate=self;
    
    index=1;
    self.detailBottomView=[DetailBottomView detailBottomView];
    [self.view addSubview:self.detailBottomView];
    self.detailBottomView.delegate=self;
    
    
    self.view.backgroundColor=[UIColor whiteColor];
//    _web=[[UIWebView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _web=[[UIWebView alloc] init];
    
    self.web.scrollView.delegate=self;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:_web];
    [_web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(64));
        make.right.equalTo(@(0));
        make.left.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    _web.backgroundColor=[UIColor whiteColor];
    _web.scrollView.contentInset=UIEdgeInsetsMake(200, 0, 0, 0);
//    [_web.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    self.web.scrollView.backgroundColor=[UIColor whiteColor];
    self.image=[[UIImageView alloc] initWithFrame:CGRectMake(0,-200, [UIScreen mainScreen].bounds.size.width, 200)];
    [self.web.scrollView addSubview:self.image];
    _f=self.image.frame;

    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 160, [UIScreen mainScreen].bounds.size.width, 40)];
    _titleLabel.textColor=[UIColor whiteColor];
    _l=_titleLabel.frame;
////    _titleLabel.backgroundColor=[UIColor colorWithWhite:0.243 alpha:0.340];
    
    [self.image addSubview:_titleLabel];
    [self.view bringSubviewToFront:self.detailBottomView];
    [self detailViewLoadDataFromServer];
}
//-(void)addBtn
//{
//    NSArray *array=@[_model.likes_count,_model.shares_count,_model.comments_count];
//    NSArray *a=@[@"喜欢：",@"分享：",@"评论："];
//    
//    bgView=[[UIView alloc] init];
//    [self.web.scrollView addSubview:bgView];
//    CGFloat intorval=40;
//    for (int i=0; i<array.count; i++) {
//        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame=CGRectMake(intorval + i*(btnW+intorval), 0, btnW, btnW);
//        [bgView addSubview:btn];
//        btn.backgroundColor=[UIColor yellowColor];
//        btn.tag=i;
//        [btn setTitle:[NSString stringWithFormat:@"%@%@",a[i],[array[i] stringValue]] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        btn.layer.cornerRadius=btnW/2;
//        btn.clipsToBounds=YES;
//    }
//}
-(void)detailBottomViewWithIndex:(NSInteger)num
{
    if(num == 1)
    {
        if(isShare)
        {
            CGRect frame=_shareView.frame;
            frame.origin.y=0;
            _shareView.frame=frame;
            [self.view bringSubviewToFront:_shareView];
        }
    }
}
-(void)shareAppViewWithShareText:(NSString *)text andShareIcon:(NSString *)icon andShareKind:(NSString *)kind
{
    [[UMSocialControllerService defaultControllerService] setShareText:text shareImage:icon socialUIDelegate:self];
    
    [UMSocialSnsPlatformManager getSocialPlatformWithName:kind].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
}
//-(void)shareClick:(UIButton *)btn
//{
//    NSLog(@"%ld",btn.tag);
//    
//}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"contentSize"]) {
//        
//        bgView.frame = CGRectMake(0,self.web.scrollView.contentSize.height-btnW-30,btnW ,btnW);
//        _bottomFrame=bgView.frame;
//    }
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y+200;
    
    
    if(offsetY<0)
    {
        CGRect frame=self.image.frame;
        frame.size.width=_f.size.width-offsetY*2;
        frame.size.height=_f.size.height-offsetY;
        frame.origin.x=_f.origin.x+offsetY;
        frame.origin.y=_f.origin.y+offsetY;
        self.image.frame=frame;
        
        CGRect labelFrame=_titleLabel.frame;
        labelFrame.origin.y=_l.origin.y-offsetY;
        labelFrame.origin.x=_l.origin.x-offsetY;
        _titleLabel.frame=labelFrame;
    }
    /*
        没解决的问题
     */
//    CGRect bottomBtnFrame=_detailBottomView.frame;
//    if(offsetY>scrollView.contentSize.height-460 && offsetY<scrollView.contentSize.height-430 )
//    {
//        bottomBtnFrame.origin.y=_bottomFrame.origin.y+offsetY-scrollView.contentSize.height-460;
//        bottomBtnFrame.origin.y=bottomBtnFrame.origin.y>_bottomFrame.origin.y+btnW?_bottomFrame.origin.y+btnW:bottomBtnFrame.origin.y;
//        _detailBottomView.frame=bottomBtnFrame;
//    }
//   
//    
//    if(offsetY < scrollView.contentSize.height-400&&offsetY>scrollView.contentSize.height-400-30)
//    {
//        CGRect bottomBtnFrame=_detailBottomView.frame;
//        bottomBtnFrame.origin.y-=1;
//        bottomBtnFrame.origin.y=bottomBtnFrame.origin.y<_bottomFrame.origin.y?_bottomFrame.origin.y:bottomBtnFrame.origin.y;
//        _detailBottomView.frame=bottomBtnFrame;
//        // NSLog(@"%f  %f  ",offsetY,scrollView.contentSize.height);
//    }
}

-(void)detailViewLoadDataFromServer
{
    NSLog(@"%@",_url);
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
                 _model=[DetailModel detailModelWithDict:dic];
                 [self.image setImageWithURL:[NSURL URLWithString:_model.cover_image_url]];

                 _titleLabel.text=_model.title;
                 
                 _detailBottomView.model=_model;
                 [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_model.content_url]]];
//                 [self addBtn];
                 
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error){
//             UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"暂无数据" preferredStyle:UIAlertControllerStyleAlert];
//             UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                 [self.navigationController popViewControllerAnimated:YES];
//             }];
//             
//             [alert addAction:action];
//             [self presentViewController:alert animated:YES completion:nil];
         }
     ];
    
}



@end
