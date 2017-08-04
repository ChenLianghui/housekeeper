//
//  ZQFamilyViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/21.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "ZQFamilyViewController.h"
#import "LHProfileHeaderView.h"
#import "LHActivityCollectionViewCell.h"
#import "LHActivityModel.h"
#import "LHActivityDetailViewController.h"
#import "LHProfileCollectionViewCell.h"
#import "LHMemberModel.h"
#import "LHVisitorModel.h"
#import "LHUserInfoViewController.h"

@interface ZQFamilyViewController ()<LHProfileHeaderViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) LHProfileHeaderView *headerView;
@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UICollectionView *activityView;
@property (nonatomic,strong) UICollectionView *memberView;
@property (nonatomic,strong) UICollectionView *visitorView;
@property (nonatomic,strong) NSMutableArray *activityArray;
@property (nonatomic,strong) NSMutableArray *memberArray;
@property (nonatomic,strong) NSMutableArray *visitorArray;
@property (nonatomic,strong) UIView *blurView;

@end

@implementation ZQFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageWithName:@"" isLeft:YES WithBlock:nil];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView insertSubview:self.activityView atIndex:0];
    [self.mainScrollView insertSubview:self.memberView atIndex:0];
    [self.mainScrollView insertSubview:self.visitorView atIndex:0];
    // Do any additional setup after loading the view.
}

#pragma mark - LHProfileHeaderViewDelegate

- (void)didClickHeaderView{
    LHUserInfoViewController *userInfoVC = [[LHUserInfoViewController alloc] init];
    userInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoVC animated:YES];
}

- (void)didClickItemWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            NSLog(@"activity");
            [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
            break;
        case 1:
        {
            NSLog(@"member");
            [self.mainScrollView setContentOffset:CGPointMake(kScreenSize.width, 0) animated:YES];
        }
            break;
        case 2:
        {
            NSLog(@"visitor");
            [self.mainScrollView setContentOffset:CGPointMake(kScreenSize.width*2, 0) animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _activityView) {
        return self.activityArray.count;
    }else if (collectionView == _memberView){
        return self.memberArray.count;
    }else{
        return self.visitorArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _activityView) {
        LHActivityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHActivityCollectionViewCell" forIndexPath:indexPath];
        cell.model = self.activityArray[indexPath.item];
        return cell;

    }else if (collectionView == _memberView){
        LHProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHProfileCollectionViewCell" forIndexPath:indexPath];
        cell.memeberModel = self.memberArray[indexPath.item];
        cell.isMembers = YES;
        return cell;
    }else{
        LHProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHProfileCollectionViewCell" forIndexPath:indexPath];
        cell.visitorModel = self.visitorArray[indexPath.item];
        cell.isMembers = NO;
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _activityView) {
        LHActivityDetailViewController *detailVC = [[LHActivityDetailViewController alloc] init];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if (collectionView == _memberView){
        
    }else{
        
    }
}


- (LHProfileHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[LHProfileHeaderView alloc] initWithFrame:CGRectMake(kBorderMargin, kHeightIphone7(6), kScreenSize.width-kBorderMargin*2, kHeightIphone7(144))];
        _headerView.delegate = self;
        _headerView.usernameLabel.text = @"Lee sin";
        _headerView.activityLabel.text = [NSString stringWithFormat:@"%ld",self.activityArray.count];
        _headerView.menberLabel.text = [NSString stringWithFormat:@"%ld",self.memberArray.count];
        _headerView.visitorLabel.text = [NSString stringWithFormat:@"%ld",self.visitorArray.count];
    }
    return _headerView;
}

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0 , CGRectGetMaxY(self.headerView.frame)+kHeightIphone7(8), kScreenSize.width, kScreenSize.height-CGRectGetMaxY(self.headerView.frame)-64-49)];
        _mainScrollView.scrollEnabled = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.contentSize = CGSizeMake(kScreenSize.width*3, 0);
        _mainScrollView.backgroundColor = [UIColor backgroundColor];
        
        _blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width*3, 40)];
        _blurView.backgroundColor = [UIColor backgroundColor];
        [_mainScrollView insertSubview:_blurView atIndex:1];
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = _blurView.bounds;
        gradientLayer.colors = @[(id)[UIColor backgroundColor].CGColor,(id)[UIColor clearColor].CGColor];
        gradientLayer.locations = @[[NSNumber numberWithFloat:0.1f],[NSNumber numberWithFloat:1.0f]];
        _blurView.layer.mask = gradientLayer;
    }
    return _mainScrollView;
}

