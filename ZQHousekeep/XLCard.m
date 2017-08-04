//
//  Card.m
//  CardSwitchDemo
//
//  Created by Apple on 2016/11/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "XLCard.h"
#import "XLCardItem.h"

@interface XLCard () {
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_desLabel;
}
@end

@implementation XLCard

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
//    self.layer.cornerRadius = 10.0f;
//    self.layer.masksToBounds = true;
    self.backgroundColor = [UIColor whiteColor];
    [LHUtils addShadowWithView:self];
    
//    CGFloat labelHeight = self.bounds.size.height * 0.20f;
    CGFloat imageViewHeight = self.bounds.size.height;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, imageViewHeight)];
//    _imageView.center = self.center;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.layer.masksToBounds = true;
    _imageView.layer.cornerRadius = kWidthIphone7(8);
    
    [self addSubview:_imageView];
    
//    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageViewHeight, self.bounds.size.width, labelHeight)];
//    _textLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
//    _textLabel.font = [UIFont systemFontOfSize:22];
//    _textLabel.textAlignment = NSTextAlignmentCenter;
//    _textLabel.adjustsFontSizeToFitWidth = true;
//    [self addSubview:_textLabel];
    _titleLabel = [UILabel new];
    _titleLabel.text = @"2017.06.21 Notice";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont appFontTwo];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.shadowColor = [UIColor blackColor];
    _titleLabel.shadowOffset = CGSizeMake(1, 1);
    [self addSubview:_titleLabel];
    
    _desLabel = [UILabel new];
    _desLabel.text = @"We will look into how to build communities that are able to quickly respond to disaster risks.";
    _desLabel.numberOfLines = 0;
    _desLabel.textAlignment = NSTextAlignmentCenter;
    _desLabel.font = [UIFont appFontThree];
    _desLabel.textColor = [UIColor whiteColor];
    _desLabel.shadowColor = [UIColor blackColor];
    _desLabel.shadowOffset = CGSizeMake(1, 1);
    [self addSubview:_desLabel];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(kHeightIphone7(10));
        make.centerX.equalTo(self.contentView.centerX);
        make.height.equalTo(kHeightIphone7(30));
        
    }];
    
    [_desLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.left);
        make.centerX.equalTo(_titleLabel.centerX);
        make.top.equalTo(_titleLabel.bottom).offset(kHeightIphone7(0));
        make.height.equalTo(kHeightIphone7(60));
    }];
    
//    UIVisualEffectView *visuleffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//    visuleffectView.frame = _imageView.bounds;
//    [_imageView addSubview:visuleffectView];
}

-(void)setItem:(XLCardItem *)item {
    _imageView.image = [UIImage imageNamed:item.imageName];
//    _textLabel.text = item.title;
}

@end
