//
//  MWTabViewController.m
//  TengleHappySchool
//
//  Created by mwi01 on 2017/5/24.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "MWTabViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MWNavViewController.h"
#import "MWWebViewController.h"
#import "WKHeader.h"
@class MWUtil;
@interface MWTabViewController ()

@end

@implementation MWTabViewController
{
    MWAppConfig *mAppConfig;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mAppConfig = [MWAppConfig searchWithWhere:nil][0];
    
    //设置文字的属性
    [self setUpItemTitleTextAttrs];
    //添加子控件
    [self setUpChildVcs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 添加子控制器
 */
- (void)setUpChildVcs
{
    for (int i = 0; i<mAppConfig.tabBar.list.count; i++) {
        
        MWTabList *mTab = mAppConfig.tabBar.list[i];
        NSString *mImage = [MWUtil MWCutterStringWithText:mTab.iconPath cutterText:@"/"][1];
        NSString *mSelectedImage = [MWUtil MWCutterStringWithText:mTab.selectedIconPath cutterText:@"/"][1];

        [self setUpOneChildVc:[[MWNavViewController alloc] initWithRootViewController:[[MWWebViewController alloc] init]] title:mTab.text image:mImage selectedImage:mSelectedImage];

        
    }    
    
}
- (void)setUpOneChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    UIImageView *mImg = [UIImageView new];
    [mImg sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:nil];
    
    UIImageView *mSelectedImg = [UIImageView new];
    [mSelectedImg sd_setImageWithURL:[NSURL URLWithString:selectedImage] placeholderImage:nil];
    
    childVc.tabBarItem.title = title;
    if (image.length) childVc.tabBarItem.image = mImg.image;
    if (selectedImage.length) childVc.tabBarItem.selectedImage = mSelectedImg.image;
    [self addChildViewController:childVc];
    
}


- (void)setUpItemTitleTextAttrs
{
    
    self.tabBar.tintColor = [MWUtil MWColorWithHexString:mAppConfig.tabBar.color];
    
    //设置tabbar边缘线
    self.tabBar.layer.borderWidth = 0.50;
    self.tabBar.layer.borderColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:0.3].CGColor;
    
    //设置normal状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //设置selected状态下的文字属性
    NSMutableDictionary *selectedArrts= [NSMutableDictionary dictionary];
    selectedArrts[NSForegroundColorAttributeName] = [MWUtil MWColorWithHexString:mAppConfig.window.navigationBarBackgroundColor];
    
    //利用Appearance对象同意设置文字属性
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedArrts forState:UIControlStateSelected];
    
}



@end
