//
//  People.h
//  XMLParser
//
//  Created by fushj on 15/4/13.
//  Copyright (c) 2015年 fushj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *age;

@end


@interface Worker : People

@property(nonatomic,retain) NSString *company;
@property(nonatomic,retain) NSString *work;

@end