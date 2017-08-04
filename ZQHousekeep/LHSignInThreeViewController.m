//
//  LHSignInThreeViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/23.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHSignInThreeViewController.h"
#import "LHStepProgressView.h"

@interface LHSignInThreeViewController ()

@property (nonatomic,strong) LHStepProgressView *progressView;
@property (nonatomic,strong) UIView *explainView;
@property (nonatomic,strong) UIButton *DoneButton;

@end

@implementation LHSignInThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sign in";
    [self addProgressView];
    [self addExplainView];
    [self addDoneButton];
    // Do any additional setup after loading the view.
}
- (void)addProgressView{
    _progressView = [[LHStepProgressView alloc] init];
    _progressView.step = 3;
    [self.view addSubview:_progressView];
    [_progressView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(kHeightIphone7(20));
        make.centerX.equalTo(self.view.centerX);
        make.height.equalTo(kHeightIphone7(120));
    }];
}

- (void)addExplainView{
    _explainView = [UIView new];
    _explainView.backgroundColor = [UIColor whiteColor];
    [LHUtils addShadowWithView:_explainView];
    [self.view addSubview:_explainView];
    
    UILabel *explainLabel = [UILabel new];
    explainLabel.text = @"Your registration need property staff to review again, please be patient.Property will confirm your identity with the owner of this building.Before approval, in the system features will be limited.";
    explainLabel.numberOfLines = 0;
    explainLabel.font = [UIFont appFontTwo];
    [_explainView addSubview:explainLabel];
    
    [_explainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(_progressView.bottom).offset(kHeightIphone7(20));
        make.centerX.equalTo(self.view.centerX);
        make.height.equalTo(kHeightIphone7(150));
    }];
    
    [explainLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(25));
        make.centerX.equalTo(_explainView.centerX);
        make.top.equalTo(kHeightIphone7(10));
        make.bottom.equalTo(-kHeightIphone7(10));
    }];
}

- (void)addDoneButton{
    _DoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _DoneButton.backgroundColor = [UIColor appThemeColor];
    [_DoneButton setTitle:@"Done" forState:UIControlStateNormal];
    [LHUtils addShadowWithView:_DoneButton];
    [_DoneButton addTarget:self action:@selector(DoneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_DoneButton];
    
    [_DoneButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_explainView.bottom).offset(kHeightIphone7(20));
        make.left.equalTo(_explainView.left);
        make.width.equalTo(_explainView.width);
        make.height.equalTo(kHeightIphone7(40));
    }];
}

- (void)DoneButtonClicked{
    
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
