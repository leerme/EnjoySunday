//
//  AllClickedViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "AllClickedViewController.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

#define NavigationBarHight 64.0f

#define ImageHight 200.0f

@interface AllClickedViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIWebView *web;
@property (nonatomic,strong)UIImageView *image;
@property (nonatomic,strong)UILabel *titleLabel;
@property(nonatomic)CGRect f;
@property(nonatomic)CGRect l;
@end

@implementation AllClickedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
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
    _web.scrollView.contentInset=UIEdgeInsetsMake(200, 0, 0, 0);
    self.web.scrollView.backgroundColor=[UIColor whiteColor];
    self.image=[[UIImageView alloc] initWithFrame:CGRectMake(0,-200, [UIScreen mainScreen].bounds.size.width, 200)];
    [self.web.scrollView addSubview:self.image];
    _f=self.image.frame;
    
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 160, [UIScreen mainScreen].bounds.size.width, 40)];
    _titleLabel.textColor=[UIColor whiteColor];
    _l=_titleLabel.frame;
    [self.image addSubview:_titleLabel];
    
    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.contentUrl]]];
     [self.image sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
    self.titleLabel.text = self.text;
}

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
}
//-(void)createHeaderView
//{
//    self.tableView.contentInset = UIEdgeInsetsMake(ImageHight, 0, 0, 0);
//    
//    _zoomImageView = [[UIImageView alloc]init];
//    
//    _zoomImageView.frame = CGRectMake(0, -ImageHight, self.view.frame.size.width, ImageHight);
//    [_zoomImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
//    //contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
//    _zoomImageView.contentMode = UIViewContentModeScaleAspectFill;//重点（不设置那将只会被纵向拉伸）
//    
//    [self.tableView addSubview:_zoomImageView];
//    
//    
//    
//    //设置autoresizesSubviews让子类自动布局
//    _label = [[UILabel alloc]initWithFrame:CGRectMake(20, ImageHight-40, 300, 20)];
//    _label.textColor = [UIColor whiteColor];
//    _label.text = self.text;
//    _label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
//    [_zoomImageView addSubview:_label];
//    
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    CGFloat y = scrollView.contentOffset.y+NavigationBarHight;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
//    if (y < -ImageHight) {
//        CGRect frame = _zoomImageView.frame;
//        frame.origin.y = y;
//        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
//        _zoomImageView.frame = frame;
//    }
//    
//}
//
//
//#pragma mark - Table view data source
//
//-(void)createTableView
//{
//    //1.定义全局tableView
//    
//    //2.初始化_tableView
//    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    //3.设置代理，头文件也要包含 UITableViewDelegate,UITableViewDataSource
//    self.tableView.delegate = self;
//    [self.view addSubview:self.tableView];
//    
//}
//
//-(void)createAndShowWebView
//{
//    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
//    _webView.delegate = self;
//    [self.tableView addSubview:_webView];
//    
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.contentUrl]]];
//    
//    [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
//    UIScrollView *tempView=(UIScrollView *)[_webView.subviews objectAtIndex:0];
//    tempView.scrollEnabled=NO;
//}
//
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"contentSize"]) {
//        CGFloat height = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
//        self.tableView.contentSize = CGSizeMake(self.tableView.bounds.size.width, height);
//        _webView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, height);
//    }
//}
////- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
////{
////    return YES;
////}
////
////- (void)webViewDidStartLoad:(UIWebView *)webView
////{
////    CGFloat height = webView.scrollView.contentSize.height;
////    NSLog(@"%f",height);
////}
//
//-(void)viewWillDisappear:(BOOL)antimated{
//    [super viewWillDisappear:antimated];
//    [_webView.scrollView removeObserver:self
//                                    forKeyPath:@"contentSize" context:nil];
//}

//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    NSLog(@"完成");
//    CGFloat height = webView.scrollView.contentSize.height;
//     NSLog(@"%f",height);
//    self.tableView.contentSize = CGSizeMake(self.tableView.bounds.size.width, height);
//    
//    _webView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, height);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
