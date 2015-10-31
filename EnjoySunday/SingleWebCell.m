//
//  SingleWebCell.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/24.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "SingleWebCell.h"

@interface SingleWebCell ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end


@implementation SingleWebCell

- (void)awakeFromNib {
    // Initialization code
}

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 375, 875)];
        [self.contentView addSubview:_webView];
        _webView.delegate = self;
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}



- (void)setModel:(SingleClickedModel *)model
{
    _model = model;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.url]]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//   
//    CGFloat height = self.webView.scrollView.contentSize.height;
//     NSLog(@"height%f",height);
//    self.webView.frame = CGRectMake(0, 0, self.bounds.size.width, height);
//    if (self.singWebCellFinishLoadBlock) {
//        self.singWebCellFinishLoadBlock(height);
//    }
//   
//}


@end
