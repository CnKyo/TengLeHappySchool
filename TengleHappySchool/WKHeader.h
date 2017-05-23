//
//  WKHeader.h
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/9.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#ifndef WKHeader_h
#define WKHeader_h



//#define  WKSyncQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

#define ColorRGB(_R_, _G_, _B_)       ([UIColor colorWithRed:_R_/255.0f green:_G_/255.0f blue:_B_/255.0f alpha:1])

#define COLOR(r,g,b)                [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define COLOR_RGBA(r,g,b,a)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define M_TextColor1 [UIColor colorWithRed:49/255.0f green:50/255.0f blue:51/255.0f alpha:1.000]

#define NumberWithFloat(i)       [NSNumber numberWithFloat:i]
#define NumberWithInt(i)       [NSNumber numberWithInt:i]
#define NumberWithBool(i)       [NSNumber numberWithBool:i]
#define navigationBarColor RGB(33, 192, 174)

#define IMG(_File_)                 [UIImage imageNamed:_File_]


#define M_CO    [UIColor colorWithRed:65/255.0f green:149/255.0f blue:220/255.0f alpha:1.00]

#define VERSION [[UIDevice currentDevice].systemVersion doubleValue]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
//Demo:  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5")) [super viewWillLayoutSubviews];


#define DeviceIsRetina()				([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640.0, 960.0), [[UIScreen mainScreen] currentMode].size) : NO)
#define DeviceIsiPod()                  ([[[UIDevice currentDevice] systemName] isEqualToString:@"iPod touch"])
#define DeviceIsiPod5()                 ([[[UIDevice currentDevice] systemName] isEqualToString:@"iPod touch"] && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define DeviceIsiPhone()				([[UIScreen mainScreen] bounds].size.height == 480.0)
#define DeviceIsiPhone5()				([[UIScreen mainScreen] bounds].size.height == 568.0)
#define DeviceIsiPad()                  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define SystemIsiOS4()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 4.0 && [[[UIDevice currentDevice] systemVersion] doubleValue] < 5.0)
#define SystemIsiOS5()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 5.0 && [[[UIDevice currentDevice] systemVersion] doubleValue] < 6.0)
#define SystemIsiOS6()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 6.0)
#define SystemIsiOS7()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)//判断是否为IOS7
#define SystemIsiOS8()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)//判断是否为IOS8
#define DEVICE_StatuBar_Height          (20.0)


#define DEVICE_NavBar_Height            (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)?64.0:44.0f)
#define DEVICE_TabBar_Height            (50.0)
#define DEVICE_Width                    ([[UIScreen mainScreen] bounds].size.width)
#define DEVICE_Height                   ([[UIScreen mainScreen] bounds].size.height)
#define DEVICE_InStatusBar_Height       ([[UIScreen mainScreen] bounds].size.height - DEVICE_StatuBar_Height)
#define DEVICE_InNavTabBar_Height       ([[UIScreen mainScreen] bounds].size.height - DEVICE_NavBar_Height - DEVICE_TabBar_Height)
#define DEVICE_InNavBar_Height          (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)?[[UIScreen mainScreen] bounds].size.height-64.0:[[UIScreen mainScreen] bounds].size.height-64.0f)
#define DEVICE_StatuNavBar_Height       (DEVICE_StatuBar_Height + DEVICE_NavBar_Height)
#define DEVICE_ContentView_Height (DEVICE_Height - DEVICE_InStatusBar_Height)
#define TOP_Height                      (DEVICE_StatuBar_Height+DEVICE_NavBar_Height)

#define NAVBAR_Height            64.0

#define PerDeviceWidth(__NUMBER__)      (DEVICE_Width * __NUMBER__)
#define PerDeviceHeight(__NUMBER__)     (DEVICE_Height * __NUMBER__)

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

#ifdef DEBUG
#define MLLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define MLLog(format, ...)
#endif

#define INDEXPATH_SUBVIEW_TABLEVIEW(subview,tableview)\
({\
CGRect subviewFrame = [subview convertRect:subview.bounds toView:tableview];\
NSIndexPath *indexPath = [tableview indexPathForRowAtPoint:subviewFrame.origin];\
indexPath;\
})\

