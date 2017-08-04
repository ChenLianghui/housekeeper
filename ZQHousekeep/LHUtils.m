//
//  LHUtils.m
//  APPBaseDemo
//
//  Created by 陈良辉 on 2017/5/23.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHUtils.h"

@implementation LHUtils

+ (BOOL)isEmptyStr:(NSString*)str {
    if(str != nil && [str isKindOfClass:[NSString class]] && str.length > 0)
    return NO;
    else
    return YES;
}
  
+ (BOOL)verifyMobile:(NSString *)mobile {
    if (mobile == nil || mobile.length == 0) return NO;
    NSString    *regex = @"^(\\+86|)(|0)1\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:mobile];
}

+ (BOOL)isCurrentLanguageIsChinese{
    NSString *udfLanguageCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
    if ([udfLanguageCode isEqualToString:@"zh-Hans-US"]) {
        return YES;
    }
    return NO;
}

+ (void)callTelephoneWithString:(NSString *)mobile{
    NSString *phone = [NSString stringWithFormat:@"telprompt://%@",mobile];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:phone]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
    }
}


/**
 给view添加渐变背景颜色
 */
+ (void)changeColorViewWithView:(UIView *)view{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:71/255.0 green:183/255.0 blue:78/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:39/255.0 green:164/255.0 blue:41/255.0 alpha:1.0].CGColor, nil];
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    gradient.locations = @[@0.0,@1.0];
    [view.layer addSublayer:gradient];
}


/**
 给view加圆角，加阴影

 */
+ (void)addShadowWithView:(UIView *)view{
    //        view.layer.masksToBounds = YES; //不屏蔽的话阴影无效
    view.layer.cornerRadius = kWidthIphone7(8);
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(kWidthIphone7(2), kHeightIphone7(4));
    view.layer.shadowOpacity = 0.3;
//    view.layer.shadowRadius = kWidthIphone7(8);
}

@end
