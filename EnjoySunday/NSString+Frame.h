//
//  NSString+Frame.h
//  FunnyLife
//
//  Created by qianfeng on 15-7-23.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Frame)

- (float) heightWithFont: (UIFont *) font withinWidth: (float) width;
- (float) widthWithFont: (UIFont *) font;

@end
