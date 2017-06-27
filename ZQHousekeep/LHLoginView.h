//
//  LHLoginView.h
//  LHSmartLock
//
//  Created by 陈良辉 on 2017/6/5.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHTextField.h"

@protocol LHLoginViewDelegate <NSObject>

@optional

- (void)ButtonHadClickedWithTag:(NSInteger)tag;

@end

@interface LHLoginView : UIView

@property (nonatomic,strong)LHTextField *userTextField;
@property (nonatomic,strong)LHTextField *passwordTextField;
@property (nonatomic,weak) id<LHLoginViewDelegate> delegate;

@end
