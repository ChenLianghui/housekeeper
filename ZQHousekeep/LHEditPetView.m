//
//  LHEditPetView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/12.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHEditPetView.h"
#import "LHSelectNumberView.h"

@interface LHEditPetView ()<LHSelectPhotoViewDelegate,LHSelectNumberViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>


//@property (nonatomic,strong)UIScrollView *mainScrollView;

@property (nonatomic,strong)LHSelectNumberView *numberView;
@property (nonatomic,strong)UIPickerView *typeView;
@property (nonatomic,strong)UIPickerView *speciesView;
@property (nonatomic,strong)UIDatePicker *startDatePicker;
@property (nonatomic,strong)UIDatePicker *endDatePicker;
@property (nonatomic,copy)NSArray *typeArray;
@property (nonatomic,copy)NSArray *speciesArray;


@end

@implementation LHEditPetView

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
    
    NSArray *labelTitleArray = @[@"Type",@"Species",@"Number",@"ManagedTime",@"TakeBackTime"];
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
    
    _typeTF = [UITextField new];
    _typeTF.inputView = self.typeView;
    _typeTF.delegate = self;
    [self addSubview:_typeTF];
    
    _speciesTF = [UITextField new];
    _speciesTF.inputView = self.speciesView;
    _speciesTF.delegate = self;
    [self addSubview:_speciesTF];
    
    _numberView = [[LHSelectNumberView alloc] init];
    _numberView.minNumber = 1;
    _numberView.maxNumber = 3;
    _numberView.delegate = self;
    [self addSubview:_numberView];
    
    _startTimeTF = [UITextField new];
    _startTimeTF.delegate = self;
    _startTimeTF.inputView = self.startDatePicker;
    [self addSubview:_startTimeTF];
    
    _endTimeTF = [UITextField new];
    _endTimeTF.delegate = self;
    _endTimeTF.inputView = self.endDatePicker;
    [self addSubview:_endTimeTF];
    
    [_typeTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(150));
        make.top.equalTo(_photoView.bottom);
        make.width.equalTo(kWidthIphone7(100));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_speciesTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_typeTF);
        make.top.equalTo(_typeTF.bottom).offset(kHeightIphone7(20));
    }];
    
    [_numberView makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(_typeTF);
        make.width.equalTo(kWidthIphone7(80));
        make.top.equalTo(_speciesTF.bottom).offset(kHeightIphone7(20));
    }];
    
    [_startTimeTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.equalTo(_typeTF);
        make.top.equalTo(_numberView.bottom).offset(kHeightIphone7(20));
    }];
    
    [_endTimeTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.equalTo(_typeTF);
        make.top.equalTo(_startTimeTF.bottom).offset(kHeightIphone7(20));
    }];
}


- (NSString *)changeToStringWithDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

- (void)startDatePickerHadClicked:(UIDatePicker *)datePicker{
    _startTimeTF.text = [self changeToStringWithDate:datePicker.date];
}

- (void)endDatePickerHadClicked:(UIDatePicker *)datePicker{
    _endTimeTF.text = [self changeToStringWithDate:datePicker.date];
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

- (void)getBigImagesWithArray:(NSArray *)array{
    if (self.imagesBlock) {
        self.imagesBlock(array);
    }
}

#pragma mark - LHSelectNumberViewDelegate

- (void)hadReachedTheLowestNumber{
    [self.window.rootViewController showFailed:[NSString stringWithFormat:@"The input values cannot be less than %d",_numberView.minNumber]];
}

- (void)hadReachedTheHighestNumber{
    [self.window.rootViewController showFailed:[NSString stringWithFormat:@"The input value cannot greater than %d",_numberView.maxNumber]];
}

#pragma mark UIPickerViewDataSource && delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == self.typeView) {
        return self.typeArray.count;
    }else if (pickerView == self.speciesView){
        return self.speciesArray.count;
    }else{
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == self.typeView) {
        return self.typeArray[row];
    }else if(pickerView == self.speciesView){
        return self.speciesArray[row];
    }else{
        return nil;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == self.typeView) {
        _typeTF.text = self.typeArray[row];
    }else if(pickerView == self.speciesView){
        _speciesTF.text = self.speciesArray[row];
    }else{
        
    }
}

#pragma mark - UITextfieldDelegate

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if (textField == _typeTF) {
//        _typeTF.text = self.typeArray[0];
//    }else if (textField == _speciesTF){
//        _speciesTF.text = self.speciesArray[0];
//    }else if (textField == _startTimeTF){
//        _startTimeTF.text = [self changeToStringWithDate:_startDatePicker.date];
//    }else if (textField == _endTimeTF){
//        _endTimeTF.text = [self changeToStringWithDate:_endDatePicker.date];
//    }
//}

- (UIPickerView *)typeView{
    if (!_typeView) {
        _typeView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 200)];
        _typeView.delegate = self;
        _typeView.dataSource = self;
    }
    return _typeView;
}

- (UIPickerView *)speciesView{
    if (!_speciesView) {
        _speciesView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 200)];
        _speciesView.delegate = self;
        _speciesView.dataSource = self;
    }
    return _speciesView;
}

- (UIDatePicker *)startDatePicker{
    if (!_startDatePicker) {
        _startDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 200)];
        _startDatePicker.datePickerMode = UIDatePickerModeDate;
        _startDatePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
        _startDatePicker.minimumDate = [NSDate date];
        [_startDatePicker addTarget:self action:@selector(startDatePickerHadClicked:) forControlEvents:UIControlEventValueChanged];
    }
    return _startDatePicker;
}

- (UIDatePicker *)endDatePicker{
    if (!_endDatePicker) {
        _endDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 200)];
        _endDatePicker.datePickerMode = UIDatePickerModeDate;
        _endDatePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
        _endDatePicker.minimumDate = _startDatePicker.date;
        [_endDatePicker addTarget:self action:@selector(endDatePickerHadClicked:) forControlEvents:UIControlEventValueChanged];
    }
    return _endDatePicker;
}

- (NSArray *)typeArray{
    if (!_typeArray) {
        _typeArray = @[@"Dog",@"Cat",@"Mouse"];
    }
    return _typeArray;
}

- (NSArray *)speciesArray{
    if (!_speciesArray) {
        _speciesArray = @[@"One",@"Two",@"Three"];
    }
    return _speciesArray;
}

@end
