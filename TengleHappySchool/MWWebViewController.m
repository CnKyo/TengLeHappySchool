//
//  MWWebViewController.m
//  TengleHappySchool
//
//  Created by mwi01 on 2017/5/24.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "MWWebViewController.h"
#import <WebKit/WebKit.h>
#import "WKHeader.h"
#import "MWModel.h"
#import <objc/runtime.h>

@implementation MWUtil

#pragma mark----****----获取当前json格式配置文件
/**
 获取当前json格式配置文件
 
 @param mJsonPath json文件路径
 @param mType 类型为json格式
 @return 返回数据字典
 */
+ (NSDictionary *)MWCurrentJsonConfigration:(NSString *)mJsonPath ofType:(NSString *)mType{
    
    NSString *mjson = [[NSBundle mainBundle] pathForResource:mJsonPath ofType:mType];
    NSData *jsonData = [NSData dataWithContentsOfFile:mjson options:NSDataReadingMappedIfSafe error:nil];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
}
#pragma mark----****----判断是否首次使用app
/**
 首次使用app
 
 @return 返回bool值
 */
+ (BOOL)MWFirstLaunchApp{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        /// 这里判断是否第一次
        return YES;
    }else{
        return NO;
    }
}

#pragma mark----****----16进制颜色转化
/**
 16进制颜色转化
 
 @param color 16进制颜色值
 @return 转换为UICcolor（RGB）
 */
+ (UIColor *)MWColorWithHexString:(NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


/**
 保存本地数据
 
 @param mData 要保存的数据对象
 */
+ (void)MWSaveLocalData:(id)mData{
    [mData saveToDB];
}

/**
 取出本地数据
 @return 数据键值key
 */
+ (MWAppConfig *)MWGetLocalData:(id)mData toKey:(NSString *)mKey{

    NSMutableArray *mArr = [mData searchWithWhere:[NSString stringWithFormat:@"key=%@",mKey]];
    return mArr[0];
}
/**
 字符串切割
 
 @param mText 要切割什么样的字符
 @param mCutter 切割关键字
 @return 返回数组
 */
+ (NSArray *)MWCutterStringWithText:(NSString *)mText cutterText:(NSString *)mCutter
{
    return [mText componentsSeparatedByString:mCutter];
}



/**
 从网络获取图片
 
 @param fileURL 图片地址
 @return 返回图片
 */
+ (UIImage *)MWGetImageFromURL:(NSString *)fileURL{
    MLLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

/**
 保存图片到本地
 
 @param image 要保存的图片
 @param imageName 图片名称
 @param extension 文件类型
 @param directoryPath 文件路径
 */
+ (void)MWSaveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath{
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        //ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
        MLLog(@"文件后缀不认识");
    }
}

/**
 获取本地图片
 
 @param fileName 图片名称
 @param extension 类型
 @param directoryPath 路径
 @return 返回一张图片
 */
+ (UIImage *)MWLoadLocalImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath{
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    
    return result;
}





@end

@interface MWWebViewController ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate,UITabBarControllerDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;



@end
@class MWUtil;

@implementation MWWebViewController
{
    MWAppConfig *mAppConfig;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    mAppConfig = [MWAppConfig searchWithWhere:nil][0];
//    UIView *mTop = [UIView new];
//    mTop.frame = CGRectMake(0, 0, DEVICE_Width, 20);
//    mTop.backgroundColor = [MWUtil MWColorWithHexString:mAppConfig.window.navigationBarBackgroundColor];
//    [self.view addSubview:mTop];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tabBarController.delegate = self;
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc]init];
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    [config.userContentController addScriptMessageHandler:self name:@"AppModel"];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds
                                      configuration:config];
    
    
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:path]];
    [self.view addSubview:self.webView];
    
    // 导航代理
    self.webView.navigationDelegate = self;
    // 与webview UI交互代理
    self.webView.UIDelegate = self;
    
    // 添加KVO监听
    [self.webView addObserver:self
                   forKeyPath:@"loading"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    // 添加进入条
    self.progressView = [[UIProgressView alloc] init];
    self.progressView.frame = self.view.bounds;
    [self.view addSubview:self.progressView];
    self.progressView.backgroundColor = [UIColor redColor];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStyleDone target:self action:@selector(goback)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"前进" style:UIBarButtonItemStyleDone target:self action:@selector(gofarward)];
    
}

