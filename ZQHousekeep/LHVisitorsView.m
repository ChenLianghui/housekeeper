//
//  LHVisitorsView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/5.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHVisitorsView.h"

@interface LHVisitorsView ()<UITextViewDelegate,RKTagsViewDelegate,UITextFieldDelegate>

{
    CGFloat _desLabelHeight;
}

@property (nonatomic,strong)UIScrollView *scrollview;
@property (nonatomic,strong)UIButton *maleButton;
@property (nonatomic,strong)UIButton *femaleButton;
@property (nonatomic,strong)UIButton *yesButton;
@property (nonatomic,strong)UIButton *noButton;
@property (nonatomic,strong)UIButton *addCarButton;
@property (nonatomic,strong)UILabel *desLabel;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UIDatePicker *datePicker;

@end

@implementation LHVisitorsView

- (instancetype)init{
    if (self = [super init]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    _scrollview = [UIScrollView new];
    _scrollview.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollview];
    
    [_scrollview makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(kHeightIphone7(40));
        make.bottom.equalTo(-kHeightIphone7(10));
    }];
    
    NSArray *array = @[@"Name",@"Gender",@"Visit time",@"Driving",@"Plate number"];
    for (int i = 0; i < array.count; i++) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor grayFontColor];
        label.font = [UIFont appFontThree];
        label.text = array[i];
        [_scrollview addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kCellContentMargin);
            make.width.equalTo(kWidthIphone7(100));
            make.top.equalTo(kHeightIphone7(5)+(kHeightIphone7(40)*i));
            if (i == array.count-1) {
                _numberLabel = label;
                make.height.equalTo(0);
            }else{
                make.height.equalTo(kHeightIphone7(20));
            }
        }];
    }
    
    _nameTF = [UITextField new];
    _nameTF.textColor = [UIColor grayFontColor];
    _nameTF.font = [UIFont appFontThree];
    _nameTF.placeholder = @"please enter the name";
    [_scrollview addSubview:_nameTF];
    
    _maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_maleButton setTitle:@"male" forState:UIControlStateNormal];
    _maleButton.titleLabel.font = [UIFont appFontThree];
    [_maleButton setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
    [_maleButton addTarget:self action:@selector(GenderButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_maleButton];
    
    _femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_femaleButton setTitle:@"female" forState:UIControlStateNormal];
    _femaleButton.titleLabel.font = [UIFont appFontThree];
    [_femaleButton setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
    [_femaleButton addTarget:self action:@selector(GenderButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_femaleButton];
    
    _timeTF = [UITextField new];
    _timeTF.textColor = [UIColor grayFontColor];
    _timeTF.font = [UIFont appFontThree];
    _timeTF.placeholder = @"Please select the time";
    _timeTF.inputView = self.datePicker;
    [_scrollview addSubview:_timeTF];
    
    _yesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_yesButton setTitle:@"Yes" forState:UIControlStateNormal];
    _yesButton.titleLabel.font = [UIFont appFontThree];
    [_yesButton setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
    [_yesButton addTarget:self action:@selector(DriveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_yesButton];
    
    _noButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_noButton setTitle:@"No" forState:UIControlStateNormal];
    _noButton.titleLabel.font = [UIFont appFontThree];
    [_noButton setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
    [_noButton addTarget:self action:@selector(DriveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_noButton];
    
    
    _carView = [[RKTagsView alloc] initWithFrame:CGRectZero];
    _carView.textField.font = [UIFont appFontThree];
    _carView.textField.textColor = [UIColor grayFontColor];
    _carView.textField.placeholder = @"enter your car number";
    _carView.interitemSpacing = kWidthIphone7(12);
    _carView.hidden = YES;
    _carView.delegate = self;
    _carView.textField.delegate = self;
    _carView.scrollView.scrollEnabled = NO;
    [_scrollview addSubview:_carView];
    
    _addCarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addCarButton setImage:[UIImage imageNamed:@"addNumber"] forState:UIControlStateNormal];
    [_addCarButton addTarget:self action:@selector(AddButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _addCarButton.hidden = YES;
    [_scrollview addSubview:_addCarButton];
    
    _desLabel = [UILabel new];
    _desLabel.text = @"Please fill in any of the names if you are traveling with more than one personnumber.\nPlease fill in all the vehicle brands entering the area";
    _desLabel.numberOfLines = 0;
    _desLabel.font = [UIFont appFontThree];
    _desLabel.textColor = [UIColor grayFontColor];
    [_scrollview addSubview:_desLabel];
    _desLabelHeight = [LHUtils getSizeWithStr:_desLabel.text Width:kScreenSize.width -kBorderMargin*2-kCellContentMargin*2 Font:[UIFont appFontThree]].height;
    
    [_nameTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(130));
        make.width.equalTo(kWidthIphone7(150));
        make.top.equalTo(kHeightIphone7(5));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_maleButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameTF.left);
        make.top.equalTo(_nameTF.bottom).offset(kHeightIphone7(20));
        make.width.equalTo(kWidthIphone7(40));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_femaleButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_maleButton.right).offset(kWidthIphone7(10));
        make.top.equalTo(_maleButton.top);
        make.width.equalTo(kWidthIphone7(50));
        make.height.equalTo(_maleButton.height);
    }];
    
    [_timeTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameTF.left);
        make.width.equalTo(_nameTF.width);
        make.top.equalTo(_maleButton.bottom).offset(kHeightIphone7(20));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_yesButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameTF.left);
        make.top.equalTo(_timeTF.bottom).offset(kHeightIphone7(20));
        make.width.equalTo(kWidthIphone7(40));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_noButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_yesButton.right).offset(kWidthIphone7(10));
        make.top.width.height.equalTo(_yesButton);
    }];
    
    [_carView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(130));
        make.width.equalTo(_nameTF.width);
        make.top.equalTo(_yesButton.bottom).offset(kHeightIphone7(20));
        make.height.equalTo(kHeightIphone7(50)).priority(1);
    }];
    
    [_addCarButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(kWidthIphone7(15));
        make.left.equalTo(_carView.right).offset(kWidthIphone7(5));
        make.bottom.equalTo(_carView.bottom).offset(-kHeightIphone7(3));
        make.height.equalTo(kWidthIphone7(15));
    }];
    
    [_desLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kCellContentMargin);
        make.centerX.equalTo(_scrollview.centerX);
        make.top.equalTo(_yesButton.bottom).offset(kHeightIphone7(20));
        make.height.equalTo(_desLabelHeight).priority(1);
        make.bottom.equalTo(-kHeightIphone7(20));
    }];
    
    
    
    self.viewHeight = 5*kHeightIphone7(40)+_desLabelHeight+kHeightIphone7(20)+kHeightIphone7(40)+kHeightIphone7(10);
}

