//
//  TabBarViewController.m
//  base
//
//  Created by lyx on 2019/9/4.
//  Copyright © 2019 csc. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

#pragma mark - private func

- (void)setupUI {
    /// 类名
    NSArray *cls = @[
                     @"TestViewController",
                     @"TestViewController",
                     @"TestViewController",
                     @"TestViewController"
                     ];
    /// 标题
    NSArray *titles = @[
                        @"标题一",
                        @"标题二",
                        @"标题三",
                        @"标题四"
                        ];
    /// 正常状态图片
    NSArray *imgTitles = @[
                           @"",
                           @"",
                           @"",
                           @""
                           ];
    /// 选中状态图片
    NSArray *selectedImgTitles = @[
                                   @"",
                                   @"",
                                   @"",
                                   @""
                                   ];
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:cls.count];
    
    for (NSInteger i = 0; i < cls.count; i++) {
        UIViewController *vc = [[NSClassFromString(cls[i]) alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:vc];
        naVC.tabBarItem.title = titles[i];
        [naVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"333333"], NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size:10]} forState:UIControlStateNormal];
        [naVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"ff5151"], NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size:10]} forState:UIControlStateSelected];
        [naVC.tabBarItem setImage:[[UIImage imageNamed:imgTitles[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [naVC.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImgTitles[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [viewControllers addObject:naVC];
    }
    
    self.viewControllers = viewControllers;
}

#pragma mark - action

#pragma mark - lazy load

@end
