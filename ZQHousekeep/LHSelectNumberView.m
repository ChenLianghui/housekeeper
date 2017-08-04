//
//  LHSelectNumberView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/4.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHSelectNumberView.h"

@interface LHSelectNumberView ()<UITextFieldDelegate>
{
    int _currentNumber;
}
@property (nonatomic,strong)UIButton *jianButton;
@property (nonatomic,strong)UIButton *addButton;
@property (nonatomic,strong)UITextField *numberTF;

@end

@implementation LHSelectNumberView

- (instancetype)init{
    if (self = [super init]) {
        _currentNumber = 1;
        [self createSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        [self createSubViews];
//        self.backgroundColor = [UIColor whiteColor];
//        _currentNumber = 1;
//    }
//    return self;
//}

+ (instancetype)createNumberViewWithMinNumber:(int)minNumber maxNumbder:(int)maxNumber{
    LHSelectNumberView *numberView = [[LHSelectNumberView alloc] init];
    numberView.minNumber = minNumber;
    numberView.maxNumber = maxNumber;
    return numberView;
}

- (void)createSubViews{
    _jianButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_jianButton setImage:[UIImage imageNamed:@"jian_gray"] forState:UIControlStateNormal];
    _jianButton.userInteractionEnabled = NO;
    [_jianButton setImageEdgeInsets:UIEdgeInsetsMake(kWidthIphone7(7.5), kWidthIphone7(7.5), kWidthIphone7(7.5), kWidthIphone7(7.5))];
    [_jianButton setBackgroundColor:[UIColor whiteColor]];
    [_jianButton addTarget:self action:@selector(jianButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_jianButton];
    
    _numberTF = [UITextField new];
    _numberTF.font = [UIFont appFontThree];
    _numberTF.textColor = [UIColor grayFontColor];
    _numberTF.textAlignment = NSTextAlignmentCenter;
    _numberTF.keyboardType = UIKeyboardTypeNumberPad;
    _numberTF.delegate = self;
    _numberTF.text = [NSString stringWithFormat:@"%d",_currentNumber];
    [self addSubview:_numberTF];
    
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addButton setImage:[UIImage imageNamed:@"addNumber"] forState:UIControlStateNormal];
    [_addButton setImageEdgeInsets:UIEdgeInsetsMake(kWidthIphone7(7.5), kWidthIphone7(7.5), kWidthIphone7(7.5), kWidthIphone7(7.5))];
    [_addButton setBackgroundColor:[UIColor whiteColor]];
    [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
    
    [_jianButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.equalTo(kWidthIphone7(30));
        make.height.equalTo(kWidthIphone7(30));
        make.centerY.equalTo(self.centerY);
    }];
    
    [_addButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right);
        make.centerY.equalTo(self.centerY);
        make.width.equalTo(_jianButton.width);
        make.height.equalTo(_jianButton.width);
    }];
    
    [_numberTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_jianButton.right);
        make.height.equalTo(_jianButton.height);
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(_addButton.left);
    }];
    
    
}

- (void)jianButtonClick{
    _currentNumber--;
    if (_currentNumber == _minNumber) {
        [self reachToTheLowestNumber];
    }
    [_addButton setImage:[UIImage imageNamed:@"addNumber"] forState:UIControlStateNormal];
    _addButton.userInteractionEnabled = YES;
    _numberTF.text = [NSString stringWithFormat:@"%d",_currentNumber];
}

- (void)addButtonClick{
    _currentNumber++;
    if (_currentNumber == _maxNumber) {
        [self reachToTheHeightNumber];
    }
    [_jianButton setImage:[UIImage imageNamed:@"jianNumber"] forState:UIControlStateNormal];
    _jianButton.userInteractionEnabled = YES;
    _numberTF.text = [NSString stringWithFormat:@"%d",_currentNumber];
}

- (void)setMinNumber:(int)minNumber{
    _minNumber = minNumber;
}

- (void)setMaxNumber:(int)maxNumber{
    _maxNumber = maxNumber;
}

- (void)reachToTheLowestNumber{
    [_jianButton setImage:[UIImage imageNamed:@"jian_gray"] forState:UIControlStateNormal];
    _jianButton.userInteractionEnabled = NO;
    [_addButton setImage:[UIImage imageNamed:@"addNumber"] forState:UIControlStateNormal];
    _addButton.userInteractionEnabled = YES;
//    if (self.delegate && [self.delegate respondsToSelector:@selector(hadReachedTheLowestNumber)]) {
//        [self.delegate hadReachedTheLowestNumber];
//    }
}

- (void)reachToTheHeightNumber{
    [_addButton setImage:[UIImage imageNamed:@"add_gray"] forState:UIControlStateNormal];
    _addButton.userInteractionEnabled = NO;
    [_jianButton setImage:[UIImage imageNamed:@"jianNumber"] forState:UIControlStateNormal];
    _jianButton.userInteractionEnabled = YES;
//    if (self.delegate &&[self.delegate respondsToSelector:@selector(hadReachedTheHighestNumber)]) {
//        [self.delegate hadReachedTheHighestNumber];
//    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    int number = [textField.text intValue];
    if (number == _minNumber) {
        [self reachToTheLowestNumber];
        
        _currentNumber = [textField.text intValue];
    }else if(number < _minNumber){
        if (self.delegate && [self.delegate respondsToSelector:@selector(hadReachedTheLowestNumber)]) {
            [self.delegate hadReachedTheLowestNumber];
        }
        _numberTF.text = [NSString stringWithFormat:@"%d",_currentNumber];
    }else if (number == _maxNumber) {
        [self reachToTheHeightNumber];
        _currentNumber = [textField.text intValue];
        
    }else if (number > _maxNumber){
        if (self.delegate &&[self.delegate respondsToSelector:@selector(hadReachedTheHighestNumber)]) {
            [self.delegate hadReachedTheHighestNumber];
        }
        _numberTF.text = [NSString stringWithFormat:@"%d",_currentNumber];
    }else{
        _currentNumber = [textField.text intValue];
        [_jianButton setImage:[UIImage imageNamed:@"jianNumber"] forState:UIControlStateNormal];
        _jianButton.userInteractionEnabled = YES;
        [_addButton setImage:[UIImage imageNamed:@"addNumber"] forState:UIControlStateNormal];
        _addButton.userInteractionEnabled = YES;
    }
}

@end
