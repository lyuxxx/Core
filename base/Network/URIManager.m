//
//  URIManager.m
//  base
//
//  Created by liuyuxuan on 2019/9/4.
//  Copyright © 2019 csc. All rights reserved.
//

#import "URIManager.h"

@implementation URIManager

+ (NSString *)getURIWithType:(URIType)type {
    NSString *uri = nil;
    
    switch (type) {
        case URITypeLogin:
            uri = @"customer/login";
            break;
            
        default:
            break;
    }
    
    return uri;
}

+ (YBRequestMethod)getRequestMethodWithType:(URIType)type {
    YBRequestMethod method = YBRequestMethodGET;
    
    switch (type) {
            case URITypeLogin:
            method = YBRequestMethodPOST;
            break;
            
        default:
            break;
    }
    
    return method;
}

@end
