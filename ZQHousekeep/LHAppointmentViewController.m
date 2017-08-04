//
//  LHAppointmentViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/3.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHAppointmentViewController.h"
#import "LHAppointmentCollectionViewCell.h"
#import "LHAppointmentModel.h"
#import "LHAreaHeaderView.h"
#import "LHAppointmentInfoView.h"

#define kSiteWidth kWidthIphone7(80)

@interface LHAppointmentViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LHSelectNumberViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

{
    NSInteger _startTimeIndex;
}

@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)UIView *blurView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UIView *mainSecondView;
@property (nonatomic,strong)LHAreaHeaderView *siteView;
@property (nonatomic,strong)LHAreaHeaderView *infomationView;
@property (nonatomic,strong)LHAppointmentInfoView *infoView;
@property (nonatomic,strong)UIButton *currentButton;
@property (nonatomic,strong)UIButton *doneButton;
@property (nonatomic,strong)UIPickerView *roomPickerView;
@property (nonatomic,strong)UIDatePicker *datePickerView;
@property (nonatomic,strong)UIPickerView *timePickerView;
@property (nonatomic,strong)NSMutableArray *roomArray;
@property (nonatomic,strong)NSMutableArray *dateArray;
@property (nonatomic,strong)NSMutableArray *startTimeArray;
@property (nonatomic,strong)NSMutableArray *endTimeArray;

@end

@implementation LHAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Appointment";
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView insertSubview:self.collectionView atIndex:0];
    __weak typeof(self)weakSelf = self;
    [self addPlusItemIsLeft:NO withBlock:^{
        if (weakSelf.isClose) {
            //新建预约
            if (_mainSecondView == nil) {
                [weakSelf.mainScrollView addSubview:weakSelf.mainSecondView];
                [weakSelf addSiteView];
                [weakSelf addOtherInfoView];
                [weakSelf.mainSecondView setNeedsLayout];
                [weakSelf.mainSecondView layoutIfNeeded];
                [weakSelf.mainSecondView addSubview:weakSelf.doneButton];
            }
            [weakSelf.mainScrollView setContentOffset:CGPointMake(kScreenSize.width, 0) animated:YES];
        }else{
            [weakSelf.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }];
    [self getTimeDate];

    // Do any additional setup after loading the view.
}
//创建场地view
- (void)addSiteView{
    _siteView = [[LHAreaHeaderView alloc] init];
    _siteView.titleLabel.text = @"Site reservation";
    [self.mainSecondView addSubview:_siteView];
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.showsHorizontalScrollIndicator = YES;
    NSArray *imageTitleArray = @[@"Gym",@"meeting room",@"baby carriage",@"Gym"];
    scrollView.contentSize = CGSizeMake(kSiteWidth*4+kBorderMargin*5, 0);
    [_siteView addSubview:scrollView];
    
    [_siteView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kBorderMargin);
        make.top.equalTo(kHeightIphone7(24));
        make.centerX.equalTo(self.mainSecondView.centerX);
        make.height.equalTo(kHeightIphone7(40)+kSiteWidth+kHeightIphone7(20));
    }];
    
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_siteView.left);
        make.top.equalTo(_siteView.top).offset(kHeightIphone7(40));
        make.width.equalTo(_siteView.width);
        make.bottom.equalTo(_siteView.bottom);
    }];
    
    for (int i = 0; i < imageTitleArray.count; i++) {

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [button setImage:[UIImage imageNamed:imageTitleArray[i]] forState:UIControlStateNormal];
        [button setTitle:imageTitleArray[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor grayColor];
        button.tag = 20+i;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo((kBorderMargin+kSiteWidth)*i+kBorderMargin);
            make.top.equalTo(_siteView.top).offset(kHeightIphone7(40));
            make.width.equalTo(kSiteWidth);
            make.height.equalTo(kSiteWidth);
        }];
        
        [button layoutIfNeeded];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = kWidthIphone7(8);
    }
    
}

- (void)addOtherInfoView{
    _infomationView = [[LHAreaHeaderView alloc] init];
    _infomationView.titleLabel.text = @"Other information";
    [self.mainSecondView addSubview:_infomationView];
    
    _infoView = [[LHAppointmentInfoView alloc] init];
    _infoView.roomTF.text = @"Select room";
    _infoView.roomTF.inputView = self.roomPickerView;
    _infoView.numberView.minNumber = 1;
    _infoView.numberView.maxNumber = 10;
    _infoView.numberView.delegate = self;
    _infoView.dateTF.text = @"Select date";
    _infoView.dateTF.inputView = self.datePickerView;
    _infoView.timeTF.text = @"Select startTime and endTime";
    _infoView.timeTF.inputView = self.timePickerView;
    _infoView.useTF.text = @"Yin Yoga Course";
    [_infomationView addSubview:_infoView];
    
    [_infomationView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_siteView.left);
        make.top.equalTo(_siteView.bottom).offset(kHeightIphone7(20));
        make.width.equalTo(_siteView.width);
        make.height.equalTo(kHeightIphone7(300));
    }];
    
    [_infoView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(_infomationView);
        make.top.equalTo(kHeightIphone7(40));
    }];
}

#pragma mark - 点击场地
- (void)buttonClicked:(UIButton *)button{
    if (_currentButton) {
        _currentButton.backgroundColor = [UIColor grayColor];
    }
    button.backgroundColor = [UIColor redColor];
    _currentButton = button;
}

