//
//  LHRepairCollectionViewCell.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/14.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHRepairCollectionViewCell.h"
#import "JJPhotoManeger.h"

#define kImageViewWidth kWidthIphone7(80)

@interface LHRepairCollectionViewCell ()

@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *stateLabel;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIScrollView *imageViews;

@end

@implementation LHRepairCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [LHUtils addShadowWithView:self];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    _numberLabel = [UILabel new];
    _numberLabel.textColor = [UIColor grayFontColor];
    _numberLabel.font = [UIFont appFontThree];
    [self.contentView addSubview:_numberLabel];
    
    _stateLabel = [UILabel new];
    _stateLabel.textColor = [UIColor grayFontColor];
    _stateLabel.font = [UIFont appFontThree];
    [self.contentView addSubview:_stateLabel];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor grayFontColor];
    _titleLabel.font = [UIFont appFontThree];
    [self.contentView addSubview:_titleLabel];
    
    _imageViews = [UIScrollView new];
    _imageViews.backgroundColor = [UIColor clearColor];
    _imageViews.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:_imageViews];
    
    [_stateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-kCellContentMargin);
        make.top.equalTo(kHeightIphone7(10));
        make.width.equalTo(kWidthIphone7(80));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kCellContentMargin);
        make.top.equalTo(_stateLabel);
        make.right.equalTo(_stateLabel.left).offset(-kWidthIphone7(10));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(_numberLabel);
        make.right.equalTo(_stateLabel);
        make.top.equalTo(_numberLabel.bottom).offset(kHeightIphone7(20));
    }];
    
    [_imageViews makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_numberLabel);
        make.right.equalTo(_stateLabel);
        make.top.equalTo(_titleLabel.bottom).offset(kHeightIphone7(20));
        make.height.equalTo(kImageViewWidth);
    }];
}

- (void)setModel:(LHRepairModel *)model{
    _model = model;
    _numberLabel.text = model.numberStr;
    _stateLabel.text = model.stateStr;
    _titleLabel.text = model.titleStr;
    for (int i = 0; i < model.imageViewArray.count; i++) {
        UIImageView *imageView = model.imageViewArray[i];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 40+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [_imageViews addSubview:imageView];
        
        [imageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo((kImageViewWidth + kWidthIphone7(10))*i);
            make.top.equalTo(_imageViews);
            make.width.equalTo(kImageViewWidth);
            make.height.equalTo(kImageViewWidth);
        }];
    }
    
    if (model.imageViewArray.count>3) {
        _imageViews.contentSize = CGSizeMake(kImageViewWidth*model.imageViewArray.count+kWidthIphone7(10)*(model.imageViewArray.count-1), 0);
    }
}

- (void)tapImageView:(UITapGestureRecognizer *)tap{
//    UIImageView *imageView = (UIImageView *)tap.view;
    JJPhotoManeger *mg = [JJPhotoManeger maneger];
    [mg showLocalPhotoViewer:_model.imageViewArray selecImageindex:tap.view.tag-40];
}

@end
