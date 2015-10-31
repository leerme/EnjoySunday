//
//  ShareAppView.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/27.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "ShareAppView.h"
#import "UMSocial.h"
@interface ShareAppView()

@property(nonatomic)NSArray *shareArray;

@end


@implementation ShareAppView

+(id)shareAppView
{
    return [[self alloc] init];
}


-(id)init
{
    if(self = [super init])
    {
        self.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor=[UIColor clearColor];
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    NSArray *nameArray=@[@"微信好友",@"朋友圈",@"QQ空间",@"QQ好友",@"新浪微博",@"腾讯微博",@"短信",@"邮件"];
    _shareArray=@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToSina,UMShareToTencent,UMShareToSms,UMShareToEmail];
    NSArray *iconArray=@[@"UMS_wechat_icon",@"UMS_wechat_timeline_icon",@"UMS_qzone_icon",@"UMS_qq_icon",@"UMS_sina_icon",@"UMS_tencent_icon",@"UMS_sms_icon",@"UMS_email_icon"];
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-250, self.frame.size.width, 250)];

    [self addSubview:bgView];
    bgView.backgroundColor=[UIColor grayColor];
    CGFloat btnW=60;
    CGFloat btnH=btnW;
    CGFloat intoval=(self.frame.size.width-4*btnW)/5;
    CGFloat btnY=0;
    CGFloat btnX=intoval;
    for(int i=0;i<nameArray.count;i++)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [bgView addSubview:btn];
        [btn setImage:[UIImage imageNamed:iconArray[i]] forState:UIControlStateNormal];
       
        btn.layer.cornerRadius=20;
        btn.clipsToBounds=YES;
        btn.tag=i;
        [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        btnY=i<4?0:btnH+30;
        
        btnX=i%4==0?intoval:btnX+intoval+btnW;
        
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(btnX-intoval/4, btnY+btnH,btnW+intoval/4, 20)];
        name.text=nameArray[i];
        name.font=[UIFont systemFontOfSize:14];
        name.textAlignment=NSTextAlignmentCenter;
        [bgView addSubview:name];
    }
    
    UIButton *cancel=[UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:cancel];
    cancel.frame=CGRectMake(0, 210, self.frame.size.width, 40);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.backgroundColor=[UIColor colorWithWhite:0.111 alpha:1];
    cancel.layer.borderWidth=0.8;
    cancel.layer.borderColor=[UIColor blackColor].CGColor;
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
}
-(void)cancel
{
    CGRect frame=self.frame;
    frame.origin.y=self.frame.size.height;
    self.frame=frame;
}
-(void)shareClick:(UIButton *)btn
{
    NSString *shareText = [NSString stringWithFormat:@"如果你还在为周末做什么而烦恼，那就来过周末吧！"];
    NSString *shareIcon=@"AppIcon60x60";
    
    NSString *shareKind=_shareArray[btn.tag];
    
    [self.delegate shareAppViewWithShareText:shareText andShareIcon:shareIcon andShareKind:shareKind];
    
    /*
     [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:@"AppIcon60x60" socialUIDelegate:self.superview];
     
     [UMSocialSnsPlatformManager getSocialPlatformWithName:_shareArray[btn.tag]].snsClickHandler(self.superview,[UMSocialControllerService defaultControllerService],YES);
     */
}


@end
