//
//  ShopModel.h
//  RIMManagement
//
//  Created by Gong Lingxiao on 13-6-6.
//  Copyright (c) 2013年 Gong Lingxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject {
    NSString *code;
    NSMutableArray *subShopList;
}

@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSMutableArray *subShopList;

+ (ShopModel *)getShopList:(NSString *)loginId withPwd:(NSString *) password;

@end
