//
//  LHBaseSignViewController.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/23.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHBaseViewController.h"

@interface LHBaseSignViewController : LHBaseViewController

@property (nonatomic,strong)UITextField *firsteTF;
@property (nonatomic,strong)UITextField *secondTF;
@property (nonatomic,copy)NSArray *titleArray;
@property (nonatomic,copy)NSArray *placeholderArray;
@property (nonatomic,assign)BOOL isHadVcode;
@property (nonatomic,assign)BOOL isLostCodeOne;//是否是忘记密码第一步

@end
