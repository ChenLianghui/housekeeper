//
//  LHSelectPhotoView.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/10.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LHSelectPhotoViewDelegate <NSObject>

@optional
//- (void)addNewImages;
- (void)getNowHeight:(CGFloat)height;
- (void)getBigImagesWithArray:(NSArray *)array;

@end

@interface LHSelectPhotoView : UIView

@property (nonatomic,assign)id<LHSelectPhotoViewDelegate> delegate;

@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)NSMutableArray *bigImageArray;

@end
