//
//  QXBXMLModelTool.h
//  XMLParserDemo
//
//

#import <Foundation/Foundation.h>

@interface QXBModelTool : NSObject

/** 获取Json数据时传入字典和想要创建的model的名字 */
+ (void)createJsonModelWithDictionary:(NSDictionary *)dict modelName:(NSString *)modelName;

/** 获取XML数据时传入GDataXMLElement对象的XMLString和想要创建的model的名字 */
+ (void)createXMLModelWithXMLString:(NSString *)XMLString modelName:(NSString *)name;
@end
