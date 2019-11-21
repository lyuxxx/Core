//
//  LoginViewController.m
//  base
//
//  Created by liuyuxuan on 2019/9/3.
//  Copyright © 2019 csc. All rights reserved.
//

#import "LoginViewController.h"
#import "TabBarViewController.h"
#import <WXAuthTool.h>

@interface LoginViewController () <YBResponseDelegate>
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *wechatLoginBtn;

@property (nonatomic, strong) BaseRequest *loginRequest;
@end

@implementation LoginViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

#pragma mark - private func

- (void)setupUI {
    
    self.navigationItem.title = @"登录";
    
    [self.view addSubview:self.loginBtn];
    [self.loginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
    }];
    
    [self.view addSubview:self.wechatLoginBtn];
    [self.wechatLoginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.loginBtn.bottom).offset(50);
    }];
}

#pragma mark - action

- (void)loginAction:(UIButton *)sender {
    self.loginRequest = [[BaseRequest alloc] initWithType:URITypeLogin paras:@{} delegate:self];
    self.loginRequest.releaseStrategy = YBNetworkReleaseStrategyHoldRequest;
    [self.loginRequest start];
    /**
    self.loginRequest = [[BaseRequest alloc] initWithType:URITypeLogin paras:@{}];
    [self.loginRequest startWithSuccess:^(YBNetworkResponse * _Nonnull response) {
        
    } failure:^(YBNetworkResponse * _Nonnull response) {
        
    }];
    **/
    TabBarViewController *tabVC = [[TabBarViewController alloc] init];
    [[UIApplication sharedApplication].delegate.window setRootViewController:tabVC];
}

- (void)wechatLoginAction:(UIButton *)sender {
    [[WXAuthTool shared] sendWXAuthRequestWithCallBack:^(NSInteger respCode, NSString *code) {
        if (respCode == 0) {//微信授权成功
            NSLog(@"wechat code:%@",code);
            [self showAlertWithMessage:[NSString stringWithFormat:@"wechat code:%@",code]];
        } else if (respCode == -1) {
            [self showAlertWithMessage:@"用户拒绝授权"];
        } else if (respCode == -2) {
            [self showAlertWithMessage:@"用户取消授权"];
        } else if (respCode == -3) {
            [self showAlertWithMessage:@"未安装微信客户端"];
        } else {
            [self showAlertWithMessage:@"未知错误"];
        }
    }];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - YBResponseDelegate

- (void)request:(__kindof YBBaseRequest *)request successWithResponse:(YBNetworkResponse *)response {
    
}

- (void)request:(__kindof YBBaseRequest *)request failureWithResponse:(YBNetworkResponse *)response {
    
}

#pragma mark - lazy load

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)wechatLoginBtn {
    if (!_wechatLoginBtn) {
        _wechatLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wechatLoginBtn setTitle:NSLocalizedString(@"WeChat Login", nil) forState:UIControlStateNormal];
        [_wechatLoginBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_wechatLoginBtn addTarget:self action:@selector(wechatLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechatLoginBtn;
}

@end
