//
//  XMLParseToModel.m
//  LearnGDataXML
//
//  Created by fushijian on 14-7-24.
//  Copyright (c) 2014年 fushijian. All rights reserved.
//

#import "XMLParseToModel.h"
#import <objc/runtime.h>
#import "GDataXMLNode.h"


@implementation XMLParseToModel


+(NSString *)getPropertyType:(objc_property_t)property
{
    const char *propertyAttribute = property_getAttributes(property);
    NSString *attribute = [NSString stringWithCString:propertyAttribute encoding:NSUTF8StringEncoding];
    
    NSString *propertyType = nil;
    NSScanner *scan = [NSScanner scannerWithString:attribute];
    [scan scanUpToString:@"\"" intoString:nil];
    scan.scanLocation += 1;
    [scan scanUpToString:@"\"" intoString:&propertyType];
    return propertyType;
}

+(NSString *)getPropertyName:(objc_property_t)property
{
    const char *propName = property_getName(property);
    return [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
}



+ (void)propertyMutableArray:(NSMutableArray *)proName MutableDictionary:(NSMutableDictionary*)dict cls:(Class) cls{
    
    if ([NSStringFromClass(cls) isEqualToString:NSStringFromClass([NSObject class])]) {
        return;
    }
    
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    
    for(int i =0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyType = [self getPropertyType:property];
        NSString *propertyName = [self getPropertyName:property];
        [proName addObject:propertyName];
        [dict setValue:propertyType forKey:propertyName];
    }
    free(properties);
    
    cls = class_getSuperclass(cls);
    [self propertyMutableArray:proName MutableDictionary:dict cls:cls];
    
    return ;
}

//+ (void)propertyMutableArray:(NSMutableArray *)proName MutableDictionary:(NSMutableDictionary*)dict obj:(NSObject *) objt{
//    
//    
//    unsigned int outCount;
//    objc_property_t *properties = class_copyPropertyList([objt class], &outCount);
//
//    for(int i =0; i < outCount; i++)
//    {
//        objc_property_t property = properties[i];
//        NSString *propertyType = [self getPropertyType:property];
//        NSString *propertyName = [self getPropertyName:property];
//        [proName addObject:propertyName];
//        [dict setValue:propertyType forKey:propertyName];
//    }
//    free(properties);
//	return ;
//}


+(id) parseWithXML:(id)xml  toClass:(NSString*)cls
{
    NSError *error = nil;
    GDataXMLDocument *doc = nil;
    if ([xml isKindOfClass:[NSData class]]) {
        doc = [[GDataXMLDocument alloc] initWithData:xml options:0 error:&error];
    }else{
        doc = [[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:&error];
    }
    if (error || doc == nil) {
        return nil;
    }
    
    GDataXMLElement *rootElement = [doc rootElement];
    NSMutableArray *elementQueue = [[NSMutableArray alloc] initWithCapacity:5];
    [elementQueue addObject:rootElement];

    id object = [[NSClassFromString(cls) alloc] init] ;
    NSMutableArray *objcQueue = [[NSMutableArray alloc] initWithCapacity:5];
    [objcQueue addObject:object];
    
    NSMutableArray *propertyArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *propertyTypeDict = [[NSMutableDictionary alloc] init];
    
    id temObj = nil;
    
    while (objcQueue.count) { // 队列不空
        
        GDataXMLElement *topElement = [elementQueue objectAtIndex:0];
        id topObj = [objcQueue objectAtIndex:0];
        
        if (temObj == nil ||
            ![NSStringFromClass([temObj class]) isEqualToString:NSStringFromClass([topObj class])] ) {
            [propertyArr removeAllObjects];
            [propertyTypeDict removeAllObjects];
//            [self propertyMutableArray:propertyArr MutableDictionary:propertyTypeDict  obj:topObj];
            [self propertyMutableArray:propertyArr MutableDictionary:propertyTypeDict cls:[topObj class]];
            
            temObj = topObj;
        }
        
        for (int i = 0; i < propertyArr.count; i++) {
            
            NSString *property = propertyArr[i]; // 属性名字
            NSString *propertyType = [propertyTypeDict objectForKey:property]; // 属性类型
            
            if ([propertyType isEqualToString:@"NSString"]) {
                
//                GDataXMLElement *gDataElement  = [topElement elementsForName:property][0];
//                NSString *propertyValue = [gDataElement stringValue];
//                [topObj setValue:propertyValue forKey:property];
                NSArray *dataElements = [topElement elementsForName:property];
                for (GDataXMLElement *gDataElement in dataElements) {
                    NSString *propertyValue = [gDataElement stringValue];
                    [topObj setValue:propertyValue forKey:property];
                    
                    [self parseAttributesOfElement:gDataElement forObj:topObj];
                }
            }else if([propertyType isEqualToString:@"NSMutableArray"]){
                
                NSArray *propertyAndClassName = [property componentsSeparatedByString:@"_"];
                NSString *className = [propertyAndClassName lastObject];
                GDataXMLElement *gDataElement = topElement;
                
                NSString *propertyInXml = nil;
                int j = 0;
                for (; j < propertyAndClassName.count - 2; j++) {
                    propertyInXml = propertyAndClassName[j];
                    gDataElement = [gDataElement elementsForName:propertyInXml][0];

                }
                propertyInXml =  propertyAndClassName[j];
                NSArray *elementArr = [gDataElement elementsForName:propertyInXml];
                
                NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:10];
                
                for (GDataXMLElement *gDataElement in elementArr) {
                    
                    id objInArr = [[NSClassFromString(className) alloc] init];
                    [self parseAttributesOfElement:gDataElement forObj:objInArr];
                    [list addObject:objInArr];

                    [objcQueue addObject:objInArr];
                    [elementQueue addObject:gDataElement];
                    
                    [objInArr release];
                }
                [topObj setValue:list forKey:property];
                [list release];
                
            }else{ // propertyType 是 自定义Model
                
                NSArray *dataElements = [topElement elementsForName:property];
                
                for (GDataXMLElement *gDataElement in dataElements) {
                    id obj = [[NSClassFromString(propertyType) alloc] init];
                    [objcQueue addObject:obj];
                    
                    [elementQueue addObject:gDataElement];
                    [topObj setValue:obj forKey:property];
                    
                    [self parseAttributesOfElement:gDataElement forObj:obj];
                    
                    [obj release];
                }
            }
        }

        [objcQueue removeObjectAtIndex:0];
        [elementQueue removeObjectAtIndex:0];
    }

    [propertyArr release];
    [propertyTypeDict release];
    [elementQueue release];
    [objcQueue release];
    
    return object;
   
}

+(void)parseAttributesOfElement:(GDataXMLElement*)gDataElement forObj:(id)object
{
    NSArray *attributes = [gDataElement attributes];
    for (GDataXMLElement *attElement in attributes) {
        if ([object respondsToSelector:NSSelectorFromString([attElement name])]) {
            [object setValue:[attElement stringValue]  forKey:[attElement name]];
        }
    }

}


@end
