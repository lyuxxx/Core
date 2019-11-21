//
//  UIScrollView+Empty.h
//  base
//
//  Created by liuyuxuan on 2019/9/19.
//  Copyright © 2019 csc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIScrollView+EmptyDataSet.h>

typedef void(^TapClosure)(void);

NS_ASSUME_NONNULL_BEGIN

@interface EmptyView : NSObject <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, assign) BOOL allowShow;

- (instancetype)initWithImage:(UIImage *)image verticalOffset:(CGFloat)verticalOffset tapClosure:(TapClosure)tapClosure;

@end

@interface UIScrollView (Empty)

@property (nonatomic, strong) EmptyView *emptyView;

@end

NS_ASSUME_NONNULL_END
