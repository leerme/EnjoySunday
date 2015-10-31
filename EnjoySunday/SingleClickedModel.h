//
//  SingleClickedModel.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/24.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleClickedModel :NSObject

@property (nonatomic,copy) NSString *desc;
@property (nonatomic,assign) BOOL *liked;
@property (nonatomic,copy) NSDictionary *source;
@property (nonatomic,copy) NSNumber *editor_id;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *purchase_url;
@property (nonatomic,copy) NSArray *image_urls;
@property (nonatomic,copy) NSNumber *updated_at;
@property (nonatomic,copy) NSNumber *comments_count;
@property (nonatomic,copy) NSNumber *purchase_type;
@property (nonatomic,copy) NSString *brand_id;
@property (nonatomic,assign) BOOL favorited;
@property (nonatomic,copy) NSString *detail_html;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSArray *post_ids;
@property (nonatomic,copy) NSNumber *favorites_count;
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSNumber *purchase_status;
@property (nonatomic,copy) NSNumber *shares_count;
@property (nonatomic,copy) NSString *purchase_id;
@property (nonatomic,copy) NSString *brand_order;
@property (nonatomic,copy) NSNumber *likes_count;
@property (nonatomic,copy) NSString *subcategory_id;
@property (nonatomic,copy) NSNumber *created_at;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *category_id;
@property (nonatomic,copy) NSString *cover_image_url;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)singleClickedModelWithDict:(NSDictionary *)dict;

@end