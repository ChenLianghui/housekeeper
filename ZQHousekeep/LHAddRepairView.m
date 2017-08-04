//
//  LHAddRepairView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/24.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHAddRepairView.h"

@interface LHAddRepairView ()<LHSelectPhotoViewDelegate>

@property (nonatomic,strong)UIDatePicker *datePicker;

@end

@implementation LHAddRepairView

- (instancetype)init{
    if (self = [super init]) {
        [self createSubViews];
        self.backgroundColor = [UIColor whiteColor];
        [LHUtils addShadowWithView:self];
    }
    return self;
}

- (void)createSubViews{
    _photoView = [[LHSelectPhotoView alloc] init];
    _photoView.delegate = self;
    [self addSubview:_photoView];
    
    [_photoView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.centerX.equalTo(self.centerX);
        make.height.equalTo(kHeightIphone7(100));
    }];
    
    NSArray *labelTitleArray = @[@"Name",@"Title",@"Time",@"Remarks"];
    for (int i = 0; i < labelTitleArray.count; i++) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = labelTitleArray[i];
        titleLabel.textColor = [UIColor grayFontColor];
        titleLabel.font = [UIFont appFontThree];
        [self addSubview:titleLabel];
        
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_photoView.bottom).offset((kHeightIphone7(20)+kHeightIphone7(20))*i);
            make.height.equalTo(kHeightIphone7(20));
            make.left.equalTo(kCellContentMargin);
            make.width.equalTo(kWidthIphone7(100));
        }];
    }
    
    _nameTF = [UITextField new];
    _nameTF.textColor = [UIColor lightGrayFontColor];
    _nameTF.font = [UIFont appFontThree];
    [self addSubview:_nameTF];
    
    _titleTF = [UITextField new];
    _titleTF.textColor = [UIColor grayFontColor];
    _titleTF.font = [UIFont appFontThree];
    _titleTF.placeholder = @"Please enter a title of the repair";
    [self addSubview:_titleTF];
    
    _timeTF = [UITextField new];
    _timeTF.textColor = [UIColor grayFontColor];
    _timeTF.font = [UIFont appFontThree];
    _timeTF.placeholder = @"Please select the time to handle it";
    _timeTF.inputView = self.datePicker;
    [self addSubview:_timeTF];
    
    _remarkTextview = [UITextView new];
    _remarkTextview.textColor = [UIColor grayFontColor];
    _remarkTextview.font = [UIFont appFontThree];
    _remarkTextview.text = @"Repaired as soon as possible!";
    [self addSubview:_remarkTextview];
    
    [_nameTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(100));
        make.top.equalTo(_photoView.bottom);
        make.width.equalTo(kWidthIphone7(200));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_titleTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_nameTF);
        make.top.equalTo(_nameTF.bottom).offset(kHeightIphone7(20));
    }];
    
    [_timeTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_nameTF);
        make.top.equalTo(_titleTF.bottom).offset(kHeightIphone7(20));
    }];
    
    [_remarkTextview makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_nameTF);
        make.top.equalTo(_timeTF.bottom).offset(kHeightIphone7(20));
        make.height.equalTo(kHeightIphone7(100)).priority(1);
        make.bottom.equalTo(-kHeightIphone7(10));
    }];
    
}

#pragma mark - LHPhotoViewDelegate
- (void)getNowHeight:(CGFloat)height{
    [_photoView updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(height);
    }];
    
    self.contentSize = CGSizeMake(0, kHeightIphone7(190)+height);
    [self setNeedsLayout];
    [self layoutIfNeeded];
    if (self.heightBlock) {
        self.heightBlock(height + kHeightIphone7(190));
    }
}

- (void)datePickerClicked:(UIDatePicker *)datePicker{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    _timeTF.text = [dateFormatter stringFromDate:datePicker.date];
}

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 200)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
        _datePicker.minimumDate = [NSDate date];
        [_datePicker addTarget:self action:@selector(datePickerClicked:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

@end
