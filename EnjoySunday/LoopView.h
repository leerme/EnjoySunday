//
//  LoopView.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoopView : UIView

@property(nonatomic,copy)void(^imageClick)(NSInteger);
//@property(nonatomic,copy)NSInteger(^indexChange)(LoopView*);
@property(nonatomic) NSArray *imageArray;

+(id)loopView;

@end
