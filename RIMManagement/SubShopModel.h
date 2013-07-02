//
//  SubShopModel.h
//  RIMManagement
//
//  Created by Gong Lingxiao on 13-6-6.
//  Copyright (c) 2013年 Gong Lingxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubShopModel : NSObject {
    NSString *code;
    NSString *name;
    NSString *imageUrl;
    NSString *contacter;
    NSString *address;
    NSString *mPhone;
}

@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *contacter;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *mPhone;

@end