- (void)goback {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)gofarward {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

#pragma mark - WKScriptMessageHandler----****----按钮参数获取
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    
    //    MLLog(@"name:%@\n ----****---- body:%@\n ----****---- frameInfo:%@\n",message.name,message.body,message.frameInfo);
    
    MWModel *model = [MWModel yy_modelWithJSON:message.body];
    MLLog(@"最后得到的对象是：%@",model.body);
    ///oc 反调js
    if ([model.body.id isEqualToString:@"2"]) {
        NSString *ocTojs = [NSString stringWithFormat:@"alert('%s')","this is alertview pop to "];
        [self.webView evaluateJavaScript:ocTojs completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSLog(@"%@----%@",result, error);
        }];
    }else{
        MWWebViewController *vc = [MWWebViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    //    if ([message.name isEqualToString:@"AppModel"]) {
    //        // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
    //        // NSDictionary, and NSNull类型
    //        MLLog(@"%@", message.body);
    //    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"loading"]) {
        MLLog(@"loading");
    } else if ([keyPath isEqualToString:@"title"]) {
        self.navigationItem.title = self.webView.title;
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        MLLog(@"progress: %f", self.webView.estimatedProgress);
        self.progressView.progress = self.webView.estimatedProgress;
    }
    
    // 加载完成
    if (!self.webView.loading) {
        // 手动调用JS代码
        // 每次页面完成都弹出来，大家可以在测试时再打开
        //        NSString *js = @"callJsAlert()";
        //        [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        //            MLLog(@"response: %@ error: %@", response, error);
        //            MLLog(@"call js alert by native");
        //        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.progressView.alpha = 0;
        }];
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    
    //    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
    //        && ![hostname containsString:@".baidu.com"]) {
    //        // 对于跨域，需要手动跳转
    //        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
    //
    //        // 不允许web内跳转
    //        decisionHandler(WKNavigationActionPolicyCancel);
    //    } else {
    self.progressView.alpha = 1.0;
    decisionHandler(WKNavigationActionPolicyAllow);
    //    }
    
    MLLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
    MLLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    MLLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    MLLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    MLLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    MLLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    MLLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    MLLog(@"%s", __FUNCTION__);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    MLLog(@"%s", __FUNCTION__);
}

#pragma mark - WKUIDelegate
- (void)webViewDidClose:(WKWebView *)webView {
    MLLog(@"%s", __FUNCTION__);
}
#pragma mark----****----js调oc的alertview会先调用这个方法
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    MLLog(@"%s", __FUNCTION__);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert" message:@"JS调用alert" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    MLLog(@"%@", message);
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    MLLog(@"%s", __FUNCTION__);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"confirm" message:@"JS调用confirm" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
    MLLog(@"%@", message);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    MLLog(@"%s", __FUNCTION__);
    
    MLLog(@"%@", prompt);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}


/**
 *  对象转换为字典
 *
 *  @param obj 需要转化的对象
 *
 *  @return 转换后的字典
 */
- (NSDictionary*)getObjectData:(id)obj {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int i = 0;i < propsCount; i++) {
        
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil) {
            
            value = [NSNull null];
        } else {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    
    return dic;
}
- (id)getObjectInternal:(id)obj {
    
    if([obj isKindOfClass:[NSString class]]
       ||
       [obj isKindOfClass:[NSNumber class]]
       ||
       [obj isKindOfClass:[NSNull class]]) {
        
        return obj;
        
    }
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int i = 0; i < objarr.count; i++) {
            
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString *key in objdic.allKeys) {
            
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
    
}
#pragma mark----****----选项卡代理方法
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    MLLog(@"选中的索引是：%ld",tabBarController.selectedIndex);
    MWTabList *mTab = mAppConfig.tabBar.list[tabBarController.selectedIndex];

    
}
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
@end
