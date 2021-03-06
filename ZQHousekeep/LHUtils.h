//
//  LHUtils.h
//  APPBaseDemo
//
//  Created by 陈良辉 on 2017/5/23.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ToastTop = 0,
    ToastCenter,
    ToastBottom,
} ToastPosition;

@interface LHUtils : NSObject

+ (BOOL)isEmptyStr:(NSString*)str;
    
+ (BOOL)verifyMobile:(NSString *)mobile;

+ (BOOL)isCurrentLanguageIsChinese;

//拨打电话
+(void)callTelephoneWithString:(NSString *)mobile;

+ (void)changeColorViewWithView:(UIView *)view;


+ (void)addShadowWithView:(UIView *)view;

//设置为头像有小图标的UIimageView
+ (void)createSmallIconHeaderImageWithImageView:(UIImageView *)imageView andImageName:(NSString *)imageName;

+ (CGSize) getSizeWithStr:(NSString *) str Width:(float)width Font:(UIFont *)font;
+ (CGSize) getSizeWithStr:(NSString *) str Height:(float)height Font:(UIFont *)font;
@end
