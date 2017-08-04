//
//  LHProfileCollectionViewCell.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/30.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHMemberModel.h"
#import "LHVisitorModel.h"

@interface LHProfileCollectionViewCell : UICollectionViewCell

@property (nonatomic,assign)BOOL isMembers;//判断是家庭成员还是访客
@property (nonatomic,strong)LHMemberModel *memeberModel;
@property (nonatomic,strong)LHVisitorModel *visitorModel;

@end
