//
//  LHVisitorsViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/29.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHVisitorsViewController.h"
#import "JCFlipPageView.h"
#import "JCFlipPage.h"
#import "LHInviterView.h"
#import "LHVisitorsView.h"

@interface LHVisitorsViewController ()<JCFlipPageViewDataSource>

@property (nonatomic, strong) JCFlipPageView *flipPage;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) LHInviterView *inviterView;
@property (nonatomic, strong) LHVisitorsView *visitorsView;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIScrollView *rightScrollView;

@end

@implementation LHVisitorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Visitors";
    __weak typeof(self)weakSelf = self;
    [self addPlusItemIsLeft:NO withBlock:^{
        if (weakSelf.isClose) {
            NSLog(@"YES");
            [weakSelf.mainScrollView setContentOffset:CGPointMake(kScreenSize.width, 0) animated:YES];
        }else{
            NSLog(@"NO");
            [weakSelf.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }];
    
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.flipPage];
    [self.mainScrollView addSubview:self.rightScrollView];
    [_rightScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kScreenSize.width);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake(kScreenSize.width, kScreenSize.height-64));
    }];
//    [_rightScrollView setNeedsLayout];
//    [_rightScrollView layoutIfNeeded];
    [self.rightScrollView addSubview:self.inviterView];
    [self.rightScrollView addSubview:self.visitorsView];
    [_visitorsView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(_inviterView.bottom).offset(kHeightIphone7(10));
        make.height.equalTo(_visitorsView.viewHeight).priority(1);
        make.width.equalTo(kScreenSize.width-kCellContentMargin*2);
    }];
    [self.mainScrollView addSubview:self.doneButton];
    [_doneButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_visitorsView.left);
        make.centerX.equalTo(_visitorsView.centerX);
        make.height.equalTo(kHeightIphone7(40));
        make.top.equalTo(_visitorsView.bottom).offset(kHeightIphone7(10));
    }];
    [self.flipPage reloadData];
    // Do any additional setup after loading the view.
}

- (void)doneButtonClicked:(UIButton *)button{
    
}

#pragma mar - JCFlipPageViewDataSource
- (NSUInteger)numberOfPagesInFlipPageView:(JCFlipPageView *)flipPageView
{
    return 20;
}
- (JCFlipPage *)flipPageView:(JCFlipPageView *)flipPageView pageAtIndex:(NSUInteger)index
{
    static NSString *kPageID = @"numberPageID";
    JCFlipPage *page = [flipPageView dequeueReusablePageWithReuseIdentifier:kPageID];
    if (!page)
    {
        page = [[JCFlipPage alloc] initWithFrame:flipPageView.bounds reuseIdentifier:kPageID];
        page.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"visitor"]];
        imageView.frame = flipPageView.bounds;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 500, kScreenSize.width-200, 50)];
        textLabel.text = @"239kdsf93";
        textLabel.font = [UIFont systemFontOfSize:30];
        [imageView addSubview:textLabel];
        [page addSubview:imageView];
    }else{}

    
    return page;
}


- (JCFlipPageView *)flipPage{
    if (!_flipPage) {
        _flipPage = [[JCFlipPageView alloc] initWithFrame:CGRectMake(kBorderMargin, kHeightIphone7(24), kScreenSize.width-kBorderMargin*2, kScreenSize.height-64-kHeightIphone7(24)-kHeightIphone7(50))];
        
        _flipPage.dataSource = self;
    }
    return _flipPage;
}

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-64)];
        _mainScrollView.backgroundColor = [UIColor clearColor];
        _mainScrollView.contentSize = CGSizeMake(kScreenSize.width*2, 0);
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.scrollEnabled = NO;
    }
    return _mainScrollView;
}

- (UIScrollView *)rightScrollView{
    if (!_rightScrollView) {
        _rightScrollView = [[UIScrollView alloc] init];
        _rightScrollView.backgroundColor = [UIColor clearColor];
        _rightScrollView.showsVerticalScrollIndicator = NO;
    }
    return _rightScrollView;
}

- (LHInviterView *)inviterView{
    if (!_inviterView) {
        _inviterView = [[LHInviterView alloc] init];
        _inviterView.frame = CGRectMake(kBorderMargin, kHeightIphone7(24), kScreenSize.width-kBorderMargin*2, kHeightIphone7(110));
        _inviterView.titleLabel.text = @"Inviter";
        UIImage *image = [UIImage imageNamed:@"headIcon"];
        _inviterView.iconImageView.image = [image roundImageWithCornerRadius:image.size.width/2];
        _inviterView.nameLabel.text = @"LeeSin  17606547695";
        _inviterView.addressLabel.text = @"LOL";
    }
    return _inviterView;
}

- (LHVisitorsView *)visitorsView{
    if (!_visitorsView) {
        _visitorsView = [[LHVisitorsView alloc] init];
        _visitorsView.titleLabel.text = @"Visitors";
//        _visitorsView.frame = CGRectMake(kBorderMargin + kScreenSize.width, CGRectGetMaxY(self.inviterView.frame)+kHeightIphone7(10), kScreenSize.width-kBorderMargin*2, kHeightIphone7(1000));
    }
    return _visitorsView;
}

- (UIButton *)doneButton{
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
        _doneButton.backgroundColor = [UIColor appThemeColor];
        [_doneButton addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [LHUtils addShadowWithView:_doneButton];
    }
    return _doneButton;
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
