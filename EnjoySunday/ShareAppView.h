//
//  ShareAppView.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/27.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareAppViewDelegate <NSObject>

-(void)shareAppViewWithShareText:(NSString *)text andShareIcon:(NSString *)icon andShareKind:(NSString *)kind;

@end

@interface ShareAppView : UIView

@property(nonatomic,weak)id<ShareAppViewDelegate> delegate;
+(id)shareAppView;

@end
