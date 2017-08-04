//
//  LHNoticeViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/27.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHNoticeViewController.h"
#import "LHLongPressView.h"

@interface LHNoticeViewController ()

@property (nonatomic,strong)LHLongPressView *longPressView;

@end

@implementation LHNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Notice";
    [self.view addSubview:self.longPressView];
    // Do any additional setup after loading the view.
}

- (LHLongPressView *)longPressView{
    if (!_longPressView) {
        _longPressView = [[LHLongPressView alloc] initWithFrame:CGRectMake(kBorderMargin, kHeightIphone7(35),kScreenSize.width-kBorderMargin*2 , kHeightIphone7(220)) andImageArray:@[@"1.jpg",@"2.jpg",@"3.jpg"]];
    }
    return _longPressView;
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
