//
//  LHAppointmentModel.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/3.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHBaseModel.h"

@interface LHAppointmentModel : LHBaseModel

@property (nonatomic,copy)NSString *imageName;
@property (nonatomic,copy)NSString *roomName;
@property (nonatomic,copy)NSString *useStr;
@property (nonatomic,copy)NSString *timeStr;
@property (nonatomic,copy)NSString *numberStr;

@end
