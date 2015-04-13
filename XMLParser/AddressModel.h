//
//  AddressModel.h
//  XMLParser
//
//  Created by fushijian on 14-9-15.
//  Copyright (c) 2014年 fushijian. All rights reserved.
//



//<addresses owner="swilson">
//    <person>
//        <lastName>Doe</lastName>
//        <firstName>John</firstName>
//        <phone location="mobile">(201) 345-6789</phone>
//        <email>jdoe@foo.com</email>
//            <address>
//                <street>100 Main Street</street>
//                <city>Somewhere</city>
//                <state>New Jersey</state>
//                <zip>07670</zip>
//            </address>
//        </person>
//</addresses>

#import <Foundation/Foundation.h>

@class Person,Address;

@interface AddressModel : NSObject

@property(nonatomic,retain) NSString *owner;

//@property(nonatomic,retain) Person *person;

@property(nonatomic,retain) NSMutableArray *person;


@end


@interface Person : NSObject


@property(nonatomic,retain) NSString *lastName;
@property(nonatomic,retain) NSString *firstName;
@property(nonatomic,retain) NSString *phone;
@property(nonatomic,retain) NSString *location;
@property(nonatomic,retain) NSString *email;
//@property(nonatomic,retain) Address *address;
@property(nonatomic,retain) NSMutableArray *address;


@end

@interface Address : NSObject

@property(nonatomic,retain) NSString *street;
@property(nonatomic,retain) NSString *city;
@property(nonatomic,retain) NSString *state;
@property(nonatomic,retain) NSString *zip;

@end
