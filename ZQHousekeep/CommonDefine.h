//
//  CommonDefine.h
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/20.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

#define MR_SHORTHAND
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

//导入头文件
#import "AFNetworking.h"
#import "Masonry.h"
#import "UIColor+Hex.h"
#import "UIColor+App.h"
#import "LHUtils.h"
#import "UIFont+App.h"
#import "UIImage+Extents.h"
#import "NSObject+Swizzle.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <objc/runtime.h>
#import "UIViewController+HUD.h"
#import "LHUserDefaultDefines.h"


//屏幕尺寸
#define kScreenSize ([UIScreen mainScreen].bounds.size)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenScale ([UIScreen mainScreen].scale)
#define kScreenRatio (kScreenWidth / 320)
#define kLineWidth (1.0f/kScreenScale)
#define kBorderMargin kWidthIphone7(17)
#define kCellContentMargin kWidthIphone7(15)
#define kContentMargin kSizeFrom750(15)

#define kWidthIphone7(x) (x * kScreenWidth / 375.0)
#define kHeightIphone7(x) (x * kScreenHeight / 667.0)
//根据720分辨率计算size
#define kSizeFrom720(x) (x * kScreenRatio * 320 / 720)

#define kSizeFrom750(x) (NSInteger)(x * kScreenRatio * 320 / 750)


#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;


#define ZQColorMaker(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#endif /* CommonDefine_h */
