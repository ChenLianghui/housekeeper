//
//  ZQTabBarController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/21.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "ZQTabBarController.h"
#import "ZQNavigationController.h"
#import "ZQHomeViewController.h"
#import "ZQActivityViewController.h"
#import "ZQFamilyViewController.h"

@interface ZQTabBarController ()

@end

@implementation ZQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabbarStyle];
    [self initSubViewControllers];
    // Do any additional setup after loading the view.
}

- (void)initTabbarStyle{
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor appThemeColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    self.tabBar.tintColor = [UIColor appThemeColor];
    [UITabBar appearance].translucent = NO;
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
}

- (void)initSubViewControllers{
    ZQHomeViewController *HomeVC = [[ZQHomeViewController alloc] init];
    HomeVC.title = @"Service";
    HomeVC.tabBarItem.title = @"Service";
    HomeVC.tabBarItem.image = [UIImage imageNamed:@"main"];
    HomeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"main_selected"];
    ZQNavigationController *HomeNAV = [[ZQNavigationController alloc] initWithRootViewController:HomeVC];
    
    ZQActivityViewController *activityVC = [[ZQActivityViewController alloc] init];
    activityVC.title = @"Activity";
    activityVC.tabBarItem.title =@"Activity";
    activityVC.tabBarItem.image = [UIImage imageNamed:@"set"];
    activityVC.tabBarItem.selectedImage = [UIImage imageNamed:@"set_selected"];
    ZQNavigationController *activityNav = [[ZQNavigationController alloc] initWithRootViewController:activityVC];
    
    ZQFamilyViewController *familyVC = [[ZQFamilyViewController alloc] init];
    familyVC.title = @"Family";
    familyVC.tabBarItem.title = @"Family";
    familyVC.tabBarItem.image = [UIImage imageNamed:@"mine"];
    familyVC.tabBarItem.selectedImage = [UIImage imageNamed:@"mine_selected"];
    ZQNavigationController *familyNav = [[ZQNavigationController alloc] initWithRootViewController:familyVC];
    
    self.viewControllers = @[activityNav,HomeNAV,familyNav];
    self.selectedIndex = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
