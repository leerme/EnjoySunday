//
//  UITableViewCell+initcell.m
//  美食
//
//  Created by qianfeng on 15-9-22.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import "UITableViewCell+initcell.h"

@implementation UITableViewCell (initcell)

+(id)cellWithTableView:(UITableView *)tableView
{
    NSString * className = NSStringFromClass([self class]);
    
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    
    //如果有可重用的返回,如果没有可重用的创建一个新的返回
    return [tableView dequeueReusableCellWithIdentifier:className];
}

@end
