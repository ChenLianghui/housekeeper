//
//  LHEditPetView.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/12.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHSelectPhotoView.h"

typedef void(^getHeightBlock)(CGFloat height);
typedef void(^getSelectedImages)(NSArray *imagesArray);

//@protocol LHEditPetViewDelegate <NSObject>
//
//- (void)getEditPetViewHeight:(CGFloat )height;
//
//@end


@interface LHEditPetView : UIScrollView

//@property (nonatomic,weak) id<LHEditPetViewDelegate> delegate;
@property (nonatomic,strong)LHSelectPhotoView *photoView;
@property (nonatomic,copy) getHeightBlock heightBlock;
@property (nonatomic,copy) getSelectedImages imagesBlock;
@property (nonatomic,strong)UITextField *typeTF;
@property (nonatomic,strong)UITextField *speciesTF;
@property (nonatomic,strong)UITextField *startTimeTF;
@property (nonatomic,strong)UITextField *endTimeTF;

@end
