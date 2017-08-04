//
//  LHUserModel.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/30.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHBaseModel.h"

@interface LHUserModel : LHBaseModel

@property (nonatomic,copy)NSString *headImageUrl;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *email;
@property (nonatomic,copy)NSString *phoneNumber;
@property (nonatomic,copy)NSString *birthday;

@end
