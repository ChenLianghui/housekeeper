//
//  LHLostPasswordTwoViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/26.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHLostPasswordTwoViewController.h"
#import "LHLoginViewController.h"

@interface LHLostPasswordTwoViewController ()

@end

@implementation LHLostPasswordTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Lost Password";
    self.titleArray = @[@"Password",@"again"];
    self.placeholderArray = @[@"Please enter your new password",@"Please enter again the password"];
    self.isHadVcode = NO;
    self.isLostCodeOne = NO;
    // Do any additional setup after loading the view.
}

- (void)ActionButtonClicked{
    if ([LHUtils isEmptyStr:self.firsteTF.text]) {
        [self showFailed:@"Please enter your new password"];
    }else if ([LHUtils isEmptyStr:self.secondTF.text]){
        [self showFailed:@"Please enter again your new password"];
    }else{
        if ([self.firsteTF.text isEqualToString:self.secondTF.text]) {
            for (UIViewController *viewController in self.navigationController.viewControllers) {
                if ([viewController isKindOfClass:[LHLoginViewController class]]) {
                    [self.navigationController popToViewController:viewController animated:YES];
                }
            }
        }else{
            [self showFailed:@"Two input password is not the same"];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
