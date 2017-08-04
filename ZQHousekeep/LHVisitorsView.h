//
//  LHVisitorsView.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/5.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHAreaHeaderView.h"
#import "RKTagsView.h"

@interface LHVisitorsView : LHAreaHeaderView

@property (nonatomic,strong)UITextField *nameTF;
@property (nonatomic,strong)UITextField *timeTF;
//@property (nonatomic,strong)UITextView *textview;
//@property (nonatomic,strong)UITextField *carTF;
@property (nonatomic,strong)RKTagsView *carView;
@property (nonatomic,strong)UIButton *currentGenderButton;
@property (nonatomic,strong)UIButton *currentDriveButton;
@property (nonatomic,assign)CGFloat viewHeight;

@end
