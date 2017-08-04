//
//  LHPetTrustViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/10.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHPetTrustViewController.h"
#import "LHAppointmentCollectionViewCell.h"
#import "LHPetTrustModel.h"
#import "LHSelectPhotoView.h"
#import "LHEditPetView.h"

@interface LHPetTrustViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LHSelectPhotoViewDelegate>

{
    CGPoint _currentOffset;
}

@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)LHSelectPhotoView *photoView;
@property (nonatomic,strong)LHEditPetView *petView;
@property (nonatomic,strong)UIPickerView *typeView;
@property (nonatomic,strong)UIPickerView *speciesView;
@property (nonatomic,strong)UIDatePicker *startDatePicker;
@property (nonatomic,strong)UIDatePicker *endDatePicker;
@property (nonatomic,strong)UIButton *doneButton;

@end

@implementation LHPetTrustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Pet Trust";
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.collectionView];
    [self addPetView];
    __weak typeof(self)weakSelf = self;
    [self addPlusItemIsLeft:NO withBlock:^{
        if (weakSelf.isClose) {
            [weakSelf.mainScrollView setContentOffset:CGPointMake(kScreenSize.width, 0) animated:YES];
            _currentOffset = CGPointMake(kScreenSize.width, 0);
        }else{
            [weakSelf.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            _currentOffset = CGPointMake(0, 0);
        }
    }];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    _mainScrollView.contentOffset = _currentOffset;
}

- (void)addPetView{
    _petView = [[LHEditPetView alloc] init];
    __weak typeof(self)weakSelf = self;
    _petView.heightBlock = ^(CGFloat height){
        [weakSelf updateHeigthWhit:height];
    };
    _petView.imagesBlock = ^(NSArray *array){
        NSLog(@"array:%@",array);
    };
    [self.mainScrollView addSubview:_petView];
    [_petView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin+kScreenSize.width);
        make.top.equalTo(kHeightIphone7(24));
        make.width.equalTo(kScreenSize.width-kBorderMargin*2);
        make.height.equalTo(kHeightIphone7(290));
    }];
    
    [self.mainScrollView addSubview:self.doneButton];
    [_doneButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_petView.left);
        make.top.equalTo(_petView.bottom).offset(kHeightIphone7(20));
        make.width.equalTo(_petView.width);
        make.height.equalTo(kHeightIphone7(40));
    }];
}

#pragma mark - 点击完成按钮
- (void)doneButtonClicked{
    
}

#pragma mark - CollectionViewDelegate && dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHAppointmentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHAppointmentCollectionViewCell" forIndexPath:indexPath];
    cell.petModel = self.dataArray[indexPath.item];
    return cell;
}

#pragma mark - LHEditPetViewDelegate

- (void)updateHeigthWhit:(CGFloat)height{

    [_petView updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(height);
    }];
    [_petView setNeedsLayout];
    [_petView layoutIfNeeded];
}

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView){
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-64)];
        _mainScrollView.scrollEnabled = NO;
        _mainScrollView.backgroundColor = [UIColor clearColor];
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 40)];
        blurView.backgroundColor = [UIColor whiteColor];
        [_mainScrollView insertSubview:blurView atIndex:1];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = blurView.bounds;
        gradientLayer.colors = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor clearColor].CGColor];
        gradientLayer.locations = @[[NSNumber numberWithFloat:0.1f],[NSNumber numberWithFloat:1.0f]];
        blurView.layer.mask = gradientLayer;
    }
    return _mainScrollView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenSize.width-kBorderMargin*2, kHeightIphone7(100));
        layout.minimumLineSpacing = kHeightIphone7(10);
        layout.sectionInset = UIEdgeInsetsMake(kHeightIphone7(20), kBorderMargin, kHeightIphone7(10), kBorderMargin);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-64) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[LHAppointmentCollectionViewCell class] forCellWithReuseIdentifier:@"LHAppointmentCollectionViewCell"];
    }
    return _collectionView;
}

- (UIButton *)doneButton{
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneButton.backgroundColor = [UIColor appThemeColor];
        [LHUtils addShadowWithView:_doneButton];
        [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(doneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            LHPetTrustModel *model = [[LHPetTrustModel alloc] init];
            model.imageNameStr = @"headIcon";
            model.type = @"Dog";
            model.species = @"Corgi";
            model.time = @"2017-06-28 2017-07-15";
            model.numberStr = @"1";
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

//- (UIPickerView *)typeView{
//    if (!_typeView) {
//        _typeView
//    }
//}

- (void)didReceiveMemoryWarning{
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
