//
//  UIScrollView+Empty.m
//  base
//
//  Created by liuyuxuan on 2019/9/19.
//  Copyright © 2019 csc. All rights reserved.
//

#import "UIScrollView+Empty.h"
#import <objc/runtime.h>

@interface EmptyView ()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGFloat verticalOffset;

@property (nonatomic, copy) TapClosure tapClosure;

@end

@implementation EmptyView

- (instancetype)initWithImage:(UIImage *)image verticalOffset:(CGFloat)verticalOffset tapClosure:(TapClosure)tapClosure {
    self = [super init];
    if (self) {
        self.image = image;
        self.verticalOffset = verticalOffset;
        self.tapClosure = tapClosure;
    }
    return self;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return self.verticalOffset;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return self.image;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.allowShow;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.tapClosure) {
        self.tapClosure();
    }
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.25 animations:^{
        scrollView.contentOffset = CGPointZero;
    }];
}

@end

static const char *emptyViewKey = "emptyViewKey";

@implementation UIScrollView (Empty)

- (EmptyView *)emptyView {
    return objc_getAssociatedObject(self, emptyViewKey);
}

- (void)setEmptyView:(EmptyView *)emptyView {
    self.emptyDataSetDelegate = emptyView;
    self.emptyDataSetSource = emptyView;
    objc_setAssociatedObject(self, emptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
