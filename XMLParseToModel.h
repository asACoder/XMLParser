//
//  XMLParseToModel.h
//  LearnGDataXML
//
//  Created by fushijian on 14-7-24.
//  Copyright (c) 2014年 fushijian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParseToModel : NSObject

/**
  将XML解析成Model
  @param xml  类型为NSString或者NSData的xml数据
  @param cls  Model 的 类名
 
  @return Model的实例
 */

+(id) parseWithXML:(id)xml  toClass:(NSString*)cls;

@end
