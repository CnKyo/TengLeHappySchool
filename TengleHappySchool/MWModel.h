//
//  MWModel.h
//  TengleHappySchool
//
//  Created by mwi01 on 2017/5/23.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKHeader.h"
#import <YTKNetwork.h>


@class body;
@interface MWModel : NSObject

@property (strong,nonatomic) body *body;

@end

@interface body : NSObject

@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *name;

@end
#pragma mark----****----app配置对象
@class MWWindow;
@class MWTabBar;
@interface MWAppConfig : NSObject
///页面
@property (strong,nonatomic) NSArray *pages;
///窗口
@property (strong,nonatomic) MWWindow *window;
///选项卡
@property (strong,nonatomic) MWTabBar *tabBar;

@property (assign,nonatomic) int key;


@end
#pragma mark----****----app配置对象-window
@interface MWWindow : NSObject
///文本背景类型
@property (strong,nonatomic) NSString *backgroundTextStyle;
///导航条背景色
@property (strong,nonatomic) NSString *navigationBarBackgroundColor;
///导航台文本
@property (strong,nonatomic) NSString *navigationBarTitleText;
///背景色
@property (strong,nonatomic) NSString *backgroundColor;
///导航条文本类型
@property (strong,nonatomic) NSString *navigationBarTextStyle;


@end
#pragma mark----****----app配置对象-tabbar
@class MWTabList;
@interface MWTabBar : NSObject
///颜色
@property (strong,nonatomic) NSString *color;
///选中颜色
@property (strong,nonatomic) NSString *selectedColor;
///边框类型
@property (strong,nonatomic) NSString *borderStyle;
///背景色
@property (strong,nonatomic) NSString *backgroundColor;
///tabbar View列表
@property (strong,nonatomic) NSArray *list;

@end

@interface MWTabList : NSObject
///页面文件路径
@property (strong,nonatomic) NSString *pagePath;
///图片路径
@property (strong,nonatomic) NSString *iconPath;
///选中图片路径
@property (strong,nonatomic) NSString *selectedIconPath;
///文本
@property (strong,nonatomic) NSString *text;

@property (strong,nonatomic) UIImage *mTabBarNormalImage;

@property (strong,nonatomic) UIImage *mTabBarSelectedImage;


@end

@class WXSSObj;
@interface WXCSS : NSObject

@property (strong,nonatomic) NSString *mName;

@property (strong,nonatomic) NSString *mSubname;

@property (strong,nonatomic) WXSSObj *mWXSS;

@end

@interface WXSSObj : NSObject

@property (strong,nonatomic) NSString *fontsize;

@property (strong,nonatomic) NSString *margintop;

@property (strong,nonatomic) NSString *width;

@property (strong,nonatomic) NSString *height;

@property (strong,nonatomic) NSString *borderradius;

@property (strong,nonatomic) NSString *marginleft;

@property (strong,nonatomic) NSString *marginright;

@property (strong,nonatomic) NSString *position;

@property (strong,nonatomic) NSString *border;

@property (strong,nonatomic) NSString *left;

@property (strong,nonatomic) NSString *overflow;

@property (strong,nonatomic) NSString *top;

@property (strong,nonatomic) NSString *backgroundcolor;

@property (strong,nonatomic) NSString *background;


@property (strong,nonatomic) NSString *display;

@property (strong,nonatomic) NSString *content;

@property (strong,nonatomic) NSString *clear;

@property (strong,nonatomic) NSString *textalign;

@property (strong,nonatomic) NSString *padding;

@property (strong,nonatomic) NSString *paddingbottom;

@property (strong,nonatomic) NSString *paddingtop;

@property (strong,nonatomic) NSString *borderbottom;

@property (strong,nonatomic) NSString *verticalalign;

@property (strong,nonatomic) NSString *color;

@property (strong,nonatomic) NSString *zindex;

@property (strong,nonatomic) NSString *fontweight;

@property (strong,nonatomic) NSString *outline;

@end
