//
//  OtherContentView.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OtherContentViewDelegate <NSObject>

-(void)otherContentViewWithID:(NSString *)key;

@end

@interface OtherContentView : UITableView

@property(nonatomic)NSString *count;
@property(nonatomic)id<OtherContentViewDelegate> _delegate;

+(id)otherContentView;

@end
