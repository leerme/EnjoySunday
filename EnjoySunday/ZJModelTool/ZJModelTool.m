//
//  ZJModelTool.m
//  MyDamaiProject
//
//  Created by quiet on 15/5/28.
//  Copyright (c) 2015年 quiet. All rights reserved.
//

#import "ZJModelTool.h"

@implementation ZJModelTool
//代码创建model类
+(void)createModelWithDictionary:(NSDictionary *)dict modelName:(NSString *)modelName
{
    printf("\n@interface %s :NSObject\n",modelName.UTF8String);
    for (NSString *key in dict) {
        NSString *type = ([dict[key] isKindOfClass:[NSNumber class]])?@"NSNumber":@"NSString";
        printf("@property (nonatomic,copy) %s *%s;\n",type.UTF8String,key.UTF8String);
    }
    printf("@end\n");
    
}
@end
