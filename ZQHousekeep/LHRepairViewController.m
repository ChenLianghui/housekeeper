//
//  LHRepairViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/14.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHRepairViewController.h"
#import "LHRepairCollectionViewCell.h"
#import "LHRepairModel.h"
#import "LHSelectHeaderView.h"
#import "LHAddRepairView.h"

@interface LHRepairViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)UIScrollView *leftScrollView;
@property (nonatomic,strong)UICollectionView *auditingView;
@property (nonatomic,strong)UICollectionView *historyView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)LHSelectHeaderView *selectView;
@property (nonatomic,strong)LHAddRepairView *repairView;

@end

@implementation LHRepairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Repair";
    [self.view addSubview:self.mainScrollView];
    [self WhiteViewInit];
    
    [self.mainScrollView addSubview:self.leftScrollView];
    [self.mainScrollView addSubview:self.selectView];
    [self.mainScrollView addSubview:self.repairView];
    [self.leftScrollView addSubview:self.auditingView];
    [self.leftScrollView addSubview:self.historyView];
    
    __weak typeof(self)weakSelf = self;
    [self addPlusItemIsLeft:NO withBlock:^{
        if (weakSelf.isClose) {
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = weakSelf.whiteView.frame;
                frame.size.height += kHeightIphone7(40);
                weakSelf.whiteView.frame = frame;
                
                weakSelf.mainScrollView.contentOffset = CGPointMake(kScreenSize.width, 0);
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = weakSelf.whiteView.frame;
                frame.size.height -= kHeightIphone7(40);
                weakSelf.whiteView.frame = frame;
//                weakSelf.greenView.alpha = 1;
                weakSelf.mainScrollView.contentOffset = CGPointMake(0, 0);
            }];
        }
    }];
    // Do any additional setup after loading the view.
}

- (void)WhiteViewInit{
    CGRect frame = self.whiteView.frame;
    frame.size.height -= kHeightIphone7(40);
    self.whiteView.frame = frame;
    self.WhitelineView.hidden = YES;
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHRepairCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHRepairCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)changeRepairViewHeight:(CGFloat)height{
    CGRect frame = self.repairView.frame;
    frame.size.height = height;
    self.repairView.frame = frame;
}

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-64)];
        _mainScrollView.pagingEnabled = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.backgroundColor = [UIColor clearColor];
        _mainScrollView.contentSize = CGSizeMake(kScreenSize.width*2, 0);
        _mainScrollView.scrollEnabled = NO;
    }
    return _mainScrollView;
}

- (LHSelectHeaderView *)selectView{
    if (!_selectView) {
        _selectView = [[LHSelectHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kHeightIphone7(35)) andTitleArray:@[@"auditing",@"history"]];
        __weak typeof(self)weakSelf = self;
        _selectView.selectBlock = ^(NSInteger tag){
            if (tag == 0) {
                NSLog(@"audit");
                [weakSelf.auditingView reloadData];
                [weakSelf.leftScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }else{
                NSLog(@"history");
                [weakSelf.historyView reloadData];
                [weakSelf.leftScrollView setContentOffset:CGPointMake(kScreenSize.width, 0) animated:YES];
            }
        };
        _selectView.backgroundColor = [UIColor whiteColor];
    }
    return _selectView;
}

- (UIScrollView *)leftScrollView{
    if (!_leftScrollView) {
        _leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.whiteView.frame), kScreenSize.width, kScreenSize.height-CGRectGetMaxY(self.whiteView.frame)-64)];
        _leftScrollView.pagingEnabled = NO;
        _leftScrollView.showsHorizontalScrollIndicator = NO;
        _leftScrollView.backgroundColor = [UIColor backgroundColor];
        _leftScrollView.contentSize = CGSizeMake(kScreenSize.width*2, 0);
        _leftScrollView.scrollEnabled = NO;
    }
    return _leftScrollView;
}

- (UICollectionView *)auditingView{
    if (!_auditingView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenSize.width-kCellContentMargin*2, kHeightIphone7(190));
        layout.minimumLineSpacing = kHeightIphone7(10);
        layout.sectionInset = UIEdgeInsetsMake(kHeightIphone7(10), 0, kHeightIphone7(10), 0);
        _auditingView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-CGRectGetMaxY(self.whiteView.frame)-64) collectionViewLayout:layout];
        _auditingView.backgroundColor = [UIColor clearColor];
        _auditingView.delegate = self;
        _auditingView.dataSource = self;
        [_auditingView registerClass:[LHRepairCollectionViewCell class] forCellWithReuseIdentifier:@"LHRepairCollectionViewCell"];
    }
    return _auditingView;
}

- (UICollectionView *)historyView{
    if (!_historyView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenSize.width-kCellContentMargin*2, kHeightIphone7(190));
        layout.minimumLineSpacing = kHeightIphone7(10);
        layout.sectionInset = UIEdgeInsetsMake(kHeightIphone7(10), 0, kHeightIphone7(10), 0);
        _historyView = [[UICollectionView alloc] initWithFrame:CGRectMake(kScreenSize.width, 0, kScreenSize.width, kScreenSize.height-CGRectGetMaxY(self.whiteView.frame)-64) collectionViewLayout:layout];
        _historyView.backgroundColor = [UIColor clearColor];
        _historyView.delegate = self;
        _historyView.dataSource = self;
        [_historyView registerClass:[LHRepairCollectionViewCell class] forCellWithReuseIdentifier:@"LHRepairCollectionViewCell"];
    }
    return _historyView;
}

- (LHAddRepairView *)repairView{
    if (!_repairView) {
        _repairView = [[LHAddRepairView alloc] init];
        _repairView.frame = CGRectMake(kScreenSize.width+kBorderMargin, kHeightIphone7(24), kScreenSize.width-kBorderMargin*2, kHeightIphone7(290));
        __weak typeof(self)weakSelf = self;
        _repairView.heightBlock = ^(CGFloat height){
            [weakSelf changeRepairViewHeight:height];
        };
        _repairView.imagesBlock = ^(NSArray *array){
            NSLog(@"imageArray:%@",array);
        };
    }
    return _repairView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            LHRepairModel *model = [[LHRepairModel alloc] init];
            model.numberStr = @"No.123456";
            model.stateStr = @"Auditing";
            model.titleStr = @"Title：Elevator maintenance(2017-06-26)";
            NSMutableArray *array =[NSMutableArray array];
            for (int j = 0; j < 4; j ++) {
                UIImage *image = [UIImage imageNamed:@"headIcon"];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[image roundImageWithCornerRadius:kWidthIphone7(10)]];
                [array addObject:imageView];
            }
            model.imageViewArray = array;
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
