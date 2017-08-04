//
//  LHAddRepairView.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/24.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHSelectPhotoView.h"

typedef void(^getHeightBlock)(CGFloat height);
typedef void(^getSelectedImages)(NSArray *imagesArray);

@interface LHAddRepairView : UIScrollView

@property (nonatomic,strong)LHSelectPhotoView *photoView;
@property (nonatomic,copy) getHeightBlock heightBlock;
@property (nonatomic,copy) getSelectedImages imagesBlock;
@property (nonatomic,strong)UITextField *nameTF;
@property (nonatomic,strong)UITextField *titleTF;
@property (nonatomic,strong)UITextField *timeTF;
@property (nonatomic,strong)UITextView *remarkTextview;

@end
