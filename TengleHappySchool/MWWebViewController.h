//
//  MWWebViewController.h
//  TengleHappySchool
//
//  Created by mwi01 on 2017/5/24.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
#pragma mark----****----工具类
@interface MWUtil : NSObject
#pragma mark----****----获取当前json格式配置文件
/**
 获取当前json格式配置文件
 
 @param mJsonPath json文件路径
 @param mType 类型为json格式
 @return 返回数据字典
 */
+ (NSDictionary *)MWCurrentJsonConfigration:(NSString *)mJsonPath ofType:(NSString *)mType;
#pragma mark----****----判断是否首次使用app
/**
 首次使用app
 
 @return 返回bool值
 */
+ (BOOL)MWFirstLaunchApp;
#pragma mark----****----16进制颜色转化
/**
 16进制颜色转化

 @param color 16进制颜色值
 @return 转换为UICcolor（RGB）
 */
+ (UIColor *)MWColorWithHexString:(NSString *)color;

/**
 取出本地数据
 @return 数据键值key
 */
+ (MWAppConfig *)MWGetLocalData:(id)mData toKey:(NSString *)mKey;

/**
 字符串切割

 @param mText 要切割什么样的字符
 @param mCutter 切割关键字
 @return 返回数组
 */
+ (NSArray *)MWCutterStringWithText:(NSString *)mText cutterText:(NSString *)mCutter;

@end

@interface MWWebViewController : UIViewController


@end
