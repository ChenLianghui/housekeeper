//
//  LHUserInfoViewController.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/6/30.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHUserInfoViewController.h"
#import "LHUserInfoMainView.h"
#import "LHUserModel.h"

@interface LHUserInfoViewController ()

@property (nonatomic,strong)LHUserInfoMainView *mainView;//白色view
@property (nonatomic,strong)UIButton *saveButton;
@property (nonatomic,strong)LHUserModel *userModel;
@property (nonatomic,strong)UIDatePicker *dateView;

@end

@implementation LHUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"User Info";
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.saveButton];
//    [self.view addSubview:self.dateView];
    // Do any additional setup after loading the view.
}

- (void)saveButtonClick:(UIButton *)button{
    
}

- (void)dateViewHadChanged:(UIDatePicker *)datePicker{
    NSDate *date = datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    _mainView.BirthdayTF.text =[formatter stringFromDate:date];
}

- (LHUserInfoMainView *)mainView{
    if (!_mainView) {
        _mainView = [[LHUserInfoMainView alloc] initWithFrame:CGRectMake(kBorderMargin, kHeightIphone7(6),kScreenSize.width-kBorderMargin*2 , kHeightIphone7(400))];
        UIImage *image = [UIImage imageNamed:@"headIcon"];
        _mainView.imageView.image = [image roundImageWithCornerRadius:image.size.width/2.];
        [_mainView.imageView setNeedsLayout];
        [_mainView.imageView layoutIfNeeded];
        [LHUtils createSmallIconHeaderImageWithImageView:_mainView.imageView andImageName:@"headCamera"];
        _mainView.userModel = self.userModel;
        _mainView.block = ^(){
            NSLog(@"Click head");
        };
        _mainView.BirthdayTF.inputView = self.dateView;
    }
    return _mainView;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton.frame = CGRectMake(kBorderMargin, CGRectGetMaxY(self.mainView.frame)+kHeightIphone7(20), kScreenSize.width-kBorderMargin*2, kHeightIphone7(40));
        [_saveButton setTitle:@"Save" forState:UIControlStateNormal];
        _saveButton.backgroundColor = [UIColor appThemeColor];
        [_saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [LHUtils addShadowWithView:_saveButton];
        
    }
    return _saveButton;
}

- (LHUserModel *)userModel{
    if (!_userModel) {
        _userModel = [LHUserModel new];
        _userModel.name = @"Lee Sin";
        _userModel.nickName = @"Xia zi";
        _userModel.address = @"LOL";
        _userModel.email = @"LeeSin@LOL.com";
        _userModel.phoneNumber = @"8888888";
        _userModel.birthday = @"1970-07-10";
    }
    return _userModel;
}

- (UIDatePicker *)dateView{
    if (!_dateView) {
        _dateView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 216)];
        _dateView.datePickerMode = UIDatePickerModeDate;
        _dateView.maximumDate = [NSDate date];
        [_dateView setLocale:[NSLocale localeWithLocaleIdentifier:@"en"]];
        [_dateView addTarget:self action:@selector(dateViewHadChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _dateView;
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
