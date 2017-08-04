//
//  LHAppointmentInfoView.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/3.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHSelectNumberView.h"

@interface LHAppointmentInfoView : UIView

@property (nonatomic,strong)UITextField *roomTF;
@property (nonatomic,strong)LHSelectNumberView *numberView;
@property (nonatomic,strong)UITextField *dateTF;
@property (nonatomic,strong)UITextField *timeTF;
@property (nonatomic,strong)UITextField *useTF;

@end
