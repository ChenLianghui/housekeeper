//
//  LHAppointmentCollectionViewCell.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/3.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHAppointmentCollectionViewCell.h"

@interface LHAppointmentCollectionViewCell ()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *roomLabel;
@property (nonatomic,strong)UILabel *useLabel;//用途
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *numberLabel;

@end

@implementation LHAppointmentCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
        self.backgroundColor = [UIColor whiteColor];
        [LHUtils addShadowWithView:self];
    }
    return self;
}

- (void)createSubViews{
    _imageView = [UIImageView new];
    [self.contentView addSubview:_imageView];
    
    _roomLabel = [UILabel new];
    _roomLabel.font = [UIFont appFontTwo];
    [self.contentView addSubview:_roomLabel];
    
    _useLabel = [UILabel new];
    _useLabel.font = [UIFont appFontThree];
    _useLabel.textColor = [UIColor grayFontColor];
    [self.contentView addSubview:_useLabel];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont appFontThree];
    _timeLabel.textColor = [UIColor grayFontColor];
    [self.contentView addSubview:_timeLabel];
    
    _numberLabel = [UILabel new];
    _numberLabel.font = [UIFont appFontThree];
    _numberLabel.textColor = [UIColor grayFontColor];
    _numberLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_numberLabel];
    
    [_imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kCellContentMargin);
        make.centerY.equalTo(self.contentView.centerY);
        make.width.equalTo(kWidthIphone7(70));
        make.height.equalTo(kWidthIphone7(70));
    }];
    
    [_useLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.right).offset(kCellContentMargin);
        make.centerY.equalTo(self.contentView.centerY);
        make.right.equalTo(self.contentView.right).offset(-kCellContentMargin);
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(kCellContentMargin);
        make.right.equalTo(_useLabel.right);
        make.width.equalTo(kWidthIphone7(70));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_roomLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.right).offset(kCellContentMargin);
        make.top.equalTo(_numberLabel.top);
        make.height.equalTo(_numberLabel.height);
        make.right.equalTo(_numberLabel.left).offset(-kWidthIphone7(5));
    }];
    
    [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_roomLabel.left);
        make.top.equalTo(_useLabel.bottom).offset(kHeightIphone7(5));
        make.right.equalTo(self.contentView.right).offset(-kCellContentMargin);
        make.height.equalTo(_numberLabel.height);
    }];
}

- (void)setAppointModel:(LHAppointmentModel *)appointModel{
    _appointModel = appointModel;
    UIImage *image = [UIImage imageNamed:appointModel.imageName];
    _imageView.image = [image roundImageWithCornerRadius:kWidthIphone7(10)];
    _roomLabel.text = appointModel.roomName;
    _useLabel.text = appointModel.useStr;
    _timeLabel.text = appointModel.timeStr;
    _numberLabel.text = appointModel.numberStr;
}

- (void)setPetModel:(LHPetTrustModel *)petModel{
    _petModel = petModel;
    UIImage *image = [UIImage imageNamed:petModel.imageNameStr];
    _imageView.image = [image roundImageWithCornerRadius:kWidthIphone7(10)];
    _roomLabel.text = petModel.type;
    _useLabel.text = petModel.species;
    _timeLabel.text = petModel.time;
    _numberLabel.text = petModel.numberStr;
}

@end
