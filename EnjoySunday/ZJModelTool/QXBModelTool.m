//
//  QXBXMLModelTool.m
//  XMLParserDemo
//
//

#import "QXBModelTool.h"

@implementation QXBModelTool

/** 获取Json数据时传入字典和想要创建的model的名字 */
+(void)createJsonModelWithDictionary:(NSDictionary *)dict modelName:(NSString *)modelName
{
    printf("\n@interface %s :NSObject\n",modelName.UTF8String);
    for (NSString *key in dict) {
        NSString *type = ([dict[key] isKindOfClass:[NSNumber class]])?@"NSNumber":@"NSString";
        printf("@property (nonatomic,copy) %s *%s;\n",type.UTF8String,key.UTF8String);
    }
    printf("@end\n");
    
}


/** 获取XML数据时传入GDataXMLElement对象的XMLString和想要创建的model的名字 */
+ (void)createXMLModelWithXMLString:(NSString *)XMLString modelName:(NSString *)modelName{
    
    printf("\n@interface %s :NSObject\n",modelName.UTF8String);
    
    int index=-1;
    NSString *string = XMLString;
    for(int i=0;i<string.length-1;i++){
        char a=[string characterAtIndex:i];
        char b=[string characterAtIndex:i+1];
        NSMutableString *mString = [[NSMutableString alloc]init];
        if(a=='<'&&((b>='a'&&b<='z')||(b>='A'&&b<='Z'))){
            
            index = i+1;
            
            if(index == 1){
                continue;
            }
            
            char c = [string characterAtIndex:index];
            while(c!='>'){
                [mString appendFormat:@"%c",c];
                index++;
                c = [string characterAtIndex:index];
            }
            printf("@property (copy,nonatomic) NSString *%s\n",mString.UTF8String);
        }
        
    }
    printf("@end\n");
}
@end
