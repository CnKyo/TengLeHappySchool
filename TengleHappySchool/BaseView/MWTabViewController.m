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
    NSMutableArray *mImageArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mAppConfig = [MWAppConfig searchWithWhere:nil][0];
    mImageArr = [NSMutableArray new];
    [self uploadImages];
    //设置文字的属性
    [self setUpItemTitleTextAttrs];
    //添加子控件
    [self setUpChildVcs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)uploadImages{
    [mImageArr removeAllObjects];
    for (int i = 0; i<mAppConfig.tabBar.list.count; i++) {
        
        MWTabList *mTabObj = mAppConfig.tabBar.list[i];

        NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        MLLog(@"保存路径:%@",documentsDirectoryPath);
        //Get Image From URL
        UIImage * imageFromURL = [MWUtil MWGetImageFromURL:@"http://www.iconpng.com/png/flaticon_user-set/young6.png"];
        
        //Save Image to Directory
        [MWUtil MWSaveImage:[self scaleImg:imageFromURL maxsize:30] withFileName:[NSString stringWithFormat:@"%@n",mTabObj.text] ofType:@"png" inDirectory:documentsDirectoryPath];
        
        //Load Image From Directory
        UIImage * imageFromWeb = [MWUtil MWLoadLocalImage:[NSString stringWithFormat:@"%@n",mTabObj.text] ofType:@"png" inDirectory:documentsDirectoryPath];
       
        mTabObj.mTabBarNormalImage = imageFromWeb;

        //Get Image From URL
        UIImage * imageFromURL2 = [MWUtil MWGetImageFromURL:@"http://www.iconpng.com/png/flaticon_user-set/young6.png"];
        
        //Save Image to Directory
        [MWUtil MWSaveImage:[self scaleImg:imageFromURL2 maxsize:30] withFileName:[NSString stringWithFormat:@"%@s",mTabObj.text] ofType:@"png" inDirectory:documentsDirectoryPath];
        
        //Load Image From Directory
        UIImage * imageFromWeb2 = [MWUtil MWLoadLocalImage:[NSString stringWithFormat:@"%@s",mTabObj.text] ofType:@"png" inDirectory:documentsDirectoryPath];
        
        
        mTabObj.mTabBarSelectedImage = imageFromWeb2;

        [mImageArr addObject:mTabObj];
        //        [mTabObj.mTabBarNormalImage setImage:imageFromWeb];
        
        //取得目录下所有文件名
        NSArray *file = [[[NSFileManager alloc] init] subpathsAtPath:documentsDirectoryPath];
        //MLLog(@"%d",[file count]);
        MLLog(@"%@",file);
    }
}
/**
 添加子控制器
 */
- (void)setUpChildVcs
{
    for (int i = 0; i<mAppConfig.tabBar.list.count; i++) {
        
        MWTabList *mTab = mAppConfig.tabBar.list[i];

        [self setUpOneChildVc:[[MWNavViewController alloc] initWithRootViewController:[[MWWebViewController alloc] init]] title:mTab.text image:mTab.mTabBarNormalImage selectedImage:mTab.mTabBarSelectedImage];

        
    }    
    
}
- (void)setUpOneChildVc:(UIViewController *)childVc title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    
    
    childVc.tabBarItem.title = title;
//    childVc.tabBarItem.image = [self scaleImg:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] maxsizeW:25];
//    childVc.tabBarItem.selectedImage = [self scaleImg:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] maxsizeW:25];

    
    childVc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    [self addChildViewController:childVc];
    
}
-(UIImage*)scaleImg:(UIImage*)img maxsizeW:(CGFloat)maxW //缩放图片,,最大多少
{
    
    UIImage* retimg = nil;
    
    CGFloat h;
    CGFloat w;
    
    if( img.size.width > maxW )
        {
        w = maxW;
        h = (w / img.size.width) * img.size.height;
        }
    else
        {
        w = img.size.width;
        h = img.size.height;
        return img;
        }
    
    UIGraphicsBeginImageContext( CGSizeMake(w, h) );
    
    [img drawInRect:CGRectMake(0, 0, w, w)];
    retimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return retimg;
}
//缩放图片
-(UIImage*)scaleImg:(UIImage*)org maxsize:(CGFloat)maxsize
{
    
    UIImage* retimg = nil;
    
    CGFloat h;
    CGFloat w;
    if( org.size.width > org.size.height )
        {
        if( org.size.width > maxsize )
            {
            w = maxsize;
            h = (w / org.size.width) * org.size.height;
            }
        else
            {
            w = org.size.width;
            h = org.size.height;
            return org;
            }
        }
    else
        {
        if( org.size.height > maxsize )
            {
            h = maxsize;
            w = (h / org.size.height) * org.size.width;
            }
        else
            {
            w = org.size.width;
            h = org.size.height;
            return org;
            }
        }
    
    UIGraphicsBeginImageContext( CGSizeMake(w, h) );
    
    [org drawInRect:CGRectMake(0, 0, w, h)];
    retimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return retimg;
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
