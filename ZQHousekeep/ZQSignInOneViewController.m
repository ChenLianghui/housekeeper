//
//  ZQSignInOneViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/21.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "ZQSignInOneViewController.h"
#import "LHStepProgressView.h"
#import "LHSignScrollView.h"
#import "LHButtonsHeaderView.h"
#import "LHSignInTwoViewController.h"

#define kScrollViewWidth (kScreenSize.width-kBorderMargin*2-kWidthIphone7(8))
#define kAreaWidth (kScreenSize.width-kBorderMargin*2)
@interface ZQSignInOneViewController ()<LHButtonsHeaderViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) LHStepProgressView *progressView;
@property (nonatomic,strong) LHSignScrollView *signScrollView;
@property (nonatomic,strong) UIView *scrollBGView;
@property (nonatomic,strong) LHButtonsHeaderView *headerView;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) BOOL isClickButton;
@property (nonatomic,strong) UIButton *NextButton;

@end

@implementation ZQSignInOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"sign in";
    _currentIndex = 0;
    [self.view addSubview:self.NextButton];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.scrollBGView];
    [self.scrollBGView addSubview:self.headerView];
    [self.scrollBGView addSubview:self.signScrollView];
    [self addConstraint];
    // Do any additional setup after loading the view.
}

- (void)addConstraint{
    [self.progressView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(kHeightIphone7(20));
        make.centerX.equalTo(self.view.centerX);
        make.height.equalTo(kHeightIphone7(120));
    }];
    
    [self.scrollBGView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(self.progressView.bottom).offset(kHeightIphone7(20));
        make.centerX.equalTo(self.view.centerX);
        make.bottom.equalTo(-kHeightIphone7(20));
    }];
    
    [self.headerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthIphone7(4));
        make.right.equalTo(-kWidthIphone7(4));
        make.top.equalTo(kHeightIphone7(4));
        make.height.equalTo(kHeightIphone7(40));
    }];
    
    [self.signScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerView.left);
        make.right.equalTo(self.headerView.right);
        make.top.equalTo(self.headerView.bottom);
        make.bottom.equalTo(self.scrollBGView.bottom).offset(-kHeightIphone7(4));
    }];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    _headerView.titleArray = @[@"Area",@"Unit",@"Flour"];
}

- (void)buttonClickedWithIndex:(NSInteger)index{
    if (index != _currentIndex) {
        if (index == 2 ) {
            [UIView animateWithDuration:0.2 animations:^{
                [_scrollBGView updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(-kHeightIphone7(90));
                }];
                CGRect frame = self.NextButton.frame;
                frame.origin.y -= kHeightIphone7(70);
                self.NextButton.frame = frame;
            }];
            
            
        }else if(_currentIndex == 2){
            [UIView animateWithDuration:0.2 animations:^{
                [_scrollBGView updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(-kHeightIphone7(20));
                }];
                CGRect frame = self.NextButton.frame;
                frame.origin.y += kHeightIphone7(70);
                self.NextButton.frame = frame;
            }];
            
        }
        _currentIndex = index;
        _isClickButton = YES;
        [self.signScrollView setContentOffset:CGPointMake(index*kScrollViewWidth, 0) animated:YES];
        
    }
}

- (void)NextButtonClicked{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0 ];
    if (_signScrollView.currentIndexPath1.length == 0) {
        [self showFailed:@"Please chose the Area!"];
        [self.signScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        //此处虽然不是点击button，但为了防止button向前跳一位
        _isClickButton = YES;
        _currentIndex = 0;
        self.headerView.currentIndex = _currentIndex;
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollBGView updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(-kHeightIphone7(20));
            }];
            CGRect frame = self.NextButton.frame;
            frame.origin.y += kHeightIphone7(70);
            self.NextButton.frame = frame;
        }];
    }else if (_signScrollView.currentIndexPath2.length == 0){
        [self showFailed:@"Please chose the Unit!"];
        [self.signScrollView setContentOffset:CGPointMake(kAreaWidth, 0) animated:YES];
        _isClickButton = YES;
        _currentIndex = 1;
        self.headerView.currentIndex = _currentIndex;
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollBGView updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(-kHeightIphone7(20));
            }];
            CGRect frame = self.NextButton.frame;
            frame.origin.y += kHeightIphone7(70);
            self.NextButton.frame = frame;
        }];
    }else if (_signScrollView.currentIndexPath3.length == 0){
        [self showFailed:@"Please chose the Flour!"];
    }else{
        LHSignInTwoViewController *signTwo = [[LHSignInTwoViewController alloc] init];
        [self.navigationController pushViewController:signTwo animated:YES];
    }
}

- (LHStepProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[LHStepProgressView alloc] init];
        
    }
    return _progressView;
}

- (LHSignScrollView *)signScrollView{
    if (!_signScrollView) {
        _signScrollView = [[LHSignScrollView alloc] init];
        _signScrollView.contentSize = CGSizeMake(kScrollViewWidth*3, 0);
        _signScrollView.delegate = self;
        __weak typeof(self)weakSelf = self;
        _signScrollView.block = ^(){
            [UIView animateWithDuration:0.2 animations:^{
                [weakSelf.scrollBGView updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(-kHeightIphone7(90));
                }];
                CGRect frame = weakSelf.NextButton.frame;
                frame.origin.y -= kHeightIphone7(70);
                weakSelf.NextButton.frame = frame;
            }];
        };
    }
    return _signScrollView;
}

- (UIView *)scrollBGView{
    if (!_scrollBGView) {
        _scrollBGView = [[UIView alloc] init];
        _scrollBGView.backgroundColor = [UIColor whiteColor];
        [LHUtils addShadowWithView:_scrollBGView];
        
    }
    return _scrollBGView;
}

- (LHButtonsHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[LHButtonsHeaderView alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        _headerView.delegate = self;
    }
    return _headerView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point =  scrollView.contentOffset;
    if (point.x == 0) {
        self.headerView.currentIndex = 0;
        _currentIndex = 0;
    }else if(point.x == kScrollViewWidth){
        self.headerView.currentIndex = 1;
        _currentIndex = 1;
    }else if(point.x == kScrollViewWidth*2){
        self.headerView.currentIndex = 2;
        _currentIndex = 2;
    }
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (_isClickButton) {
        _isClickButton = NO;
        return;
    }
    if (_currentIndex != 2) {
        _currentIndex++;
        self.headerView.currentIndex = _currentIndex;
    }
    
}

- (UIButton *)NextButton{
    if (!_NextButton) {
        _NextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _NextButton.frame = CGRectMake(kBorderMargin, kScreenSize.height-kHeightIphone7(64), kAreaWidth, kHeightIphone7(40));
        _NextButton.backgroundColor = [UIColor appThemeColor];
        [_NextButton setTitle:@"Next" forState:UIControlStateNormal];
        [LHUtils addShadowWithView:_NextButton];
        [_NextButton addTarget:self action:@selector(NextButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _NextButton;
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
