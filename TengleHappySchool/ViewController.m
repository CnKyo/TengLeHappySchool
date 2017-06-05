//
//  ViewController.m
//  TengleHappySchool
//
//  Created by mwi01 on 2017/5/23.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "WKHeader.h"
#import "MWModel.h"
#import <objc/runtime.h>
#import "MWWebViewController.h"

@class MWUtil;
@interface ViewController ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate,NSXMLParserDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation ViewController
{
    NSMutableArray *mWXSSArr;
    NSMutableArray *mTarr;

    int mIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"测试页面";
    mIndex = 0;
    mWXSSArr = [NSMutableArray new];
    mTarr = [NSMutableArray new];

//    mCssObj = [WXCSS new];
//    mCssObj.mWXSS = [WXSSObj new];
    [self xmlparser];
}
- (void)xmlparser{
    [mWXSSArr removeAllObjects];
    NSString *wxssFile = [[NSBundle mainBundle] pathForResource:@"mine" ofType:@"wxss"];
    NSString *wxssFileContent = [[NSString alloc] initWithContentsOfFile:wxssFile encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *mCSSArr = [MWUtil MWCutterStringWithText:wxssFileContent cutterText:@"}"];
    
    MLLog(@"wxss文件是：%@",wxssFileContent);

    for (int i = 0 ; i<mCSSArr.count
         ; i++) {
        
        NSString *mCss = [NSString stringWithFormat:@"%@}",mCSSArr[i]];
        
        MLLog(@"css文件是：%@",mCss);
        if (mCss.length<=0 || [mCss isEqualToString:@" "] || mCss==nil || [mCss isEqualToString:@"\r\n\r\n}"]) {
            continue;
        }
        NSArray *mSubCss = [MWUtil MWCutterStringWithText:mCss cutterText:@"."];
        NSString *css = nil;
        if (mSubCss.count>3){
            css = [NSString stringWithFormat:@".%@.%@.%@",mSubCss[1],mSubCss[2],mSubCss[3]];
            
        }
        else  if (mSubCss.count>2) {
            css = [NSString stringWithFormat:@".%@.%@",mSubCss[1],mSubCss[2]];
            
        }
        else{
            css = [NSString stringWithFormat:@".%@",mSubCss[1]];

        }

        MLLog(@"最后的css文件是：%@",css);
        [mWXSSArr addObject:css];
        MLLog(@"ARR最后一个对象是：%@",[mWXSSArr lastObject]);
    }

    for (NSString *mCss in mWXSSArr) {
        MLLog(@"最后的css文件是：%@",mCss);
        
        NSArray *mSubCss = [MWUtil MWCutterStringWithText:mCss cutterText:@"{"];
        if (mSubCss.count<2) {
            continue;
        }
        NSString *mOne = mSubCss[0];
        NSString *mTwo = mSubCss[1];
        WXCSS *mCssObj = [WXCSS new];
        mCssObj.mName = mOne;
        mCssObj.mWXSS = [WXSSObj new];
        NSArray *mMargin = [MWUtil MWCutterStringWithText:mTwo cutterText:@";"];
        for (int i = 0; i<mMargin.count; i++) {

            NSString *mF = mMargin[i];
            
            if (mF.length<=0 || [mF isEqualToString:@" "] || mF==nil || [mF isEqualToString:@"\r\n}"]) {
                continue;
            }

            NSArray *mContent = [MWUtil MWCutterStringWithText:mF cutterText:@":"];
            

            for (int j = 0; j<mContent.count; j++) {
                

                NSString *mSubcontent = [self characterText:mContent[j]];
                if (j == mContent.count-1) {
                    continue;
                }
                if (mSubcontent.length<=0 || [mSubcontent isEqualToString:@" "] || mSubcontent==nil || [mSubcontent isEqualToString:@";"]) {
                    continue;
                }
                NSString *mPX = [self characterText:mContent[j+1]];

                if ([mSubcontent isEqualToString:@"font-size"]) {
                    mCssObj.mWXSS.fontsize = mPX;
                }
                if ([mSubcontent isEqualToString:@"margin-top"]) {
                    mCssObj.mWXSS.margintop = mPX;
                }
                if ([mSubcontent isEqualToString:@"width"]) {
                    mCssObj.mWXSS.width = mPX;
                }
                if ([mSubcontent isEqualToString:@"height"]) {
                    mCssObj.mWXSS.height = mPX;
                }
                if ([mSubcontent isEqualToString:@"border-radius"]) {
                    mCssObj.mWXSS.borderradius = mPX;
                }
                if ([mSubcontent isEqualToString:@"margin-left"]) {
                    mCssObj.mWXSS.marginleft = mPX;
                }      if ([mSubcontent isEqualToString:@"margin-right"]) {
                    mCssObj.mWXSS.marginright = mPX;
                }
                if ([mSubcontent isEqualToString:@"position"]) {
                    mCssObj.mWXSS.position = mPX;
                }
                if ([mSubcontent isEqualToString:@"border"]) {
                    mCssObj.mWXSS.border = mPX;
                }
                
                if ([mSubcontent isEqualToString:@"left"]) {
                    mCssObj.mWXSS.left = mPX;
                }
                if ([mSubcontent isEqualToString:@"overflow"]) {
                    mCssObj.mWXSS.overflow = mPX;
                }
                if ([mSubcontent isEqualToString:@"top"]) {
                    mCssObj.mWXSS.top = mPX;
                }
                if ([mSubcontent isEqualToString:@"backgroundcolor"]) {
                    mCssObj.mWXSS.backgroundcolor = mPX;
                }
                if ([mSubcontent isEqualToString:@"background"]) {
                    mCssObj.mWXSS.background = mPX;

                }
                if ([mSubcontent isEqualToString:@"display"]) {
                    mCssObj.mWXSS.display = mPX;
                }
                if ([mSubcontent isEqualToString:@"content"]) {
                    mCssObj.mWXSS.content = mPX;
                }
                if ([mSubcontent isEqualToString:@"clear"]) {
                    mCssObj.mWXSS.clear = mPX;
                }
                if ([mSubcontent isEqualToString:@"text-align"]) {
                    mCssObj.mWXSS.textalign = mPX;
                }
                if ([mSubcontent isEqualToString:@"padding"]) {
                    mCssObj.mWXSS.padding = mPX;
                }
                
                if ([mSubcontent isEqualToString:@"padding-bottom"]) {
                    mCssObj.mWXSS.paddingbottom = mPX;
                }
                if ([mSubcontent isEqualToString:@"padding-top"]) {
                    mCssObj.mWXSS.paddingtop = mPX;
                }
                if ([mSubcontent isEqualToString:@"border-bottom"]) {
                    mCssObj.mWXSS.borderbottom = mPX;
                }
                if ([mSubcontent isEqualToString:@"vertical-align"]) {
                    mCssObj.mWXSS.verticalalign = mPX;
                }
                if ([mSubcontent isEqualToString:@"color"]) {
                    mCssObj.mWXSS.color = mPX;
                }
                if ([mSubcontent isEqualToString:@"z-index"]) {
                    mCssObj.mWXSS.zindex = mPX;
                }
                if ([mSubcontent isEqualToString:@"font-weight"]) {
                    mCssObj.mWXSS.fontweight = mPX;
                }
                if ([mSubcontent isEqualToString:@"outline"]) {
                    mCssObj.mWXSS.outline = mPX;
                }
                mCssObj.mWXSS = mCssObj.mWXSS;

            }


        }
        [mTarr addObject:mCssObj];
    }
    
    MLLog(@"最后的css文件是：%@",mTarr);

    NSString *wxmlFile = [[NSBundle mainBundle] pathForResource:@"mine" ofType:@"wxml"];
    NSString *wxmlFileContent = [[NSString alloc] initWithContentsOfFile:wxmlFile encoding:NSUTF8StringEncoding error:nil];
    NSData *wxmlData = [[NSData alloc]initWithContentsOfFile:wxmlFile];
    
    [self XMLParserWithData:wxmlData];
}
//*利用 NSXMLParser 方式
-(void)XMLParserWithData:(NSData *)data{
    //1.创建NSXMLParser
    NSXMLParser *XMLParser = [[NSXMLParser alloc] initWithData:data];
    //2.设置代理
    [XMLParser setDelegate:self];
    //3.开始解析
    [XMLParser parse];
}
#pragma mark - NSXMLParserDelegate xml解析代理方法
//1.开始解析XML文件
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    MLLog(@"开始解析XML文件");
}
//2.解析XML文件中所有的元素
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    MLLog(@"解析XML文件中所有的元素:elementName:%@,attributeDict:%@",elementName,attributeDict);

    if ([elementName isEqualToString:@"view"]) {
        NSDictionary *dic = attributeDict;
        MLLog(@"elementName是:%@",elementName);
        for (WXCSS *mCssObj in mTarr) {
            
            if ([self rangeOfString:[attributeDict objectForKey:@"class"] ofText:mCssObj.mName]) {
                
                UIView *mView = [UIView new];
                mView.frame = self.view.bounds;
                [self.view addSubview:mView];
            }
        }
    }

    MLLog(@"一共执行了多少次：%d",mIndex);
    
    
}
//3.XML文件中每一个元素解析完成
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    MLLog(@"XML文件中每一个元素解析完成:elementName:%@,qName:%@",elementName,qName);
}
//4.XML所有元素解析完毕
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    MLLog(@"XML所有元素解析完毕:");
}

- (void)didReceiveMemoryWarning{
}


- (NSString *)characterText:(NSString *)mText{

    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@\r\n ／（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    
    return [mText stringByTrimmingCharactersInSet:set];
}
- (BOOL)rangeOfString:(NSString *)mString ofText:(NSString *)mText{

//    NSRange range = [mString rangeOfString:mText];
//    if (range.location!=NSNotFound) {
//        return YES;
//    }else{
//        return NO;
//    }
    
    
    if ([mString containsString:[self characterSpecilText:mText]]) {
        return YES;
    }else{
        return NO;
    }
}
- (NSString *)characterSpecilText:(NSString *)mText{
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@\r\n .／（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    
    return [mText stringByTrimmingCharactersInSet:set];
}
@end
