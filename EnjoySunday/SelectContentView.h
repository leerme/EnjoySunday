//
//  SelectContentView.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectContentViewDelegate <NSObject>

-(void)selectContentViewWithID:(NSString *)key;
-(void)selectContentViewWithTabelViewID:(NSString *)key;
@end

@interface SelectContentView : UITableView

@property(nonatomic)NSArray *loopDataArray;
@property(nonatomic)NSArray *dataArray;
@property(nonatomic,weak)id<SelectContentViewDelegate> _delegate;

+(id)selectContentView;

@end
