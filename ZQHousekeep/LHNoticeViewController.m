//
//  LHNoticeViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/27.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHNoticeViewController.h"
#import "SwipeView.h"



#define kImageWidth (kScreenSize.width-2*kBorderMargin)
@interface LHNoticeViewController ()<SwipeDelegate,SwipeViewDataSource>

@property (nonatomic,copy)NSArray *imageNameArray;
@property (nonatomic,strong) SwipeView *swipeView;
@property (assign, nonatomic) NSInteger count;

@end

@implementation LHNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Notice";
    self.count = self.imageNameArray.count;
    [self.view addSubview:self.swipeView];
//    [self.view addSubview:self.longPressView];
    // Do any additional setup after loading the view.
}

- (NSUInteger)swipeViewNumberOfCards:(SwipeView *)swipeView{
    return self.imageNameArray.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView cardAtIndex:(NSUInteger)index{
    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.clipsToBounds = YES;
    UIImage *image = [UIImage imageNamed:self.imageNameArray[index]];
//    [image roundImageWithCornerRadius:kWidthIphone7(8)];
    
    imageView.image = image;
    
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = kWidthIphone7(8);
    
//    [LHUtils addShadowWithView:imageView];
    return imageView;
}


- (OverlayView *)swipeView:(SwipeView *)swipeView
        cardOverlayAtIndex:(NSUInteger)index
{
    return nil;
}

- (void)swipeView:(SwipeView *)swipeView didSwipeCardAtIndex:(NSUInteger)index inDirection:(SwipeDirection)direction{
    
//    if (index>=self.imageNameArray.count-3) {
//        self.count = self.imageNameArray.count;
//        [self.swipeView reloadData];
//    }
}

- (void)swipeViewDidRunOutOfCards:(SwipeView *)swipeView{
    [swipeView resetCurrentCardNumber];
}


- (void)swipeView:(SwipeView *)swipeView didSelectCardAtIndex:(NSUInteger)index
{
    NSLog(@"点击");
}

- (BOOL)swipeViewShouldApplyAppearAnimation:(SwipeView *)swipeView
{
    return YES;
}

- (BOOL)swipeViewShouldMoveBackgroundCard:(SwipeView *)swipeView
{
    return YES;
}

- (BOOL)swipeViewShouldTransparentizeNextCard:(SwipeView *)swipeView
{
    return YES;
}

- (POPPropertyAnimation *)swipeViewBackgroundCardAnimation:(SwipeView *)swipeView
{
    return nil;
}


- (SwipeView *)swipeView{
    if (!_swipeView) {
        _swipeView = [[SwipeView alloc] initWithFrame:CGRectMake(kBorderMargin, kHeightIphone7(24), kScreenSize.width-kBorderMargin*2, kHeightIphone7(220))];
        _swipeView.delegate = self;
        _swipeView.dataSource = self;
    }
    return _swipeView;
}

- (NSArray *)imageNameArray{
    if (!_imageNameArray) {
        _imageNameArray = @[@"1.jpg",@"2.jpg",];
    }
    return _imageNameArray;
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
