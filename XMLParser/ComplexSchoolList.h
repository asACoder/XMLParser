//
//  ComplexSchoolList.h
//  XMLParser
//
//  Created by fushijian on 14-9-9.
//  Copyright (c) 2014年 fushijian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SchoolsModel;

@interface ComplexSchoolList : NSObject

@property(nonatomic,retain) SchoolsModel *OutArray;

@end


@interface SchoolsModel: NSObject

@property(nonatomic,retain) NSString *target;

@property(nonatomic,retain) NSMutableArray *school_ComplexSchool;

@end


@interface ComplexSchool : NSObject

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *range;
@property(nonatomic,retain) NSString *address;

@property(nonatomic,retain) NSMutableArray *InArray_student_ComplexStudent;

@end


@interface ComplexStudent : NSObject

@property(nonatomic,retain) NSString *no;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *age;

@end