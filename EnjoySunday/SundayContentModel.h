//
//  SundayContentModel.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SundayContentModel : NSObject

@property(nonatomic)NSString *cover_image_url;
@property(nonatomic)NSString *title;
@property(nonatomic)NSString *content_url;
@property(nonatomic)NSNumber *created_at;
@property(nonatomic)NSNumber *likes_count;
@property(nonatomic)NSNumber *ID;
//@property(nonatomic)NSString *next_url;

+(id)sundayContentModelWithDict:(NSDictionary *)dic;
-(id)initWithDict:(NSDictionary *)dic;

@end


@interface LoopViewModel: NSObject

@property(nonatomic)NSString *image_url;
@property(nonatomic)NSNumber *target_id;

+(id)loopViewModelWithDict:(NSDictionary *)dic;
-(id)initWithDict:(NSDictionary *)dic;

@end

@interface LoopContentModel : NSObject

@property(nonatomic)NSString *cover_image_url;
@property(nonatomic)NSString *content_url;
@property(nonatomic)NSString *title;
@property(nonatomic)NSNumber *likes_count;
@property(nonatomic)NSNumber *ID;

+(id)loopContentModelWithDict:(NSDictionary *)dic;
-(id)initWithDict:(NSDictionary *)dic;

@end

@interface DetailModel : NSObject

@property(nonatomic)NSString *cover_image_url;
@property(nonatomic)NSString *content_url;
@property(nonatomic)NSString *title;
@property(nonatomic)NSNumber *likes_count;
@property(nonatomic)NSNumber *shares_count;
@property(nonatomic)NSNumber *comments_count;
//@property(nonatomic)NSNumber *ID;

+(id)detailModelWithDict:(NSDictionary *)dic;
-(id)initWithDict:(NSDictionary *)dic;

@end


@interface SearchModel : NSObject

@property (nonatomic, copy)NSString *cover_image_url;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSNumber *favorites_count;
@property (nonatomic, copy)NSNumber *ID;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *price;



+(id)searchModelWithDict:(NSDictionary *)dic;
-(id)initWithDict:(NSDictionary *)dic;
@end
