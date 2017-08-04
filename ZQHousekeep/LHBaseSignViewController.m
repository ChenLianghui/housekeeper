//
//  LHBaseSignViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/23.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHBaseSignViewController.h"

@interface LHBaseSignViewController ()

@property (nonatomic,strong)UIView *textView;
@property (nonatomic,strong)UIButton *ActionButton;
@property (nonatomic,strong)UIButton *vcodeButton;
@property (nonatomic,strong)UIView *line2;
@property (nonatomic,strong)UILabel *title1Label;
@property (nonatomic,strong)UILabel *title2Label;

@end

@implementation LHBaseSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTextView];
    [self addActionButton];
    // Do any additional setup after loading the view.
}

- (void)addTextView{
    _textView = [UIView new];
    _textView.backgroundColor = [UIColor whiteColor];
    [LHUtils addShadowWithView:_textView];
    [self.view addSubview:_textView];
    
    _title1Label = [UILabel new];
    _title1Label.font = [UIFont appFontTwo];
    [_textView addSubview:_title1Label];
    
    _firsteTF = [UITextField new];
    _firsteTF.placeholder = self.placeholderArray.firstObject;
    [_textView addSubview:_firsteTF];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = [UIColor grayLineColor];
    [_textView addSubview:line1];
    
    _title2Label = [UILabel new];
    _title2Label.font = [UIFont appFontTwo];
    [_textView addSubview:_title2Label];
    
    _secondTF = [UITextField new];
    _secondTF.placeholder = self.placeholderArray[1];
    [_textView addSubview:_secondTF];
    
    _line2 = [UIView new];
    _line2.backgroundColor = [UIColor grayLineColor];
    [_textView addSubview:_line2];
    
    [_textView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(kHeightIphone7(20));
        make.centerX.equalTo(self.view.centerX);
        make.height.equalTo(kHeightIphone7(90));
    }];
    
    [_title1Label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(15));
        make.top.equalTo(kHeightIphone7(20));
        make.width.equalTo(kWidthIphone7(100));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_firsteTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title1Label.right).offset(kWidthIphone7(5));
        make.top.equalTo(_title1Label.top);
        make.right.equalTo(-kWidthIphone7(15));
        make.height.equalTo(_title1Label.height);
    }];
    
    [line1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_firsteTF.left);
        make.top.equalTo(_firsteTF.bottom);
        make.right.equalTo(_firsteTF.right);
        make.height.equalTo(kHeightIphone7(1));
    }];
    
    [_title2Label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title1Label.left);
        make.top.equalTo(_title1Label.bottom).offset(kHeightIphone7(20));
        make.width.equalTo(_title1Label.width);
        make.height.equalTo(_title1Label.height);
    }];
    
    [_secondTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_firsteTF.left);
        make.right.equalTo(_firsteTF.right);
        make.top.equalTo(_title2Label.top);
        make.height.equalTo(_title2Label.height);
    }];
    
    [_line2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1.left);
        make.right.equalTo(_secondTF.right);
        make.top.equalTo(_secondTF.bottom);
        make.height.equalTo(kHeightIphone7(1));
    }];
    
}

- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    if (titleArray.count==2) {
        _title1Label.text = titleArray.firstObject;
        _title2Label.text = titleArray[1];
    }
}

- (void)setPlaceholderArray:(NSArray *)placeholderArray{
    _placeholderArray = placeholderArray;
    if (placeholderArray.count == 2) {
        _firsteTF.placeholder = placeholderArray[0];
        _secondTF.placeholder = placeholderArray[1];
    }
}

- (void)addActionButton{
    _ActionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _ActionButton.backgroundColor = [UIColor appThemeColor];
    [LHUtils addShadowWithView:_ActionButton];
    [_ActionButton addTarget:self action:@selector(ActionButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_ActionButton];
    
    [_ActionButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(_textView.bottom).offset(kHeightIphone7(20));
        make.height.equalTo(kHeightIphone7(40));
    }];
}

- (void)setIsHadVcode:(BOOL)isHadVcode{
    _isHadVcode  = isHadVcode;
    if (_isHadVcode) {
        _vcodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_vcodeButton setTitleColor:[UIColor appThemeColor] forState:UIControlStateNormal];
        [_vcodeButton addTarget:self action:@selector(vcodeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_vcodeButton setTitle:@"send code" forState:UIControlStateNormal];
        _vcodeButton.titleLabel.font = [UIFont appFontThree];
        [_textView addSubview:_vcodeButton];
        
        [_vcodeButton makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_textView.right).offset(-kBorderMargin);
            make.top.equalTo(_secondTF.top);
            make.width.equalTo(kWidthIphone7(100));
            make.height.equalTo(_secondTF.height);
        }];
        
        [_secondTF updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_vcodeButton.left).offset(-kWidthIphone7(5));
        }];
    }
}

- (void)setIsLostCodeOne:(BOOL)isLostCodeOne{
    _isLostCodeOne = isLostCodeOne;
    if (isLostCodeOne) {
        [_ActionButton setTitle:@"Next" forState:UIControlStateNormal];
    }else{
        [_ActionButton setTitle:@"Confirm" forState:UIControlStateNormal];
    }
}

#pragma mark - 点击验证码
- (void)vcodeButtonClicked:(UIButton *)button{
    
}

- (void)ActionButtonClicked{
    
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
