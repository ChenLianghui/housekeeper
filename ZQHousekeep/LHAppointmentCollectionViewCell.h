//
//  LHAppointmentCollectionViewCell.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/3.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHAppointmentModel.h"
#import "LHPetTrustModel.h"

@interface LHAppointmentCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)LHAppointmentModel *appointModel;
@property (nonatomic,strong)LHPetTrustModel *petModel;

@end
