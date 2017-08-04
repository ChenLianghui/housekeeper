//
//  LHProfileCollectionViewCell.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/30.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHProfileCollectionViewCell.h"

@interface LHProfileCollectionViewCell ()

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *operatorLabel;
@property (nonatomic,strong)UILabel *relationLabel;//若是visitor，则是时间

@end

@implementation LHProfileCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
        self.backgroundColor = [UIColor whiteColor];
        [LHUtils addShadowWithView:self];
    }
    return self;
}

- (void)createSubViews{
    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    
    _nameLabel = [UILabel new];
    _nameLabel.textColor = [UIColor grayFontColor];
    _nameLabel.font = [UIFont appFontThree];
    [self.contentView addSubview:_nameLabel];
    
    _operatorLabel = [UILabel new];
    _operatorLabel.textColor = [UIColor grayFontColor];
    _operatorLabel.font = [UIFont appFontFour];
    [self.contentView addSubview:_operatorLabel];
    
    _relationLabel = [UILabel new];
    _relationLabel.textColor = [UIColor grayFontColor];
    _relationLabel.font = [UIFont appFontThree];
    _relationLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_relationLabel];
    
    [_iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kCellContentMargin);
        make.centerY.equalTo(self.contentView.centerY);
        make.width.equalTo(kWidthIphone7(40));
        make.height.equalTo(kWidthIphone7(40));
    }];
    
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.right).offset(kWidthIphone7(12));
        make.centerY.equalTo(self.contentView.centerY);
        make.width.equalTo(kWidthIphone7(80));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_operatorLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.right).offset(kWidthIphone7(10));
        make.centerY.equalTo(self.contentView.centerY);
        make.width.equalTo(kWidthIphone7(80));
        make.height.equalTo(kHeightIphone7(20));
    }];
    
    [_relationLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-kCellContentMargin);
        make.centerY.equalTo(self.contentView.centerY);
        make.width.equalTo(kWidthIphone7(50));
        make.height.equalTo(kHeightIphone7(20));
    }];
//    [self.contentView setNeedsLayout];
//    [self.contentView layoutIfNeeded];
    
}

- (void)setIsMembers:(BOOL)isMembers{
    _isMembers = isMembers;
    if (_isMembers) {
        _operatorLabel.hidden = YES;
    }else{
        _operatorLabel.hidden = NO;
    }
}

- (void)setMemeberModel:(LHMemberModel *)memeberModel{
    _memeberModel = memeberModel;
    UIImage *image = [UIImage imageNamed:memeberModel.iconStr];
    _iconImageView.image = [image roundImageWithCornerRadius:image.size.width/2.];
    _nameLabel.text = memeberModel.nameStr;
    _relationLabel.text = memeberModel.relationStr;
}

- (void)setVisitorModel:(LHVisitorModel *)visitorModel{
    _visitorModel = visitorModel;
    UIImage *image = [UIImage imageNamed:visitorModel.iconStr];
    _iconImageView.image = [image roundImageWithCornerRadius:image.size.width/2.];
    _nameLabel.text = visitorModel.nameStr;
    _operatorLabel.text = [NSString stringWithFormat:@"by %@",visitorModel.operatorName];
    _relationLabel.text = visitorModel.timeStr;
}

@end
