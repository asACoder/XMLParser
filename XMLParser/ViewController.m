//
//  ViewController.m
//  XMLParser
//
//  Created by fushijian on 14-7-31.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "XMLParseToModel.h"
#import <objc/runtime.h>


@interface ViewController () <NSXMLParserDelegate>


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 1.解析 Model 含有 Model
    [self parseXML_ModelInModel];

    
//    // 2.解析 数组 含有 数组
//    [self parseXML_ArrayContainArray];
//
//    
//    // 3.解析带有属性的XML节点
//    [self parseXML_AttributeNode];
//    
//    // 4 解析 数组 含有 数组 且含有属性节点
//    [self parseComplexXml];

    
//    // 5 解析 继承 结构的Model
//    
//    [self parseModel];
    
}

-(void) parseModel
{
    NSString* str =  [[NSBundle mainBundle] pathForResource:@"people" ofType:@"xml"];
    NSString* xmlStr = [NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];
    id objc = [XMLParseToModel parseWithXML:xmlStr toClass:@"Worker"];
    
    // 断点打在此处
    NSLog(@"%@ ",objc);
}


//解析 Model 含有 Model
-(void) parseXML_ModelInModel
{
    NSString* str =  [[NSBundle mainBundle] pathForResource:@"baiduLocation" ofType:@"xml"];
    NSString* xmlStr = [NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];

    id objc = [XMLParseToModel parseWithXML:xmlStr toClass:@"SouFunBaiduReverseDataModel"];
    
    // 断点打在此处
    NSLog(@"%@ ",objc);

}

// 2.解析 数组 含有 数组
-(void) parseXML_ArrayContainArray
{
    NSString* str =  [[NSBundle mainBundle] pathForResource:@"SchoolList" ofType:@"xml"];
    NSString* xmlStr = [NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];
    
    id objc = [XMLParseToModel parseWithXML:xmlStr toClass:@"SchoolList"];
    
    // 断点打在此处
    NSLog(@"%@ ",objc);

}
// 3.解析带有属性的XML节点
-(void) parseXML_AttributeNode
{
    NSString* str =  [[NSBundle mainBundle] pathForResource:@"attributeNode" ofType:@"xml"];
    NSString* xmlStr = [NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];
    
    id objc = [XMLParseToModel parseWithXML:xmlStr toClass:@"Employee"];
    
    // 断点打在此处
    NSLog(@"%@ ",objc);
}

// 4 解析 数组 含有 数组 且含有属性节点
-(void) parseComplexXml
{
    NSString* str =  [[NSBundle mainBundle] pathForResource:@"complex" ofType:@"xml"];
    NSString* xmlStr = [NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];
    
    id objc = [XMLParseToModel parseWithXML:xmlStr toClass:@"ComplexSchoolList"];
    
    // 断点打在此处
    NSLog(@"%@ ",objc);
}





@end
