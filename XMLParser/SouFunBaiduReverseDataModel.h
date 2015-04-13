//
//  SouFunBaiduReverseDataModel.h
//  XMLParser
//
//  Created by fushijian on 14-7-31.
//  Copyright (c) 2014年 fushijian. All rights reserved.
//

#import <Foundation/Foundation.h>



/*
 
 
 <GeocoderSearchResponse>
     <status>OK</status>
     <result>
         <location>
             <lat>39.821361</lat>
             <lng>116.294897</lng>
         </location>
     <formatted_address>北京市丰台区丰葆路</formatted_address>
     <business>世界公园,科技园区,看丹桥</business>
     <addressComponent>
         <streetNumber/>
         <street>丰葆路</street>
         <district>丰台区</district>
         <city>北京市</city>
         <province>北京市</province>
     </addressComponent>
     <cityCode>131</cityCode>
     </result>
 </GeocoderSearchResponse>
 
 */


@class ResultModel, LocationModel,AddressComponentModel,Person;


@interface SouFunBaiduReverseDataModel : NSObject

@property(nonatomic, retain)NSString *status;

@property(nonatomic, retain)ResultModel *result;


@end


@interface ResultModel : NSObject


@property(nonatomic, retain)LocationModel *location;

@property(nonatomic, retain)NSString *formatted_address;

@property(nonatomic, retain)NSString *business;
@property(nonatomic, retain)AddressComponentModel *addressComponent;


@property(nonatomic, retain)NSString *cityCode;
@end



@interface AddressComponentModel : NSObject

@property(nonatomic, retain)NSString *streetNumber;

@property(nonatomic, retain)NSString *street;

@property(nonatomic, retain)NSString *district;

@property(nonatomic, retain)NSString *city;

@property(nonatomic, retain)NSString *province;


@end


@interface LocationModel : NSObject


@property(nonatomic, retain)NSString *lat;

@property(nonatomic, retain)NSString *lng;

@end










