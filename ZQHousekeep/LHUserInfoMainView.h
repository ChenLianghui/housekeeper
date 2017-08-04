//
//  LHUserInfoMainView.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/30.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHUserModel.h"

typedef void(^ClickIconBlock)();

@interface LHUserInfoMainView : UIView

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)LHUserModel *userModel;
@property (nonatomic,copy)ClickIconBlock block;
@property (nonatomic,strong)UITextField *BirthdayTF;

@end
