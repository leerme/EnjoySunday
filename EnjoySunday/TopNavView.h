//
//  TopNavView.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetInterface.h"

@protocol TopNavViewDelegate <NSObject>

-(void)topNavViewWithTag:(NSInteger)index;

@end

@interface TopNavView : UIView

@property(nonatomic,copy)NSArray *titleArray;
@property(nonatomic,copy)NSArray *viewArray;
@property(nonatomic)id<TopNavViewDelegate> delegate;

+(id)topNavView;
@end
