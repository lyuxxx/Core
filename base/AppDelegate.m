//
//  AppDelegate.m
//  base
//
//  Created by liuyuxuan on 2019/9/3.
//  Copyright © 2019 csc. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <WXAuthTool.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    //    NavigationController *naVC = [[NavigationController alloc] initWithRootViewController:loginVC];
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = naVC;
    [self.window makeKeyAndVisible];
    
    /// 微信登录注册appId
    [WXAuthTool wechatRegisterAppWithAppId:@"" universalLink:@""];
    
    return YES;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSString *fromBundleId = options[UIApplicationOpenURLOptionsSourceApplicationKey];
    if ([fromBundleId isEqualToString:@"com.tencent.xin"]) {//WeChat
        if ([[url absoluteString] containsString:@"oauth"]) {
            //WeChat Auth
            return [WXAuthTool wechatHandleOpenURL:url];
        } else if ([[url absoluteString] containsString:@"pay"]) {
            //WeChat Pay
        } else {
            //WeChat Share
        }
    } else if ([url.host hasPrefix:@"safepay"]) {
        //Alipay
    }
    return YES;
}


@end
