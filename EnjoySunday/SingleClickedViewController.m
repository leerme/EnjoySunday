//
//  SingleClickedViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/24.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "SingleClickedViewController.h"
#import "AFNetworking.h"
#import "NetInterface.h"
#import "SingleClickedModel.h"
#import "SingleCnotentCell.h"
#import "NSString+Frame.h"
#import "SGActionView.h"
#import "UMSocial.h"
#import "UIKit+AFNetworking.h"
#import "MBProgressHUD.h"
@interface SingleClickedViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
{
    UIImageView *_titleImageView;
    UILabel *_priceLabel;
    UILabel *_descriptionLabel;
    UILabel *_titleLabel;
    UIActivityIndicatorView *_activityView;
    UIView *_indicatorView;
    UIView *_markView;
    UILabel *_tsLabel;
}
@property(nonatomic)UIWebView *webView;
@property(nonatomic)UIScrollView *scrollView;
@property (nonatomic, strong) SingleClickedModel *model;
@property (nonatomic, copy) NSString *url;
@property (nonatomic) CGFloat rowHeight;
@property(nonatomic)UIView *btnView;
@property(nonatomic)MBProgressHUD *hud;
@end

@implementation SingleClickedViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商品详情";
    self.view.backgroundColor=[UIColor whiteColor];
    self.url = [NSString stringWithFormat:SINGLE_MAIN_CLICK_URL,[self.ID stringValue]];
    [self loadDataFromServer];
    
    _hud=[[MBProgressHUD alloc] initWithView:self.view];
    _hud.center=self.view.center;
    _hud.labelText=@"正在加载...";
    [self.view addSubview:_hud];
    
    [_hud show:NO];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(rightClicked)];
    
}
//webView加载完成后执行
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    double width = _webView.frame.size.width - 10;
    NSString *js = [NSString stringWithFormat:@"var script = document.createElement('script');"
                    "script.type = 'text/javascript';"
                    "script.text = \"function ResizeImages() { "
                    "var myimg,oldwidth;"
                    "var maxwidth=%f;" //缩放系数
                    "for(i=0;i <document.images.length;i++){"
                    "myimg = document.images[i];"
                    "if(myimg.width > maxwidth){"
                    "oldwidth = myimg.width;"
                    "myimg.width = maxwidth;"
                    "myimg.height = myimg.height * (maxwidth/oldwidth)*2;"
                    "}"
                    "}"
                    "}\";"
                    "document.getElementsByTagName('head')[0].appendChild(script);",width];
    [_webView stringByEvaluatingJavaScriptFromString:js];
    
    [_webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
//    [_activityView removeFromSuperview];
    _webView.frame=CGRectMake(0,  CGRectGetMaxY(_btnView.frame)+5, self.view.frame.size.width, 300);
    [_hud hide:NO];
    _webView.frame=CGRectMake(0,  CGRectGetMaxY(_btnView.frame)+5, self.view.frame.size.width, _webView.scrollView.contentSize.height);
    _markView.frame=CGRectMake(0,  CGRectGetMaxY(_btnView.frame)+5, self.view.frame.size.width, _webView.scrollView.contentSize.height);
    _scrollView.contentSize=CGSizeMake(0, CGRectGetMaxY(_webView.frame));
}

- (void)rightClicked
{
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
             [self createContent];
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         }
     ];
}

-(void)createContent
{
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];
    
    _titleImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200)];
    [_titleImageView setImageWithURL:[NSURL URLWithString:self.model.cover_image_url]];
    [self.scrollView addSubview:_titleImageView];
    
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, _titleImageView.frame.size.height+70, self.view.frame.size.width-20, 30)];
    _titleLabel.font=[UIFont systemFontOfSize:15];
    _titleLabel.textColor=[UIColor lightGrayColor];
    _titleLabel.text=self.model.name;
    _titleLabel.numberOfLines=0;
    [_titleLabel sizeToFit];
    [self.scrollView addSubview:_titleLabel];
    
    _priceLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLabel.frame)+6, 200, 30)];
    _priceLabel.textColor=GLOBLE_COLOR;
    _priceLabel.font=[UIFont systemFontOfSize:16];
    _priceLabel.text=[NSString stringWithFormat:@"%@元",_model.price];
    [self.scrollView addSubview:_priceLabel];
    
    _descriptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_priceLabel.frame), self.view.frame.size.width-20, 30)];
    _descriptionLabel.text=self.model.desc;
    _descriptionLabel.numberOfLines=0;
    _descriptionLabel.textColor=[UIColor blackColor];
    [_descriptionLabel sizeToFit];
    [self.scrollView addSubview:_descriptionLabel];
    
    [self createBtn];
    [self.scrollView addSubview:_btnView];
    
    
    _webView=[[UIWebView alloc] init];
    _webView.delegate=self;
    [self.scrollView addSubview:_webView];
    _webView.scrollView.scrollEnabled=NO;
    [_webView loadHTMLString:_model.detail_html baseURL:nil];
    
    _markView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_btnView.frame), self.view.frame.size.width, 100)];
    [self.scrollView addSubview:_markView];
    _markView.backgroundColor=[UIColor whiteColor];
    
    _tsLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 300, 40)];
    _tsLabel.text=@"暂无评论(0)";
    _tsLabel.textAlignment=NSTextAlignmentCenter;
    [_markView addSubview:_tsLabel];
    
    _markView.hidden=YES;
    _tsLabel.hidden=YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY=scrollView.contentOffset.y;
    if(offsetY>=CGRectGetMaxY(_descriptionLabel.frame)+5-64)
    {
        [_btnView removeFromSuperview];
        _btnView.frame=CGRectMake(0, 64, self.view.bounds.size.width - 1, 30);
        [self.view addSubview:_btnView];
    }else
    {
        [_btnView removeFromSuperview];
        _btnView.frame=CGRectMake(0, CGRectGetMaxY(_descriptionLabel.frame)+5, self.view.bounds.size.width - 1, 30);
        [_scrollView addSubview:_btnView];
    }
}
-(void)createBtn
{
    _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_descriptionLabel.frame)+5, self.view.bounds.size.width - 1, 30)];
    _btnView.backgroundColor = [UIColor whiteColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"图文介绍" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.frame = CGRectMake(0, 0, self.view.bounds.size.width/2, 30);
    button1.backgroundColor=[UIColor lightGrayColor];
    [button1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag=0;
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"评论" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.frame = CGRectMake(self.view.bounds.size.width/2 + 1, 0, self.view.bounds.size.width/2 - 2, 30);
    button2.tag=1;
    [button2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    button2.backgroundColor=[UIColor lightGrayColor];
    [_btnView addSubview:button1];
    [_btnView addSubview:button2];
    
    _indicatorView=[[UIView alloc] initWithFrame:CGRectMake(0,28, self.view.frame.size.width/2, 2)];
    _indicatorView.backgroundColor=GLOBLE_COLOR;
    [_btnView addSubview:_indicatorView];
}
-(void)btnClick:(UIButton *)btn
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame=_indicatorView.frame;
        frame.origin.x=btn.tag*self.view.frame.size.width/2;
        _indicatorView.frame=frame;
    }];
    
    if(btn.tag==1)
    {
        _markView.hidden=NO;
        _tsLabel.hidden=NO;
    }else
    {
        _markView.hidden=YES;
        _tsLabel.hidden=YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
