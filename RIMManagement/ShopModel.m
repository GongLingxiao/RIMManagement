//
//  ShopModel.m
//  RIMManagement
//
//  Created by Gong Lingxiao on 13-6-6.
//  Copyright (c) 2013年 Gong Lingxiao. All rights reserved.
//

#import "ShopModel.h"
#import "GDataXMLNode.h"
#import "ASIHTTPRequest.h"
#import "SubShopModel.h"

@implementation ShopModel

@synthesize code;
@synthesize subShopList;

+ (ShopModel *)getShopList:(NSString *)loginId withPwd:(NSString *) password {
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"shop"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <shopLogin xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             <arg1>%@</arg1>\
                             </shopLogin>\
                             </soap:Body>\
                             </soap:Envelope>", loginId, password];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"SOAPAction" value:@""];
    [request addRequestHeader:@"Content-Length" value:msgLength];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    //同步调用
    [request startSynchronous];
    NSData *responseData = [request responseData];
    
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:&error];
    
    NSArray *shopList = [doc nodesForXPath:@"//return" error:&error];
    ShopModel *shopModel = [[ShopModel alloc] init];
    for (GDataXMLElement *returnElement in shopList) {
        NSData *data = [returnElement.stringValue dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        if (!jsonArray) {
            NSLog(@"Error parsing JSON: %@", error);
        } else {
            shopModel.subShopList = [[NSMutableArray alloc] init];
            for (NSDictionary *item in jsonArray) {
                if (![@"" isEqualToString:[item objectForKey:@"code"]]) {
                    shopModel.code = [item objectForKey:@"code"];
                    NSArray *sdArray = [item objectForKey:@"sdList"];
                    if (!sdArray) {
                        NSLog(@"Error parsing JSON: %@", error);
                    } else {
                        for (NSDictionary *subItem in sdArray) {
                            SubShopModel *subShop = [[SubShopModel alloc] init];
                            subShop.code = [subItem objectForKey:@"code"];
                            subShop.name = [subItem objectForKey:@"name"];
                            subShop.mPhone = [subItem objectForKey:@"mPhone"];
                            subShop.contacter = [subItem objectForKey:@"contacter"];
                            subShop.address = [subItem objectForKey:@"address"];
                            subShop.imageUrl = [subItem objectForKey:@"imageUrl"];
                            [shopModel.subShopList addObject:subShop];
                        }
                    }
                }
            }
        }
    }
    return shopModel;
}

@end
