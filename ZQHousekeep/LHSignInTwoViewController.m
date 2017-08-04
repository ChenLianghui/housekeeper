//
//  LHSignInTwoViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/23.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHSignInTwoViewController.h"
#import "LHStepProgressView.h"
#import "LHAreaHeaderView.h"
#import "LHSignInThreeViewController.h"

#define kIdentityItemWidth kScreenSize.width/5
@interface LHSignInTwoViewController ()

@property (nonatomic,strong) LHStepProgressView *progressView;
@property (nonatomic,strong) UIButton *NextButton;
@property (nonatomic,strong) LHAreaHeaderView *InformationView;
@property (nonatomic,strong) LHAreaHeaderView *IdentityView;
@property (nonatomic,strong) UITextField *nameTextfield;
@property (nonatomic,strong) UITextField *phoneTextfield;
@property (nonatomic,strong) UIButton *currentButton;

@end

@implementation LHSignInTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sign in";
    [self addProgressView];
    [self addInformationView];
    [self addIdentityView];
    [self addNextButton];
    // Do any additional setup after loading the view.
}

- (void)addProgressView{
    _progressView = [[LHStepProgressView alloc] init];
    _progressView.step = 2;
    [self.view addSubview:_progressView];
    [_progressView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(kHeightIphone7(20));
        make.centerX.equalTo(self.view.centerX);
        make.height.equalTo(kHeightIphone7(120));
    }];
}

- (void)addInformationView{
    _InformationView = [[LHAreaHeaderView alloc] init];
    _InformationView.titleLabel.text = @"Information";
    [self.view addSubview:_InformationView];
    
    UILabel *nameLable = [UILabel new];
    nameLable.text = @"Name";
    nameLable.font = [UIFont appFontTwo];
    [_InformationView addSubview:nameLable];
    
    _nameTextfield = [UITextField new];
    [_InformationView addSubview:_nameTextfield];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = [UIColor grayLineColor];
    [_InformationView addSubview:line1];
    
    UILabel *phoneLabel = [UILabel new];
    phoneLabel.text = @"Cellphone";
    phoneLabel.font = [UIFont appFontTwo];
    [_InformationView addSubview:phoneLabel];
    
    _phoneTextfield = [UITextField new];
    _phoneTextfield.keyboardType = UIKeyboardTypeNumberPad;
    [_InformationView addSubview:_phoneTextfield];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = [UIColor grayLineColor];
    [_InformationView addSubview:line2];
    
    [_InformationView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(_progressView.bottom).offset(kHeightIphone7(20));
        make.centerX.equalTo(self.view.centerX);
        make.height.equalTo(kHeightIphone7(120));
    }];
    
    [nameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(_InformationView.top).offset(kHeightIphone7(40));
        make.width.equalTo(kWidthIphone7(100));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_nameTextfield makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLable.top);
        make.left.equalTo(nameLable.right).offset(kWidthIphone7(10));
        make.right.equalTo(-kBorderMargin);
        make.height.equalTo(nameLable.height);
    }];
    
    [line1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameTextfield.bottom);
        make.left.equalTo(_nameTextfield.left);
        make.right.equalTo(_nameTextfield.right);
        make.height.equalTo(kHeightIphone7(1));
    }];
    
    [phoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLable.bottom).offset(kHeightIphone7(20));
        make.left.equalTo(nameLable.left);
        make.width.equalTo(nameLable.width);
        make.height.equalTo(nameLable.height);
    }];
    
    [_phoneTextfield makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameTextfield.left);
        make.top.equalTo(phoneLabel.top);
        make.width.equalTo(_nameTextfield.width);
        make.height.equalTo(_nameTextfield.height);
    }];
    
    [line2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneTextfield.left);
        make.top.equalTo(_phoneTextfield.bottom);
        make.width.equalTo(_phoneTextfield.width);
        make.height.equalTo(line1.height);
    }];
    
}

- (void)addIdentityView{
    _IdentityView = [[LHAreaHeaderView alloc] init];
    _IdentityView.titleLabel.text = @"Identity";
    [self.view addSubview:_IdentityView];
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.showsHorizontalScrollIndicator = YES;
    NSArray *imageTitleArray = @[@"业主",@"亲属",@"租客",@"访客"];
    scrollView.contentSize = CGSizeMake(kIdentityItemWidth*4+kBorderMargin*5, 0);
    [_IdentityView addSubview:scrollView];
    
    [_IdentityView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(_InformationView.bottom).offset(kHeightIphone7(20));
        make.centerX.equalTo(self.view.centerX);
        make.height.equalTo(kHeightIphone7(40)+kIdentityItemWidth+kHeightIphone7(20));
    }];
    
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_IdentityView.left);
        make.top.equalTo(_IdentityView.top).offset(kHeightIphone7(40));
        make.width.equalTo(_IdentityView.width);
        make.bottom.equalTo(_IdentityView.bottom);
    }];
    
    for (int i = 0; i < imageTitleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setImage:[UIImage imageNamed:imageTitleArray[i]] forState:UIControlStateNormal];
        [button setTitle:imageTitleArray[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor grayColor];
        button.tag = 60+i;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo((kBorderMargin+kIdentityItemWidth)*i+kBorderMargin);
            make.top.equalTo(_IdentityView.top).offset(kHeightIphone7(40));
            make.width.equalTo(kIdentityItemWidth);
            make.height.equalTo(kIdentityItemWidth);
        }];
        
        [button layoutIfNeeded];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = kWidthIphone7(8);
    }
    
}

- (void)addNextButton{
    _NextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _NextButton.backgroundColor = [UIColor appThemeColor];
    [_NextButton setTitle:@"Next" forState:UIControlStateNormal];
    [LHUtils addShadowWithView:_NextButton];
    [_NextButton addTarget:self action:@selector(NextButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_NextButton];
    
    [_NextButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_IdentityView.bottom).offset(kHeightIphone7(20));
        make.left.equalTo(_IdentityView.left);
        make.width.equalTo(_IdentityView.width);
        make.height.equalTo(kHeightIphone7(40));
    }];
}

#pragma mark - 选择角色
- (void)buttonClicked:(UIButton *)button{
    if (_currentButton) {
        _currentButton.backgroundColor = [UIColor grayColor];
    }
    button.backgroundColor = [UIColor redColor];
    _currentButton = button;
}

#pragma mark - 点击下一步
- (void)NextButtonClicked{
    if ([LHUtils isEmptyStr:_nameTextfield.text]) {
        [self showFailed:@"Please enter your name!"];
    }else if ([LHUtils isEmptyStr:_phoneTextfield.text]){
        [self showFailed:@"Please enter your cellPhone!"];
    }else if ([LHUtils isEmptyStr:_currentButton.titleLabel.text]){
        [self showFailed:@"Please enter your Identity!"];
    }else{
        LHSignInThreeViewController *signThreeVC = [[LHSignInThreeViewController alloc] init];
        [self.navigationController pushViewController:signThreeVC animated:YES];
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
