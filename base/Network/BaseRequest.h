//
//  BaseRequest.h
//  base
//
//  Created by liuyuxuan on 2019/9/4.
//  Copyright © 2019 csc. All rights reserved.
//

#import <YBBaseRequest.h>
#import "URIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseRequest : YBBaseRequest

- (instancetype)initWithType:(URIType)type paras:(NSDictionary *)paras;
- (instancetype)initWithType:(URIType)type paras:(NSDictionary *)paras delegate:(id<YBResponseDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
