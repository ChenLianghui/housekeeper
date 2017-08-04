//
//  LHStepProgressView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/21.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#define kPointWidth kWidthIphone7(6)
#define kgrayColor ZQColorMaker(174, 174, 174, 1.0)

@interface LHHexagon : UIView

@property (nonatomic,strong)UIColor *hexagonColor;

@end

@implementation LHHexagon

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _hexagonColor = kgrayColor;
        [self createGraph];
    }
    return self;
}

- (void)createGraph{
    UIBezierPath* polygonPath = [UIBezierPath bezierPath];
    [polygonPath moveToPoint: CGPointMake(kWidthIphone7(4), 0)];
    [polygonPath addLineToPoint: CGPointMake(kWidthIphone7(7.46), kHeightIphone7(2))];
    [polygonPath addLineToPoint: CGPointMake(kWidthIphone7(7.46), kHeightIphone7(6))];
    [polygonPath addLineToPoint: CGPointMake(kWidthIphone7(4), kHeightIphone7(8))];
    [polygonPath addLineToPoint: CGPointMake(kWidthIphone7(0.54), kHeightIphone7(6))];
    [polygonPath addLineToPoint: CGPointMake(kWidthIphone7(0.54), kHeightIphone7(2))];
    [polygonPath closePath];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = polygonPath.CGPath;
    shapeLayer.fillColor = self.hexagonColor.CGColor;
    [self.layer addSublayer:shapeLayer];
}

- (void)setHexagonColor:(UIColor *)hexagonColor{
    _hexagonColor = hexagonColor;
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer.sublayers.firstObject;
    shapeLayer.fillColor = hexagonColor.CGColor;
}

@end

#import "LHStepProgressView.h"


@interface LHStepProgressView ()

@property (nonatomic,strong)LHHexagon *point1;
@property (nonatomic,strong)LHHexagon *point2;
@property (nonatomic,strong)LHHexagon *point3;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UIProgressView *line;


@end

@implementation LHStepProgressView

- (instancetype)init{
    if (self = [super init]) {
        [self createSubViews];
        self.backgroundColor = [UIColor whiteColor];
        [LHUtils addShadowWithView:self];
        _step = 1;
    }
    return self;
}

- (void)createSubViews{
    _line = [UIProgressView new];
    _line.progressViewStyle = UIProgressViewStyleBar;
    _line.progressTintColor = [UIColor appThemeColor];
    _line.trackTintColor = kgrayColor;
    _line.progress = 0.5;
    [self addSubview:_line];
    
    _point1 = [LHHexagon new];
    _point1.hexagonColor = [UIColor appThemeColor];
    [self addSubview:_point1];
    
    _point2 = [LHHexagon new];
    _point2.hexagonColor = kgrayColor;
    [self addSubview:_point2];
    
    _point3 = [LHHexagon new];
    _point3.hexagonColor = kgrayColor;
    [self addSubview:_point3];
    
    _label1 = [UILabel new];
    _label1.text = @"Address";
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.textColor = [UIColor appThemeColor];
    [self addSubview:_label1];
    
    _label2 = [UILabel new];
    _label2.text = @"Infomation";
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.textColor = [UIColor grayFontColor];
    [self addSubview:_label2];
    
    _label3 = [UILabel new];
    _label3.text = @"Done";
    _label3.textAlignment = NSTextAlignmentCenter;
    _label3.textColor = [UIColor grayFontColor];
    [self addSubview:_label3];
    
    [_line makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(40));
        make.centerY.equalTo(self.centerY).offset(-kHeightIphone7(5));
        make.right.equalTo(-kWidthIphone7(40));
        make.height.equalTo(kHeightIphone7(2));
    }];
    
    [_point1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(38));
        make.centerY.equalTo(_line.centerY);
        make.width.equalTo(kWidthIphone7(8));
        make.height.equalTo(kWidthIphone7(8));
    }];
    
    [_point2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_point1.top);
        make.centerX.equalTo(self.centerX);
        make.width.equalTo(_point1.width);
        make.height.equalTo(_point1.height);
    }];
    
    [_point3 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-kWidthIphone7(38));
        make.top.equalTo(_point1.top);
        make.width.equalTo(_point1.width);
        make.height.equalTo(_point1.height);
    }];
    
    [_label1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_point1.bottom).offset(kHeightIphone7(10));
        make.width.equalTo(kWidthIphone7(100));
        make.height.equalTo(kHeightIphone7(20));
        make.centerX.equalTo(_point1.centerX);
    }];
    
    [_label2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label1.top);
        make.width.equalTo(_label1.width);
        make.height.equalTo(_label1.height);
        make.centerX.equalTo(_point2.centerX);
    }];
    
    [_label3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label1.top);
        make.width.equalTo(_label1.width);
        make.height.equalTo(_label1.height);
        make.centerX.equalTo(_point3.centerX);
    }];
}

- (void)setStep:(int)step{
    _step = step;
    if (step == 2) {
        self.line.progress = 1;
        self.point2.hexagonColor = [UIColor appThemeColor];
        self.point3.hexagonColor = kgrayColor;
        self.label2.textColor = [UIColor appThemeColor];
        self.label3.textColor = [UIColor appThemeColor];
    }
    if (step == 3) {
        self.line.progress = 1;
        self.point2.hexagonColor = [UIColor appThemeColor];
        self.point3.hexagonColor = [UIColor appThemeColor];
        self.label2.textColor = [UIColor appThemeColor];
        self.label3.textColor = [UIColor appThemeColor];
    }
}


@end
