//
//  ClassifyModel.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CollectionsModel : NSObject

@property (nonatomic,copy) NSString *banner_image_url;
@property (nonatomic,copy) NSString *cover_image_url;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSNumber *created_at;
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSNumber *posts_count;
@property (nonatomic,copy) NSNumber *status;
@property (nonatomic,copy) NSNumber *updated_at;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic, copy)NSString *mainTitle;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)collectionsModelWithDict:(NSDictionary *)dict;

@end

@interface AllModel : NSObject

@property (nonatomic, copy)NSString *icon_url;
@property (nonatomic, copy)NSString *name;
@property (nonatomic,copy) NSNumber *group_id;
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSNumber *items_count;
@property (nonatomic,copy) NSNumber *order;
@property (nonatomic,copy) NSNumber *status;



- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)allModelWithDict:(NSDictionary *)dict;

@end