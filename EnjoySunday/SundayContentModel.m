//
//  SundayContentModel.m
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import "SundayContentModel.h"

@implementation SundayContentModel

+(id)sundayContentModelWithDict:(NSDictionary *)dic;
{
    return [[self alloc] initWithDict:dic];
}

-(id)initWithDict:(NSDictionary *)dic
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
    {
        _ID=value;
    }
}
@end

@implementation LoopViewModel

+(id)loopViewModelWithDict:(NSDictionary *)dic;
{
    return [[self alloc] initWithDict:dic];
}

-(id)initWithDict:(NSDictionary *)dic
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation LoopContentModel

+(id)loopContentModelWithDict:(NSDictionary *)dic;
{
    return [[self alloc] initWithDict:dic];
}

-(id)initWithDict:(NSDictionary *)dic
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
    {
        _ID=value;
    }
}
@end

@implementation DetailModel

+(id)detailModelWithDict:(NSDictionary *)dic;
{
    return [[self alloc] initWithDict:dic];
}

-(id)initWithDict:(NSDictionary *)dic
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //    if([key isEqualToString:@"id"])
    //    {
    //        _ID=value;
    //    }
}
@end


@implementation SearchModel

+(id)searchModelWithDict:(NSDictionary *)dic;
{
    return [[self alloc] initWithDict:dic];
}

-(id)initWithDict:(NSDictionary *)dic
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
    {
        _ID=value;
    }
    if([key isEqualToString:@"description"])
    {
        _desc=value;
    }
}
@end
