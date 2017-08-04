//
//  LHUserInfoMainView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/30.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHUserInfoMainView.h"

@interface LHUserInfoMainView ()

@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UITextField *nickTF;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UITextField *emailTF;
@property (nonatomic,strong)UITextField *phoneTF;

@end

@implementation LHUserInfoMainView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)createSubViews{
    UIView *whiteView = [UIView new];
    whiteView.backgroundColor = [UIColor whiteColor];
    [LHUtils addShadowWithView:whiteView];
    [self addSubview:whiteView];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderView)];
    [_imageView addGestureRecognizer:tap];
    [self insertSubview:_imageView aboveSubview:whiteView];
    
    [whiteView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self.top).offset(kWidthIphone7(32));
    }];
    
    [_imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
        make.width.equalTo(kWidthIphone7(64));
        make.height.equalTo(kWidthIphone7(64));
    }];
    
    NSArray *titleArray = @[@"Name",@"Nickname",@"Address",@"Email",@"Cellphone",@"Birthday"];
    for (int i = 0; i < titleArray.count; i++ ) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = titleArray[i];
        titleLabel.font = [UIFont appFontThree];
        titleLabel.textColor = [UIColor grayFontColor];
        [whiteView addSubview:titleLabel];
        
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kCellContentMargin);
            make.top.equalTo(whiteView.top).offset(kHeightIphone7(70)+kHeightIphone7(50)*i);
            make.width.equalTo(kWidthIphone7(80));
            make.height.equalTo(kHeightIphone7(20));
        }];
    }
    
    _nameLabel = [UILabel new];
    _nameLabel.textColor = [UIColor colorWithHex:0xAEAEAE];
    _nameLabel.font = [UIFont appFontThree];
    [whiteView addSubview:_nameLabel];
    
    _nickTF = [UITextField new];
    _nickTF.textColor = [UIColor grayFontColor];
    _nickTF.font = [UIFont appFontThree];
    [whiteView addSubview:_nickTF];
    
    _addressLabel = [UILabel new];
    _addressLabel.textColor = [UIColor grayFontColor];
    _addressLabel.font = [UIFont appFontThree];
    [whiteView addSubview:_addressLabel];
    
    _emailTF = [UITextField new];
    _emailTF.textColor = [UIColor grayFontColor];
    _emailTF.font = [UIFont appFontThree];
    _emailTF.keyboardType = UIKeyboardTypeEmailAddress;
    [whiteView addSubview:_emailTF];
    
    _phoneTF = [UITextField new];
    _phoneTF.textColor = [UIColor grayFontColor];
    _phoneTF.font = [UIFont appFontThree];
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [whiteView addSubview:_phoneTF];
    
    _BirthdayTF = [UITextField new];
    _BirthdayTF.textColor = [UIColor grayFontColor];
    _BirthdayTF.font = [UIFont appFontThree];
    [whiteView addSubview:_BirthdayTF];
    
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(115));
        make.right.equalTo(-kCellContentMargin);
        make.top.equalTo(kHeightIphone7(70));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_nickTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.left);
        make.right.equalTo(_nameLabel.right);
        make.top.equalTo(_nameLabel.bottom).offset(kHeightIphone7(30));
        make.height.equalTo(_nameLabel.height);
    }];
    
    [_addressLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.left);
        make.right.equalTo(_nameLabel.right);
        make.height.equalTo(_nameLabel.height);
        make.top.equalTo(_nickTF.bottom).offset(kHeightIphone7(30));
    }];
    
    [_emailTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.left);
        make.right.equalTo(_nameLabel.right);
        make.height.equalTo(_nameLabel.height);
        make.top.equalTo(_addressLabel.bottom).offset(kHeightIphone7(30));
    }];
    
    [_phoneTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.left);
        make.right.equalTo(_nameLabel.right);
        make.height.equalTo(_nameLabel.height);
        make.top.equalTo(_emailTF.bottom).offset(kHeightIphone7(30));
    }];
    
    [_BirthdayTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.left);
        make.right.equalTo(_nameLabel.right);
        make.height.equalTo(_nameLabel.height);
        make.top.equalTo(_phoneTF.bottom).offset(kHeightIphone7(30));
    }];
}

- (void)setUserModel:(LHUserModel *)userModel{
    _userModel = userModel;
    _nameLabel.text = userModel.name;
    _nickTF.text = userModel.nickName;
    _addressLabel.text = userModel.address;
    _emailTF.text = userModel.email;
    _phoneTF.text = userModel.phoneNumber;
    _BirthdayTF.text = userModel.birthday;
}

- (void)tapHeaderView{
    if (self.block) {
        self.block();
    }
}


@end
