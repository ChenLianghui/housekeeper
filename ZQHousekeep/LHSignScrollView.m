//
//  LHSignScrollView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/22.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHSignScrollView.h"
#import "LHAreaHeaderView.h"


@interface LHSignScrollView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *AreaTableView;
@property (nonatomic,strong)UITableView *UnitTableView;
@property (nonatomic,strong)UITableView *flourTableView;
//@property (nonatomic,strong)UIButton *nextButton;
@property (nonatomic,strong)NSMutableArray *dataArray1;
@property (nonatomic,strong)NSMutableArray *dataArray2;
@property (nonatomic,strong)NSMutableArray *dataArray3;
@property (nonatomic,assign)NSInteger currentIndex;

@end

@implementation LHSignScrollView

- (instancetype)init{
    if (self = [super init]) {
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.scrollEnabled = NO;
        _currentIndexPath1 = [[NSIndexPath alloc] init];
        _currentIndexPath2 = [[NSIndexPath alloc] init];
        _currentIndexPath3 = [[NSIndexPath alloc] init];
        _currentIndex = 0;
        [self createSubViews];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        self.pagingEnabled = YES;
//        self.showsHorizontalScrollIndicator = NO;
//        _currentIndexPath1 = [[NSIndexPath alloc] init];
//        _currentIndexPath2 = [[NSIndexPath alloc] init];
//        _currentIndexPath3 = [[NSIndexPath alloc] init];
//        _currentIndex = 0;
//        [self createSubViews];
//    }
//    return self;
//}

- (void)createSubViews{
    [self addSubview:self.AreaTableView];
    [self addSubview:self.UnitTableView];
    [self addSubview:self.flourTableView];
    
    [self.AreaTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left);
        make.top.equalTo(self.top);
        make.width.equalTo(self.width);
        make.height.equalTo(self.height);
    }];
    
    [self.UnitTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.AreaTableView.right);
        make.top.equalTo(self.AreaTableView.top);
        make.width.equalTo(self.AreaTableView.width);
        make.height.equalTo(self.AreaTableView.height);
    }];
    
    [self.flourTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.UnitTableView.right);
        make.top.equalTo(self.AreaTableView.top);
        make.width.equalTo(self.AreaTableView.width);
        make.height.equalTo(self.AreaTableView.height);
        
    }];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
//    [self addSubview:self.nextButton];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 40) {
        return self.dataArray1.count;
    }else if(tableView.tag == 41){
        return self.dataArray2.count;
    }else{
        return self.dataArray3.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 40) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell1) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        if (indexPath == _currentIndexPath1) {
            cell1.textLabel.textColor = [UIColor appThemeColor];
        }else{
            cell1.textLabel.textColor = [UIColor blackColor];
        }
        cell1.textLabel.text = self.dataArray1[indexPath.row];
        return cell1;
    }else if(tableView.tag == 41){
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell2) {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
        if (indexPath == _currentIndexPath2) {
            cell2.textLabel.textColor = [UIColor appThemeColor];
        }else{
            cell2.textLabel.textColor = [UIColor blackColor];
        }
        cell2.textLabel.text = self.dataArray2[indexPath.row];
        return cell2;
    }else{
        UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (!cell3) {
            cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
        }
        if (indexPath == _currentIndexPath3) {
            cell3.textLabel.textColor = [UIColor appThemeColor];
        }else{
            cell3.textLabel.textColor = [UIColor blackColor];
        }
        cell3.textLabel.text = self.dataArray3[indexPath.row];
        return cell3;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 40) {
        _currentIndexPath1 = indexPath;
        [self setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:YES];
    }else if(tableView.tag == 41){
        _currentIndexPath2 = indexPath;
        if (self.block) {
            self.block();
        }
        [self setContentOffset:CGPointMake(self.bounds.size.width*2, 0) animated:YES];
    }else{
        _currentIndexPath3 = indexPath;
        
    }
    [tableView reloadData];
}


//#pragma mark - 点击Next
//- (void)nextButtonClick{
//
//}

- (UITableView *)AreaTableView{
    if (!_AreaTableView) {
        _AreaTableView = [[UITableView alloc] init];
        _AreaTableView.delegate = self;
        _AreaTableView.dataSource = self;
        _AreaTableView.tag = 40;
        _AreaTableView.rowHeight = kHeightIphone7(40);
    }
    return _AreaTableView;
}

- (UITableView *)UnitTableView{
    if (!_UnitTableView) {
        _UnitTableView = [[UITableView alloc] init];
        _UnitTableView.delegate = self;
        _UnitTableView.dataSource = self;
        _UnitTableView.tag = 41;
        _UnitTableView.rowHeight = kHeightIphone7(40);
    }
    return _UnitTableView;
}

- (UITableView *)flourTableView{
    if (!_flourTableView) {
        _flourTableView = [[UITableView alloc] init];
        _flourTableView.delegate = self;
        _flourTableView.dataSource = self;
        _flourTableView.tag = 42;
        _flourTableView.rowHeight = kHeightIphone7(40);
    }
    return _flourTableView;
}

//- (UIButton *)nextButton{
//    if (!_nextButton) {
//        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _nextButton.frame = CGRectMake(CGRectGetMinX(self.flourTableView.frame), CGRectGetMaxY(self.flourTableView.frame)+kHeightIphone7(15), CGRectGetWidth(self.flourTableView.frame), kHeightIphone7(40));
//        [_nextButton setTitle:@"Next" forState:UIControlStateNormal];
//        _nextButton.backgroundColor = [UIColor appThemeColor];
//        [_nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _nextButton;
//}


- (NSMutableArray *)dataArray1{
    if (!_dataArray1) {
        _dataArray1 = [NSMutableArray array];
        for (int i = 0; i < 30; i++) {
            [_dataArray1 addObject:[NSString stringWithFormat:@"Area %d",i+1]];
        }
    }
    return _dataArray1;
}

- (NSMutableArray *)dataArray2{
    if (!_dataArray2) {
        _dataArray2 = [NSMutableArray array];
        for (int i = 0; i < 30; i++) {
            [_dataArray2 addObject:[NSString stringWithFormat:@"Unit %d",i+1]];
        }
    }
    return _dataArray2;
}

- (NSMutableArray *)dataArray3{
    if (!_dataArray3) {
        _dataArray3 = [NSMutableArray array];
        for (int i = 0; i < 30; i++) {
            [_dataArray3 addObject:[NSString stringWithFormat:@"Flour %d",i+1]];
        }
    }
    return _dataArray3;
}

@end
