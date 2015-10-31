//
//  SingleMainModel.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleMainModel : NSObject

@property (nonatomic, copy)id brand_id;
@property (nonatomic, copy)id brand_order;
@property (nonatomic, copy)id category_id;
@property (nonatomic, copy)NSString *cover_image_url;
@property (nonatomic, copy)NSNumber *created_at;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSNumber *editor_id;
@property (nonatomic, copy)NSNumber *favorites_count;
@property (nonatomic, copy)NSNumber *ID;
@property (nonatomic, strong)NSArray *image_urls;
@property (nonatomic) BOOL is_favorite;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, strong)NSArray *post_ids;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)id purchase_id;
@property (nonatomic, copy)NSNumber *purchase_status;
@property (nonatomic, copy)NSNumber *purchase_type;
@property (nonatomic, copy)NSString *purchase_url;
@property (nonatomic, copy)id subcategory_id;
@property (nonatomic, copy)NSNumber *updated_at;
@property (nonatomic, copy)NSString *url;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)singleMainModelWithDict:(NSDictionary *)dict;

@end
