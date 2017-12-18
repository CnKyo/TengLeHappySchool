//
//  MWXMLParserDictionary.h
//  TengleHappySchool
//
//  Created by mwi01 on 2017/6/7.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import <Foundation/Foundation.h>
enum {
    XMLDictionaryOptionsProcessNamespaces           = 1 << 0, // Specifies whether the receiver reports the namespace and the qualified name of an element.
    XMLDictionaryOptionsReportNamespacePrefixes     = 1 << 1, // Specifies whether the receiver reports the scope of namespace declarations.
    XMLDictionaryOptionsResolveExternalEntities     = 1 << 2, // Specifies whether the receiver reports declarations of external entities.
};
typedef NSUInteger XMLDictionaryOptions;

@interface MWXMLParserDictionary : NSObject<NSXMLParserDelegate>

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLData:(NSData *)data options:(XMLDictionaryOptions)options error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string options:(XMLDictionaryOptions)options error:(NSError **)errorPointer;


@end
