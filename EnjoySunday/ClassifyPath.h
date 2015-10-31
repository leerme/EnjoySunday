//
//  ClassifyPath.h
//  EnjoySunday
//
//  Created by qianfeng on 15/10/22.
//  Copyright © 2015年 lei yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyPath : NSObject


+ (NSString *) classifyCachePath;

+ (NSString *) allCachePath;

+ (NSString *) collectionAllCachePath;

+ (NSString *) singleMianCachePath;
@end
