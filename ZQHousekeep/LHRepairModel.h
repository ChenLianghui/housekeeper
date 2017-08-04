//
//  LHRepairModel.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/14.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHBaseModel.h"

@interface LHRepairModel : LHBaseModel

@property (nonatomic,copy)NSString *numberStr;
@property (nonatomic,copy)NSString *stateStr;
@property (nonatomic,copy)NSString *titleStr;
@property (nonatomic,copy)NSArray *imageViewArray;

@end
