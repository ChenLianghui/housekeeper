//
//  LHAppointmentInfoView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/3.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHAppointmentInfoView.h"

@implementation LHAppointmentInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    NSArray *array = @[@"Room",@"Number",@"Date",@"Time",@"Use"];
    for (int i = 0; i < 5; i++) {
        UILabel *titlelabel = [UILabel new];
        titlelabel.text = array[i];
        titlelabel.font = [UIFont appFontThree];
        [self addSubview:titlelabel];
        
        [titlelabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kBorderMargin);
            make.top.equalTo(kHeightIphone7(5)+(kHeightIphone7(20) + kHeightIphone7(30))*i);
            make.width.equalTo(kWidthIphone7(80));
            make.height.equalTo(kHeightIphone7(30));
        }];
        
    }
    
    _roomTF = [UITextField new];
    _roomTF.textColor = [UIColor grayFontColor];
    _roomTF.font = [UIFont appFontThree];
    [self addSubview:_roomTF];
    
    _numberView = [[LHSelectNumberView alloc] init];
    [self addSubview:_numberView];
    
    _dateTF = [UITextField new];
    _dateTF.font = [UIFont appFontThree];
    _dateTF.textColor = [UIColor grayFontColor];
    [self addSubview:_dateTF];
    
    _timeTF = [UITextField new];
    _timeTF.font = [UIFont appFontThree];
    _timeTF.textColor = [UIColor grayFontColor];
    [self addSubview:_timeTF];
    
    _useTF = [UITextField new];
    _useTF.font = [UIFont appFontThree];
    _useTF.textColor = [UIColor grayFontColor];
    [self addSubview:_useTF];
    
    [_roomTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(130));
        make.width.equalTo(kWidthIphone7(120));
        make.top.equalTo(kHeightIphone7(5));
        make.height.equalTo(kHeightIphone7(30));
    }];
    
    [_numberView makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(_roomTF);
        make.top.equalTo(_roomTF.bottom).offset(kHeightIphone7(20));
        make.width.equalTo(kWidthIphone7(90));
    }];
    
    [_dateTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_roomTF);
        make.top.equalTo(_numberView.bottom).offset(kHeightIphone7(20));
    }];
    
    [_timeTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_roomTF);
        make.top.equalTo(_dateTF.bottom).offset(kHeightIphone7(20));
    }];
    
    [_useTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(_roomTF);
        make.right.equalTo(-kBorderMargin);
        make.top.equalTo(_timeTF.bottom).offset(kHeightIphone7(20));
    }];
}

@end
