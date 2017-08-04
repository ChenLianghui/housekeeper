//
//  ZQActivityViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/21.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "ZQActivityViewController.h"
#import "LHActivityModel.h"
#import "LHActivityCollectionViewCell.h"

@interface ZQActivityViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UIButton *selectedButton;
@property (nonatomic,strong)UIView *greenView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ZQActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageWithName:@"" isLeft:YES WithBlock:nil];
    [self WhiteViewInit];
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
}

- (void)WhiteViewInit{
    CGRect frame = self.whiteView.frame;
    frame.size.height -= kHeightIphone7(40);
    self.whiteView.frame = frame;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.whiteView.frame), kScreenSize.width, kHeightIphone7(1))];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.whiteView addSubview:lineView];
    NSArray *array = @[@"popular",@"history"];
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 30+i;
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont appFontThree];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:button];
        if (i == 0) {
            _selectedButton = button;
            [button setTitleColor:[UIColor appThemeColor] forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
        }
        
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(kHeightIphone7(5));
            make.width.equalTo(kWidthIphone7(100));
            make.height.equalTo(kHeightIphone7(20));
            if (i == 0) {
                make.centerX.equalTo(self.whiteView.centerX).dividedBy(2);
            }else{
                make.centerX.equalTo(self.whiteView.centerX).multipliedBy(3/2.0);
            }
        }];
    }
    _greenView = [UIView new];
    _greenView.backgroundColor = [UIColor appThemeColor];
    [self.whiteView addSubview:_greenView];
    
    [_greenView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView.bottom).offset(-kHeightIphone7(2));
        make.height.equalTo(kHeightIphone7(2));
        make.width.equalTo(kWidthIphone7(20));
        make.centerX.equalTo(self.whiteView.centerX).dividedBy(2);
    }];
}

- (void)buttonClicked:(UIButton *)button{
    [self.collectionView reloadData];
    if (button == _selectedButton) {
        return;
    }else{
        if (button.tag == 30) {
            NSLog(@"popular");
        }else{
            NSLog(@"history");
        }
        [button setTitleColor:[UIColor appThemeColor] forState:UIControlStateNormal];
        [_selectedButton setTitleColor:[UIColor grayFontColor] forState:UIControlStateNormal];
        _selectedButton = button;
        [self showGreenLineAnimation];
    }
}

- (void)showGreenLineAnimation{
    CGPoint center = _greenView.center;
    if (_selectedButton.tag == 30) {
        [UIView animateWithDuration:0.2 animations:^{
            _greenView.center = CGPointMake(center.x-kScreenSize.width/2, center.y);
        }];
        
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            _greenView.center = CGPointMake(center.x+kScreenSize.width/2, center.y);
        }];

    }
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHActivityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHActivityCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kWidthIphone7(166), kHeightIphone7(190));
        layout.minimumLineSpacing = kHeightIphone7(10);
        layout.minimumInteritemSpacing = kWidthIphone7(10);
        layout.sectionInset = UIEdgeInsetsMake(kHeightIphone7(10), kWidthIphone7(16), kHeightIphone7(10), kWidthIphone7(16));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.whiteView.frame), kScreenSize.width, kScreenSize.height-CGRectGetMaxY(self.whiteView.frame)-64-49) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor backgroundColor];
        [_collectionView registerClass:[LHActivityCollectionViewCell class] forCellWithReuseIdentifier:@"LHActivityCollectionViewCell"];
        
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            LHActivityModel *model = [[LHActivityModel alloc] init];
            model.titleStr = @"Yoga and Meditation";
            model.hotStr = @"1296";
            model.desStr = @"You will learn how to really use this in your practice and work around it. ";
            model.imageName = @"0.png";
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
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
