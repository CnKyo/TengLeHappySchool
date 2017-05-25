//
//  AppDelegate.m
//  TengleHappySchool
//
//  Created by mwi01 on 2017/5/23.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "AppDelegate.h"
#import "WKHeader.h"
#import "MWWebViewController.h"
#import "MWTabViewController.h"

@class MWUtil;
@class MWAppConfig;
@interface AppDelegate ()

@end

@implementation AppDelegate
{
    MWAppConfig *mAPPConfig;
}
- (void)appInit{
    ///app.json文件参考微信小程序配置
    NSDictionary *config = [MWUtil MWCurrentJsonConfigration:@"app" ofType:@"json"];
    mAPPConfig = [MWAppConfig yy_modelWithJSON:config];
    if ([MWUtil MWFirstLaunchApp]) {
        MLLog(@"第一次启动");
        [mAPPConfig saveToDB];

    }else{
        MLLog(@"已经启动过");
    }
    
    NSMutableArray *mArr = [NSMutableArray new];
    mArr = [MWAppConfig searchWithWhere:nil];
    
//    [self tabbarInit];


//    [[UINavigationBar appearance] setTintColor:[MWUtil MWColorWithHexString:mAPPConfig.window.navigationBarBackgroundColor]];
    [[UINavigationBar appearance] setBarTintColor:[MWUtil MWColorWithHexString:mAPPConfig.window.navigationBarBackgroundColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:21], NSFontAttributeName, nil]];
    
    
    if ([mAPPConfig.window.backgroundTextStyle isEqualToString:@"light"]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    
    
}
- (void)tabbarInit{

    
    //设置窗口的根控制器
    self.window.rootViewController = [[MWTabViewController alloc] init];
    //显示窗口
    [self.window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self appInit];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
