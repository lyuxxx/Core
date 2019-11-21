//
//  BaseRequest.m
//  base
//
//  Created by liuyuxuan on 2019/9/4.
//  Copyright © 2019 csc. All rights reserved.
//

#import "BaseRequest.h"
#import "YBNetworkResponse+YBCustom.h"

@implementation BaseRequest

- (instancetype)initWithType:(URIType)type paras:(NSDictionary *)paras {
    self = [self init];
    self.requestURI = [URIManager getURIWithType:type];
    self.requestMethod = [URIManager getRequestMethodWithType:type];
    self.requestParameter = paras;
    return self;
}

- (instancetype)initWithType:(URIType)type paras:(NSDictionary *)paras delegate:(id<YBResponseDelegate>)delegate {
    self = [self initWithType:type paras:paras];
    self.delegate = delegate;
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.baseURI = @"";//设置baseURI
        /**
        [self.cacheHandler setShouldCacheBlock:^BOOL(YBNetworkResponse * _Nonnull response) {
            // 检查数据正确性，保证缓存有用的内容
            return YES;
        }];
         **/
    }
    return self;
}

#pragma mark - override

- (AFHTTPRequestSerializer *)requestSerializer {
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer new];
    //    [serializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    serializer.timeoutInterval = 30;
    return serializer;
}

- (AFHTTPResponseSerializer *)responseSerializer {
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    //    NSMutableSet *types = [NSMutableSet set];
    NSMutableSet *types = serializer.acceptableContentTypes.mutableCopy;
    [types addObject:@"text/html"];
    serializer.acceptableContentTypes = types;
    return serializer;
}

- (void)start {
    NSLog(@"\n\trequest start :   %@/%@\n\tparas : %@",self.baseURI,self.requestURI,[self yb_preprocessParameter:self.requestParameter]);
    [super start];
}

- (void)yb_redirection:(void (^)(YBRequestRedirection))redirection response:(YBNetworkResponse *)response {
    
    // 处理错误的状态码
    if (response.error) {
        YBResponseErrorType errorType;
        switch (response.error.code) {
            case NSURLErrorTimedOut:
                errorType = YBResponseErrorTypeTimedOut;
                break;
            case NSURLErrorCancelled:
                errorType = YBResponseErrorTypeCancelled;
                break;
            default:
                errorType = YBResponseErrorTypeNoNetwork;
                break;
        }
        response.errorType = errorType;
    }
    
    // 自定义重定向
    NSDictionary *responseDic = response.responseObject;
    if (((NSNumber *)responseDic[@"code"]).integerValue == 21) {
        redirection(YBRequestRedirectionFailure);
        response.errorType = YBResponseErrorTypeLoginExpired;
        return;
    }
    redirection(YBRequestRedirectionSuccess);
}
 
- (NSDictionary *)yb_preprocessParameter:(NSDictionary *)parameter {
    NSMutableDictionary *tmp = [NSMutableDictionary dictionaryWithDictionary:parameter ?: @{}];
    //    tmp[@"test_deviceID"] = @"test250";  //给每一个请求，添加额外的参数
    return tmp;
}

- (NSString *)yb_preprocessURLString:(NSString *)URLString {
    return URLString;
}

- (void)yb_preprocessSuccessInChildThreadWithResponse:(YBNetworkResponse *)response {
    NSMutableDictionary *res = [NSMutableDictionary dictionaryWithDictionary:response.responseObject];
    //    res[@"test_user"] = @"test"; //为每一个返回结果添加字段
    response.responseObject = res;
    NSLog(@"\n\trequest success : %@/%@\n\tresponse : %@",self.baseURI,self.requestURI,response.responseObject);
}

- (void)yb_preprocessFailureInChildThreadWithResponse:(YBNetworkResponse *)response {
    NSLog(@"\n\trequest failure : %@/%@\n\tresponse : %@",self.baseURI,self.requestURI,response.responseObject);
}

@end