#define CELL_SUBVIEW_TABLEVIEW(subview,tableview)\
({\
CGRect subviewFrame = [subview convertRect:subview.bounds toView:tableview];\
NSIndexPath *indexPath = [tableview indexPathForRowAtPoint:subviewFrame.origin];\
UITableViewCell *cell=[tableview cellForRowAtIndexPath:indexPath];\
cell;\
})\

///火车票查询key
static NSString* const kMobTrainDemandKey                   = @"cdfd2af73a77";
///火车票api接口地址
static NSString* const kMobTainAPIURLString                 = @"http://apicloud.mob.com/train/tickets/";

///api访问地址
static NSString* const  kAFAppDotNetApiBaseURLString        = @"http://app.china-cr.com";
static NSString* const  kAFAppDotNetApiExtraURLString       = @"/api/app/client";
static NSString* const  kAFAppDotNetApiServiceURLString     = @"/api/app/service";
static NSString* const  kAFAppDotNetImgBaseURLString        = @"http://resource.china-cr.com/resource";




static inline NSString *StringWithInteger(NSInteger _Value_)
{
    return [NSString stringWithFormat:@"%li",(long)_Value_];
}
static inline NSString *StringWithInt(int _Value_)
{
    return [NSString stringWithFormat:@"%i",_Value_];
}
static inline NSString *StringWithBool(BOOL _Value_)
{
    return [NSString stringWithFormat:@"%i",_Value_];
}
static inline NSString *StringWithDouble(double _Value_)
{
    return [NSString stringWithFormat:@"%.2f",_Value_];
}

typedef enum {
    kTableNote_Nothing,//空
    kTableNote_NoData,//无数据
    kTableNote_ConError,//链接错误
    kTableNote_ConErrorTimedOut,//链接超时错误
    kTableNote_UpdateError,//下载错误
    kTableNote_UpdateOK,//下载成功
    kTableNote_NoRecord,//暂无记录
} kTableNoteType;

///列表刷新状态
typedef NS_ENUM(int,UITableViewRefreshStatus){
    UITableViewHeaderRefreshing = 1,///头部刷新
    UITableViewFooterRefreshing = 2,///底部刷新
};

///自定义弹出框样式
typedef NS_ENUM(NSInteger,WKCustomPopViewType) {
    WKCustomPopViewSucess = 1,///成功
    WKCustomPopViewError = 2,///失败
    WKCustomPopViewHaveCloseBtn = 3,///有关闭按钮
    WKCustomPopViewHaveTwoBtn = 4,///有2个按钮
    
};
///编辑用户信息按钮点击类型
typedef NS_ENUM(NSInteger,WKEditUserInfoClicked) {

    WKEditUserInfoAvatorClick = 1,///头像
    WKEditUserInfoUsernameClick = 2,///用户名
    WKEditUserInfoPhoneClick = 3,///电话号码
    WKEditUserInfoRealnameClick = 4,///真实姓名
    WKEditUserInfoUsercodeClick = 5,///证件号
    WKEditUserInfoChangePwdClick = 6,///修改密码
    WKEditUserInfoLogoutClick = 7,///退出登录
    
};

///联系我们or帮助中心
typedef NS_ENUM(NSInteger,WKConnectUsOrHelpCenterType) {
    
    WKConnectUs = 1,///联系我们
    WKHelpCenter = 2,///帮助中心
};

//-----------------------
//自定义的写在下面，通用的写在上面
//-----------------------

// 格式 0xff3737
#define JHUDRGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define JHUDRGBA(r,g,b,a)     [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define COLOR_NavBar                COLOR(150, 200, 43)
#define COLOR_LowNavBar             [UIColor colorWithRed:0.761 green:0.914 blue:0.769 alpha:1.000]
#define COLOR_BtnBar                [UIColor colorWithRed:0.980 green:0.675 blue:0.082 alpha:1.000]
#define TABLE_PAGE_ROW              20  //每次页面调用20条数据


#endif /* WKHeader_h */
