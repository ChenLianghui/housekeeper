//
//  LHActivityDetailViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/28.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHActivityDetailViewController.h"
#import "XLCardSwitch.h"
#import "LHEventHeaderView.h"

@interface LHActivityDetailViewController ()<XLCardSwitchDelegate>

@property (nonatomic,strong)XLCardSwitch *cardSwitch;
@property (nonatomic,copy)NSArray *imageNameArray;
@property (nonatomic,strong)LHEventHeaderView *headerView;

//@property (nonatomic,strong) UITextView

@end

@implementation LHActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.VcTitle;
    [self.view addSubview:self.cardSwitch];
    [self.view addSubview:self.headerView];
    // Do any additional setup after loading the view.
}

#pragma mark - CardSwitchDelegate
#pragma mark - 点击了某张图片
- (void)XLCardSwitchDidSelectedAt:(NSInteger)index {
    NSLog(@"选中了：%zd",index);
    
}

- (XLCardSwitch *)cardSwitch{
    if (!_cardSwitch) {
        _cardSwitch = [[XLCardSwitch alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kHeightIphone7(200))];
        //    _cardSwitch.center = CGPointMake(kScreenSize.width/2, CGRectGetMaxY(self.whiteView.frame)+kHeightIphone7(3));
        NSMutableArray *items = [NSMutableArray array];
        NSArray *imageArray = @[@"1.jpg",@"2.jpg",@"3.jpg"];
        for (int i = 0; i < imageArray.count; i++) {
            XLCardItem *item = [[XLCardItem alloc] init];
            item.imageName = imageArray[i];
            [items addObject:item];
        }
        _cardSwitch.items = items;
        _cardSwitch.delegate = self;
        _cardSwitch.pagingEnabled = YES;
        //        _cardSwitch.selectedIndex = 1;
    }
    return _cardSwitch;
}

- (NSArray *)imageNameArray{
    if (!_imageNameArray) {
        _imageNameArray = @[@"1.jpg",@"2.jpg"];
    }
    return _imageNameArray;
}

- (LHEventHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[LHEventHeaderView alloc] initWithFrame:CGRectMake(kBorderMargin, CGRectGetMaxY(self.cardSwitch.frame), kScreenSize.width-kBorderMargin*2, kHeightIphone7(100))];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
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
