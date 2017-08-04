//
//  LHLoginView.m
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/5.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHLoginView.h"

@interface LHLoginView ()

@property (nonatomic,strong)UIButton *loginButton;
@property (nonatomic,strong)UIButton *registButton;
@property (nonatomic,strong)UIButton *lostPWButton;

@end

@implementation LHLoginView

- (instancetype)init{
    if (self = [super init]) {
        self.bounds = CGRectMake(0, 0, kScreenSize.width, kHeightIphone7(200));
//        self.backgroundColor = [UIColor redColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    _userTextField = [[LHTextField alloc] init];
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_user"]];
    _userTextField.leftView = leftImageView;
    _userTextField.leftViewMode = UITextFieldViewModeAlways;
    _userTextField.clearButtonMode = UITextFieldViewModeAlways;
    _userTextField.placeholder = @"Please enter the username";
    _userTextField.backgroundColor = [UIColor whiteColor];
    _userTextField.textAlignment = NSTextAlignmentCenter;
    [_userTextField setValue:[UIColor grayFontColor] forKeyPath:@"_placeholderLabel.textColor"];
    _userTextField.textColor = [UIColor grayFontColor];
    _userTextField.tintColor = [UIColor grayFontColor];
    _userTextField.font = [UIFont appFontThree];
    _userTextField.layer.masksToBounds = YES;
    _userTextField.layer.cornerRadius = kHeightIphone7(20);
    _userTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _userTextField.layer.borderWidth = 1.0;
    if (![LHUtils isEmptyStr:[[NSUserDefaults standardUserDefaults] valueForKey:key_currentUserName]]) {
        _userTextField.text = [[NSUserDefaults standardUserDefaults] valueForKey:key_currentUserName];
    }
    [self addSubview:_userTextField];
    
    _passwordTextField = [[LHTextField alloc] init];
    UIImageView *leftImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
    _passwordTextField.leftView = leftImageView2;
    _passwordTextField.backgroundColor = [UIColor whiteColor];
    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    _passwordTextField.placeholder = @"Please enter the password";
    _passwordTextField.textAlignment = NSTextAlignmentCenter;
    
    [_passwordTextField setValue:[UIColor grayFontColor] forKeyPath:@"_placeholderLabel.textColor"];
    _passwordTextField.textColor = [UIColor grayFontColor];
    _passwordTextField.tintColor = [UIColor grayFontColor];
    _passwordTextField.font = [UIFont appFontThree];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.layer.masksToBounds = YES;
    _passwordTextField.layer.cornerRadius = kHeightIphone7(20);
    _passwordTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _passwordTextField.layer.borderWidth = 1.0;
    [self addSubview:_passwordTextField];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    [_loginButton setBackgroundColor:[UIColor appThemeColor]];
    _loginButton.layer.masksToBounds = YES;
    _loginButton.tag = 30;
    _loginButton.layer.cornerRadius = kHeightIphone7(20);
    _loginButton.titleLabel.font = [UIFont appFontTwo];
    [_loginButton addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginButton];
    
    _registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registButton setTitle:@"Sign in" forState:UIControlStateNormal];
    [_registButton setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
    _registButton.tag = 31;
    _registButton.titleLabel.font = [UIFont appFontFour];
    _registButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_registButton addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_registButton];
    
    _lostPWButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lostPWButton setTitle:@"Forgot password?" forState:UIControlStateNormal];
    [_lostPWButton setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
    _lostPWButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _lostPWButton.titleLabel.font = [UIFont appFontFour];
    _lostPWButton.tag = 32;
    [_lostPWButton addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_lostPWButton];
    
    [_userTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.height.equalTo(kHeightIphone7(40));
        make.centerX.equalTo(self.centerX);
        make.left.equalTo(self.left).offset(kWidthIphone7(50));
    }];
    
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userTextField.bottom).offset(kHeightIphone7(20));
        make.height.equalTo(self.userTextField.height);
        make.centerX.equalTo(self.centerX);
        make.left.equalTo(self.userTextField.left);
    }];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.bottom).offset(kHeightIphone7(20));
        make.height.equalTo(self.userTextField.height);
        make.centerX.equalTo(self.centerX);
        make.left.equalTo(self.userTextField.left);
    }];
    
    [_registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginButton.left);
        make.width.equalTo(kWidthIphone7(100));
        make.height.equalTo(kHeightIphone7(20));
        make.top.equalTo(self.loginButton.bottom).offset(kHeightIphone7(15));
    }];
    
    [_lostPWButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.bottom).offset(kHeightIphone7(15));
        make.right.equalTo(self.right).offset(-kWidthIphone7(50));
        make.width.equalTo(kWidthIphone7(150));
        make.height.equalTo(self.registButton.height);
    }];
    
//    CGFloat height = CGRectGetMaxY(self.lostPWButton.frame);
//    self.bounds = CGRectMake(0, 0, kScreenSize.width, height);
}

- (void)ButtonClicked:(UIButton *)button{
//    if (button.tag == 30) {
//        if ([LHUtils isEmptyStr:_userTextField.text]) {
//            [(UIViewController *)self.delegate showFailed:@"Please enter your username"];
//            return;
//        }else{
//            if ([LHUtils isEmptyStr:_passwordTextField.text]) {
//                [(UIViewController *)self.delegate showFailed:@"Please enter your password"];
//                return;
//            }
//            
//        }
//    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(ButtonHadClickedWithTag:)]) {
        [self.delegate ButtonHadClickedWithTag:button.tag];
    }
}

@end