- (UICollectionView *)activityView{
    if (!_activityView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((kScreenSize.width-kBorderMargin*2-kWidthIphone7(8))/2, kHeightIphone7(190));
        layout.minimumLineSpacing = kHeightIphone7(8);
        layout.minimumInteritemSpacing = kWidthIphone7(8);
        layout.sectionInset = UIEdgeInsetsMake(kHeightIphone7(10),kBorderMargin, kHeightIphone7(10), kBorderMargin);
        _activityView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0., kScreenSize.width, self.mainScrollView.bounds.size.height) collectionViewLayout:layout];
        _activityView.delegate = self;
        _activityView.dataSource = self;
        _activityView.backgroundColor = [UIColor backgroundColor];
        [_activityView registerClass:[LHActivityCollectionViewCell class] forCellWithReuseIdentifier:@"LHActivityCollectionViewCell"];
        
    }
    return _activityView;
}

- (UICollectionView *)memberView{
    if (!_memberView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenSize.width-kBorderMargin*2, kHeightIphone7(60));
        layout.minimumLineSpacing = kHeightIphone7(10);
        layout.minimumInteritemSpacing = kWidthIphone7(10);
        layout.sectionInset = UIEdgeInsetsMake(kHeightIphone7(10),kBorderMargin, kHeightIphone7(10), kBorderMargin);
        _memberView = [[UICollectionView alloc] initWithFrame:CGRectMake(kScreenSize.width, 0, kScreenSize.width, self.mainScrollView.bounds.size.height) collectionViewLayout:layout];
        _memberView.delegate = self;
        _memberView.dataSource = self;
        _memberView.backgroundColor = [UIColor backgroundColor];
        [_memberView registerClass:[LHProfileCollectionViewCell class] forCellWithReuseIdentifier:@"LHProfileCollectionViewCell"];

    }
    return _memberView;
}

- (UICollectionView *)visitorView{
    if (!_visitorView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenSize.width-kBorderMargin*2, kHeightIphone7(60));
        layout.minimumLineSpacing = kHeightIphone7(10);
        layout.minimumInteritemSpacing = kWidthIphone7(10);
        layout.sectionInset = UIEdgeInsetsMake(kHeightIphone7(10),kBorderMargin, kHeightIphone7(10), kBorderMargin);
        _visitorView = [[UICollectionView alloc] initWithFrame:CGRectMake(kScreenSize.width*2, 0., kScreenSize.width, self.mainScrollView.bounds.size.height) collectionViewLayout:layout];
        _visitorView.delegate = self;
        _visitorView.dataSource = self;
        _visitorView.backgroundColor = [UIColor backgroundColor];
        [_visitorView registerClass:[LHProfileCollectionViewCell class] forCellWithReuseIdentifier:@"LHProfileCollectionViewCell"];
    }
    return _visitorView;
}

- (NSArray *)activityArray{
    if (!_activityArray) {
        _activityArray = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            LHActivityModel *model = [[LHActivityModel alloc] init];
            model.titleStr = @"Yoga and Meditation";
            model.likeStr = @"1296";
            model.joinStr = @"2342";
            model.imageName = [NSString stringWithFormat:@"%d.jpg",arc4random()%4];
            [_activityArray addObject:model];
        }
    }
    return _activityArray;
}

- (NSMutableArray *)memberArray{
    if (!_memberArray) {
        _memberArray = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            LHMemberModel *model = [LHMemberModel new];
            model.iconStr = @"headIcon";
            model.nameStr = @"Lee sin";
            model.relationStr = @"Friend";
            [_memberArray addObject:model];
        }
    }
    return _memberArray;
}

- (NSMutableArray *)visitorArray{
    if (!_visitorArray) {
        _visitorArray = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            LHVisitorModel * model = [LHVisitorModel new];
            model.iconStr = @"headIcon";
            model.nameStr = @"Lee sin";
            model.operatorName = @"Tim";
            model.timeStr = @"13:50";
            [_visitorArray addObject:model];
        }
    }
    return _visitorArray;
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
