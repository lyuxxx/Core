//
//  URIManager.h
//  base
//
//  Created by liuyuxuan on 2019/9/4.
//  Copyright © 2019 csc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YBBaseRequest.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, URIType) {
    URITypeLogin,
};

@interface URIManager : NSObject

+ (NSString *)getURIWithType:(URIType)type;
+ (YBRequestMethod)getRequestMethodWithType:(URIType)type;

@end

NS_ASSUME_NONNULL_END
