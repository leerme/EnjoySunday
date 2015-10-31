//
//  ClassifyClick.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyClickModel : NSObject

@property (nonatomic, copy)NSString *content_url;
@property (nonatomic, copy)NSString *cover_image_url;
@property (nonatomic, copy)NSNumber *ID;
@property (nonatomic, copy)NSArray *label_ids;
@property (nonatomic) BOOL liked;
@property (nonatomic, copy)NSNumber *likes_count;
@property (nonatomic, copy)NSNumber *published_at;
@property (nonatomic, copy)NSString *share_msg;
@property (nonatomic, copy)NSString *short_title;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSNumber *status;
@property (nonatomic, copy)NSNumber *updated_at;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSNumber *created_at;
@property (nonatomic, copy)NSString *type;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)classifyClickModelWithDict:(NSDictionary *)dict;

@end
