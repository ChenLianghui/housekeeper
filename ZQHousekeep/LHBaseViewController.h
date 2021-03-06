//
//  LHBaseViewController.h
//  APPBaseDemo
//
//  Created by 陈良辉 on 2017/5/23.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^myBlock)();

@interface LHBaseViewController : UIViewController

@property (nonatomic,strong)UIView *whiteView;
@property (nonatomic,strong)UIView *WhitelineView;
@property (nonatomic,assign)BOOL isTwoTitle;
@property (nonatomic,strong)UILabel *superTitle;
@property (nonatomic,strong)UILabel *subTitle;
@property (nonatomic,assign)BOOL isClose;

- (void)addTitleViewWithName:(NSString *)name;
- (void)addTitleViewWithName:(NSString *)name textColor:(UIColor *)color;
- (void)addItemWithName:(NSString *)name isLeft:(BOOL)isleft WithBlock:(myBlock)block;
- (void)addImageWithName:(NSString *)name isLeft:(BOOL)isleft WithBlock:(myBlock)block;
- (void)addPlusItemIsLeft:(BOOL)isleft withBlock:(myBlock)block;

- (void)rotatePlus;

@end
