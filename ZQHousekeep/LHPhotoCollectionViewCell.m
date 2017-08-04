//
//  LHPhotoCollectionViewCell.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/10.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHPhotoCollectionViewCell.h"

@implementation LHPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    _profilePhoto = [UIImageView new];
    [self.contentView addSubview:_profilePhoto];
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"closePhoto"] forState:UIControlStateNormal];
    [self.contentView addSubview:_closeButton];
    
    [_profilePhoto makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(kWidthIphone7(5));
        make.right.bottom.equalTo(-kWidthIphone7(5));
    }];
    
    [_closeButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(kWidthIphone7(20), kWidthIphone7(20)));
    }];
}

/** 查看大图 */
- (void)setBigImageViewWithImage:(UIImage *)img{
    if (_BigImageView) {
        //如果大图正在显示，还原小图
        _BigImageView.frame = _profilePhoto.frame;
        _BigImageView.image = img;
    }else{
        _BigImageView = [[UIImageView alloc] initWithImage:img];
        _BigImageView.frame = _profilePhoto.frame;
        [self insertSubview:_BigImageView atIndex:0];
    }
    _BigImageView.contentMode = UIViewContentModeScaleToFill;
}

@end
