//
//  LHLostPasswordOneViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/26.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHLostPasswordOneViewController.h"
#import "UIButton+CountDown.h"
#import "LHLostPasswordTwoViewController.h"

@interface LHLostPasswordOneViewController ()

@end

@implementation LHLostPasswordOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Lost Password";
    self.titleArray = @[@"E-mail",@"Code"];
    self.placeholderArray = @[@"Please enter your e-mail",@""];
    self.isHadVcode = YES;
    self.isLostCodeOne = YES;
    // Do any additional setup after loading the view.
}

- (void)vcodeButtonClicked:(UIButton *)button{
    [button countDownFromTime:60 title:@"send code" unitTitle:@"s" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
    NSLog(@"vcode");
}

- (void)ActionButtonClicked{
    NSLog(@"sign");
    if ([LHUtils isEmptyStr:self.firsteTF.text]) {
        [self showFailed:@"Please enter your Email"];
    }else if ([LHUtils isEmptyStr:self.secondTF.text]){
        [self showFailed:@"Please enter your vcode"];
    }else{
        LHLostPasswordTwoViewController *lostPWTwoVC = [[LHLostPasswordTwoViewController alloc] init];
        [self.navigationController pushViewController:lostPWTwoVC animated:YES];
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
