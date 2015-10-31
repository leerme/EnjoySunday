//
//  PingFengViewController.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/30.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "PingFengViewController.h"

@interface PingFengViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PingFengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"www.baidu.com"]]];
    
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