#pragma mark - 点击确定按钮
- (void)doneButtonClick{
    [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    self.isClose = YES;
    [self rotatePlus];
    [UIView animateWithDuration:0.3 animations:^{
        [_mainSecondView removeFromSuperview];
        _mainSecondView = nil;
    }];
}

#pragma mark - 获取时间数据
- (void)getTimeDate{
    NSDictionary *dict1 = @{@"start":@"6",@"end":@"9"};
    NSDictionary *dict2 = @{@"start":@"11",@"end":@"14"};
    NSDictionary *dict3 = @{@"start":@"16",@"end":@"18"};
    NSArray *array = @[dict1,dict2,dict3];
    _startTimeArray = [NSMutableArray array];

    _endTimeArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *dict = array[i];
        int start = [dict[@"start"] intValue];
        int end = [dict[@"end"] intValue];
        
        for (int j = 0; j < end - start; j ++) {
            NSMutableArray *rightOneArray = [NSMutableArray array];
            [_startTimeArray addObject:[NSString stringWithFormat:@"%d:00",start+j]];
            for (int m = 0; m < end - start -j ; m ++) {
                [rightOneArray addObject:[NSString stringWithFormat:@"%d:00",start+m+j+1]];
            }
            
            [_endTimeArray addObject:rightOneArray];
            
        }
        
    }
    NSLog(@"left:%@",_startTimeArray);
    NSLog(@"righttwo%@",_endTimeArray);
}

#pragma mark - 选择日期
- (void)ClickDatePicker:(UIDatePicker *)picker{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    _infoView.dateTF.text = [formatter stringFromDate:picker.date];
}

#pragma mark - CollectionViewDelegate && dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHAppointmentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHAppointmentCollectionViewCell" forIndexPath:indexPath];
    cell.appointModel = self.dataArray[indexPath.item];
    return cell;
}

#pragma mark - LHSelectNumberViewDelegate
- (void)hadReachedTheLowestNumber{
    [self showFailed:[NSString stringWithFormat:@"The input values cannot be less than %d",_infoView.numberView.minNumber]];
}

- (void)hadReachedTheHighestNumber{
    [self showFailed:[NSString stringWithFormat:@"The input value cannot greater than %d",_infoView.numberView.maxNumber]];
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (pickerView == _roomPickerView) {
        return 1;
    }else{
        return 2;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == _roomPickerView) {
        return self.roomArray.count;
    }else{
        if (component == 0) {
            return _startTimeArray.count;
        }else{
            return [_endTimeArray[_startTimeIndex] count];
        }
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == _roomPickerView) {
        return self.roomArray[row];
    }else{
        if (component == 0) {
            return _startTimeArray[row];
        }else{
            return _endTimeArray[_startTimeIndex][row];
        }
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == _roomPickerView) {
        self.infoView.roomTF.text = self.roomArray[row];
    }else{
        if (component == 0) {
            _startTimeIndex = [pickerView selectedRowInComponent:0];
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
        }
        NSInteger endTimeIndex = [pickerView selectedRowInComponent:1];
        _infoView.timeTF.text = [NSString stringWithFormat:@"%@ - %@",_startTimeArray[_startTimeIndex],_endTimeArray[_startTimeIndex][endTimeIndex]];
    }
}

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-64)];
        _mainScrollView.backgroundColor = [UIColor clearColor];
        _mainScrollView.scrollEnabled = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        
        _blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 40)];
        _blurView.backgroundColor = [UIColor whiteColor];
        [_mainScrollView insertSubview:_blurView atIndex:1];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = _blurView.bounds;
        gradientLayer.colors = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor clearColor].CGColor];
        gradientLayer.locations = @[[NSNumber numberWithFloat:0.1f],[NSNumber numberWithFloat:1.0f]];
        _blurView.layer.mask = gradientLayer;
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

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            LHAppointmentModel *model = [[LHAppointmentModel alloc] init];
            model.imageName = @"headIcon";
            model.roomName = @"Gym Room 3";
            model.useStr = @"Yin Yoga Course";
            model.timeStr = @"2016-06-28 16:00 - 18:00";
            model.numberStr = @"10 person";
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

- (UIView *)mainSecondView{
    if (!_mainSecondView) {
        _mainSecondView = [[UIView alloc] initWithFrame:CGRectMake(kScreenSize.width, 0, kScreenSize.width, kScreenSize.height-64)];
        _mainSecondView.backgroundColor = [UIColor clearColor];
    }
    return _mainSecondView;
}

- (UIButton *)doneButton{
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneButton.frame = CGRectMake(kBorderMargin, CGRectGetMaxY(_infomationView.frame)+kHeightIphone7(20), kScreenSize.width-kBorderMargin*2, kHeightIphone7(40));
        _doneButton.backgroundColor = [UIColor appThemeColor];
        [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [LHUtils addShadowWithView:_doneButton];
    }
    return _doneButton;
}

- (UIPickerView *)roomPickerView{
    if (!_roomPickerView) {
        _roomPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 214)];
        _roomPickerView.delegate = self;
        _roomPickerView.dataSource = self;
    }
    return _roomPickerView;
}

- (NSMutableArray *)roomArray{
    if (!_roomArray) {
        _roomArray = [NSMutableArray arrayWithObjects:@"Gym Room1",@"Gym Room2",@"Gym Room3", nil];
        
    }
    return _roomArray;
}

- (UIDatePicker *)datePickerView{
    if (!_datePickerView) {
        _datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 200)];
        _datePickerView.datePickerMode = UIDatePickerModeDate;
        _datePickerView.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
        _datePickerView.backgroundColor = [UIColor whiteColor];
        [_datePickerView addTarget:self action:@selector(ClickDatePicker:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePickerView;
}

- (UIPickerView *)timePickerView{
    if (!_timePickerView) {
        _timePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 180)];
        _timePickerView.backgroundColor = [UIColor whiteColor];
        _timePickerView.delegate = self;
        _timePickerView.dataSource = self;
    }
    return _timePickerView;
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