- (void)GenderButtonClicked:(UIButton *)button{
    [_currentGenderButton setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor appThemeColor] forState:UIControlStateNormal];
    _currentGenderButton = button;
}

- (void)DriveButtonClicked:(UIButton *)button{
    if ([button.titleLabel.text isEqualToString:@"Yes"]&&![_currentDriveButton.titleLabel.text isEqualToString:@"Yes"]) {
        [_numberLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(kHeightIphone7(20));
        }];
        [_addCarButton updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(kHeightIphone7(15));
        }];
        _carView.hidden = NO;
        [_desLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kCellContentMargin);
            make.centerX.equalTo(_scrollview.centerX);
            make.top.equalTo(_carView.bottom).offset(kHeightIphone7(20));
            make.height.equalTo(_desLabelHeight).priority(1);
            make.bottom.equalTo(-kHeightIphone7(20));
        }];
    }else if ([button.titleLabel.text isEqualToString:@"No"]&&![_currentDriveButton.titleLabel.text isEqualToString:@"No"]){
        _carView.hidden = YES;

        [_numberLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(kHeightIphone7(0));
        }];
        [_addCarButton updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];

        [_desLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kCellContentMargin);
            make.centerX.equalTo(_scrollview.centerX);
            make.top.equalTo(_yesButton.bottom).offset(kHeightIphone7(20));
            make.height.equalTo(_desLabelHeight).priority(1);
            make.bottom.equalTo(-kHeightIphone7(20));
            
        }];
        
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [_currentDriveButton setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor appThemeColor] forState:UIControlStateNormal];
    _currentDriveButton = button;
}

- (void)datePickerClicked:(UIDatePicker *)picker{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:ss"];
    _timeTF.text = [formatter stringFromDate:picker.date];
}

//- (void)AddButtonClicked:(UIButton *)button{
//    UITextField *newTF = [UITextField new];
//    newTF.textColor = [UIColor grayFontColor];
//    newTF.font = [UIFont appFontThree];
//    [_scrollview addSubview:newTF];
//}

//- (void)textViewDidChange:(UITextView *)textView{
//    NSInteger maxHeight = ceil(textView.font.lineHeight * 4 + textView.textContainerInset.top + textView.textContainerInset.bottom);
//    
//    NSInteger height = ceilf([textView sizeThatFits:CGSizeMake(textView.bounds.size.width, MAXFLOAT)].height);
//    if (maxHeight != height) {
//        textView.scrollEnabled = height > maxHeight && maxHeight > 0;
//        maxHeight = height;
//        if (textView.scrollEnabled == NO) {
//            [textView updateConstraints:^(MASConstraintMaker *make) {
//                make.height.equalTo(height);
//            }];
//            [self setNeedsLayout];
//            [self layoutIfNeeded];
//        }
//    }
//}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 200)];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
        [_datePicker addTarget:self action:@selector(datePickerClicked:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

@end
