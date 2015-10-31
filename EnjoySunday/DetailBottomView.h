//
//  DetailBottomView.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/24.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SundayContentModel.h"

@protocol DetailBottomViewDelegate <NSObject>

-(void)detailBottomViewWithIndex:(NSInteger)num;

@end
@interface DetailBottomView : UIView

@property(nonatomic,weak)id<DetailBottomViewDelegate> delegate;
@property(nonatomic)DetailModel *model;

+(id)detailBottomView;

@end
