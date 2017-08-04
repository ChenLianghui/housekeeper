//
//  ZQHomeViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/21.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "ZQHomeViewController.h"
#import "LHLoginViewController.h"
#import "XLCardSwitch.h"
#import "LHHomeMenuView.h"
#import "WSLayout.h"
#import "LHHomeCollectionViewCell.h"
#import "LHHomeCollectionModel.h"
#import "LHNoticeViewController.h"

@interface ZQHomeViewController ()<XLCardSwitchDelegate,LHHomeMenuViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

//@property (nonatomic,strong)UIView *mainView;
@property (nonatomic,strong)XLCardSwitch *cardSwitch;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)LHHomeMenuView *menuView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong) WSLayout *wslayout;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ZQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isTwoTitle = YES;
    self.superTitle.text = @"LOGO";
    self.subTitle.text = @"Area Unit";
    self.whiteView.hidden = YES;
    __weak typeof(self)weakSelf = self;
    [self addImageWithName:@"" isLeft:YES WithBlock:nil];
    [self addItemWithName:@"login" isLeft:NO WithBlock:^{
        LHLoginViewController *loginVC = [[LHLoginViewController alloc] init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:(loginVC) animated:YES];
    }];
//    [self.view addSubview:self.mainView];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.collectionView];
//    [self addCardSwitch];
//    [self.view addSubview:self.menuView];
    // Do any additional setup after loading the view.
}

//添加广告图
- (void)addCardSwitch{
    
    [self.view addSubview:_cardSwitch];
}

#pragma mark - CardSwitchDelegate

- (void)XLCardSwitchDidSelectedAt:(NSInteger)index {
    NSLog(@"选中了：%zd",index);
    LHNoticeViewController *noticeVC = [[LHNoticeViewController alloc] init];
    [self.navigationController pushViewController:noticeVC animated:YES];
}

#pragma mark - LHMenuViewDelegate

- (void)ClickedMenuWithTheTag:(NSInteger)tag{
    NSLog(@"tag:%ld",tag);
}

#pragma mark - UICollectionViewDelegate && dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHHomeCollectionViewCell *cell = (LHHomeCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"LHHomeCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中了第%ld个item",indexPath.row);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor clearColor];
        [header addSubview:self.cardSwitch];
        [header addSubview:self.menuView];
        return header;
    }
    return nil;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(kScreenSize.width, 200);
//}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 0.5)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _lineView;
}

- (XLCardSwitch *)cardSwitch{
    if (!_cardSwitch) {
        _cardSwitch = [[XLCardSwitch alloc] initWithFrame:CGRectMake(0, 0.5, kScreenSize.width, kHeightIphone7(150))];
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
        _cardSwitch.selectedIndex = 1;
    }
    return _cardSwitch;
}

- (LHHomeMenuView *)menuView{
    if (!_menuView) {
        _menuView = [[LHHomeMenuView alloc] initWithFrame:CGRectMake(kWidthIphone7(23), CGRectGetMaxY(self.cardSwitch.frame), kScreenSize.width-kWidthIphone7(23)*2, kHeightIphone7(160))];
        _menuView.delegate = self;
        [LHUtils addShadowWithView:_menuView];
    }
    return _menuView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        self.wslayout = [[WSLayout alloc] init];
        self.wslayout.lineNumber = 2;//列数
        self.wslayout.rowSpacing = kWidthIphone7(10);
        self.wslayout.lineSpacing = kWidthIphone7(5);
        self.wslayout.sectionInset = UIEdgeInsetsMake(CGRectGetMaxY(self.menuView.frame)+kHeightIphone7(10), kWidthIphone7(23), kHeightIphone7(10), kWidthIphone7(23));

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-64-49) collectionViewLayout:self.wslayout];
        _collectionView.backgroundColor = [UIColor backgroundColor];
        [_collectionView registerClass:[LHHomeCollectionViewCell class] forCellWithReuseIdentifier:@"LHHomeCollectionViewCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [self.wslayout computeIndexCellHeightWithWidthBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
            LHHomeCollectionModel *model = self.dataArray[indexPath.row];
            UIImage *image = [UIImage imageNamed:model.imageName];
            CGFloat oldWidth = image.size.width;
            CGFloat oldHeight = image.size.height;
            CGFloat newWidth = width;
            CGFloat newheight = oldHeight*newWidth/oldWidth;
            return newheight+kHeightIphone7(80);
        }];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            LHHomeCollectionModel *model = [[LHHomeCollectionModel alloc] init];
            model.imageName = [NSString stringWithFormat:@"%d.jpg",arc4random()%4];
            model.titleStr = @"iPhone6sPlus red";
            model.numberStr = @"75 ordered";
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
