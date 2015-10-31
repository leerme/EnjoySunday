//
//  AllClickedViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "AllClickedViewController.h"
#import "UIImageView+WebCache.h"
#define NavigationBarHight 64.0f

#define ImageHight 200.0f

@interface AllClickedViewController ()<UITableViewDelegate,UIWebViewDelegate>
{
    UIImageView *_zoomImageView;
    UIWebView *_webView;
    UILabel *_label;
}

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation AllClickedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    
    [self createHeaderView];
    
    [self createAndShowWebView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)createHeaderView
{
    self.tableView.contentInset = UIEdgeInsetsMake(ImageHight, 0, 0, 0);
    
    _zoomImageView = [[UIImageView alloc]init];
    
    _zoomImageView.frame = CGRectMake(0, -ImageHight, self.view.frame.size.width, ImageHight);
    [_zoomImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
    //contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
    _zoomImageView.contentMode = UIViewContentModeScaleAspectFill;//重点（不设置那将只会被纵向拉伸）
    
    [self.tableView addSubview:_zoomImageView];
    
    
    
    //设置autoresizesSubviews让子类自动布局
    _label = [[UILabel alloc]initWithFrame:CGRectMake(20, ImageHight-40, 300, 20)];
    _label.textColor = [UIColor whiteColor];
    _label.text = self.text;
    _label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
    [_zoomImageView addSubview:_label];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y+NavigationBarHight;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    if (y < -ImageHight) {
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _zoomImageView.frame = frame;
    }
    
}


#pragma mark - Table view data source

-(void)createTableView
{
    //1.定义全局tableView
    
    //2.初始化_tableView
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //3.设置代理，头文件也要包含 UITableViewDelegate,UITableViewDataSource
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
}

-(void)createAndShowWebView
{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
    _webView.delegate = self;
    [self.tableView addSubview:_webView];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.contentUrl]]];
    
    [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    UIScrollView *tempView=(UIScrollView *)[_webView.subviews objectAtIndex:0];
    tempView.scrollEnabled=NO;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGFloat height = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
        self.tableView.contentSize = CGSizeMake(self.tableView.bounds.size.width, height);
        _webView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, height);
    }
}
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    return YES;
//}
//
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//    CGFloat height = webView.scrollView.contentSize.height;
//    NSLog(@"%f",height);
//}

-(void)viewWillDisappear:(BOOL)antimated{
    [super viewWillDisappear:antimated];
    [_webView.scrollView removeObserver:self
                                    forKeyPath:@"contentSize" context:nil];
}

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
