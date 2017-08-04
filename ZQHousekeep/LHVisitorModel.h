//
//  LHVisitorModel.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/30.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHBaseModel.h"

@interface LHVisitorModel : LHBaseModel

@property (nonatomic,copy)NSString *iconStr;
@property (nonatomic,copy)NSString *nameStr;
@property (nonatomic,copy)NSString *operatorName;
@property (nonatomic,copy)NSString *timeStr;

@end
