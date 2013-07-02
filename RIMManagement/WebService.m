//
//  WebService.m
//  RIMManagement
//
//  Created by Gong Lingxiao on 13-6-5.
//  Copyright (c) 2013年 Gong Lingxiao. All rights reserved.
//

#import "WebService.h"
#import "ASIFormDataRequest.h"

@implementation WebService

+ (NSString *) postData:(NSString *) jsonData {
    NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"navigationbar_bg.png"]);
//    NSString *webserviceUrl = @"http://10.1.2.114:8080/eLife/services/rest/cardService/upload";
//    NSURL *url = [NSURL URLWithString:webserviceUrl];
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request setRequestMethod:@"POST"];
//    [request addRequestHeader:@"Content-Type" value:@"multipart/form-data; charset=utf-8"];
//    [request addData:imageData withFileName:@"123.png" andContentType:@"image/png" forKey:@"file"];
//    [request buildPostBody];
//    [request setDelegate:self];
//    [request startAsynchronous];
    
    //NSString *aString = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
    //NSString *aString = [[NSString alloc] initWithData:imageData encoding:NSASCIIStringEncoding];
    Byte *aByte = (Byte *)[imageData bytes];
    NSString *aString = [[NSString alloc] initWithBytes:aByte length:[imageData length] encoding:NSUTF8StringEncoding];
    NSString *webserviceUrl = @"http://10.1.2.110:8080/services/test";
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <testString xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </testString>\
                             </soap:Body>\
                             </soap:Envelope>", aString];
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
    return @"";
}

@end
