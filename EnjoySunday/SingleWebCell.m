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
        //_webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}

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
    
}

- (void)setModel:(SingleClickedModel *)model
{
    _model = model;
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.url]]];
    [self.webView loadHTMLString:model.detail_html baseURL:nil];
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
