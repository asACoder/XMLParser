//
//  SchoolList.h
//  XMLParser
//
//  Created by fushijian on 14-9-9.
//  Copyright (c) 2014年 fushijian. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SchoolList : NSObject

@property(nonatomic,retain) NSMutableArray *OutArray_school_School;

@end


@interface School : NSObject

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *address;
@property(nonatomic,retain) NSMutableArray *InArray_student_Student;

@end



@interface Student : NSObject

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *age;

@end