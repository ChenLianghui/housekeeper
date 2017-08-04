//
//  LHPhotoCollectionViewCell.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/10.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *profilePhoto;
@property (nonatomic,strong)UIButton *closeButton;
@property(nonatomic,strong) UIImageView *BigImageView;

/** 查看大图 */
- (void)setBigImageViewWithImage:(UIImage *)image;

@end
