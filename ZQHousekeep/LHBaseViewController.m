//
//  LHBaseViewController.m
//  APPBaseDemo
//
//  Created by 陈良辉 on 2017/5/23.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHBaseViewController.h"
#import "LHButton.h"

@interface LHBaseViewController ()

@end

@implementation LHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor backgroundColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    __weak typeof(self)weakSelf = self;
    if (self.navigationController.topViewController == self) {
        [self addImageWithName:@"back" isLeft:YES WithBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    [self.view addSubview:self.whiteView];
    // Do any additional setup after loading the view.
}

//添加文字按钮
- (void)addItemWithName:(NSString *)name isLeft:(BOOL)isleft WithBlock:(myBlock)block{
    //    self.tempBlock = block;
    CGRect frame;
    if (isleft) {
        frame = CGRectMake(0, 0, 80, 40);
    }else{
        frame = CGRectMake(0, 0, 60, 40);
    }
    LHButton *button = [LHButton buttonWithFrame:frame title:name andBlock:^{
        if (block) {
            block();
        }
    }];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
//    button.tintColor = [UIColor blackColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (isleft) {
        
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -32, 0, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -20;
        self.navigationItem.leftBarButtonItems = @[space,item];
    }else{
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -10;
        self.navigationItem.rightBarButtonItems = @[space,item];
    }
}


//添加图片按钮
- (void)addImageWithName:(NSString *)name isLeft:(BOOL)isleft WithBlock:(myBlock)block{
    if (name) {
        CGRect frame;
        if (isleft) {
            frame = CGRectMake(0, 0, 80, 40);
        }else{
            frame = CGRectMake(0, 0, 50, 40);
        }
        LHButton *button = [LHButton buttonWithFrame:frame imageName:name andBlock:^{
            if (block) {
                block();
            }
        }];
        UIView *buttonView = [[UIView alloc] initWithFrame:button.bounds];
        [buttonView addSubview:button];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
        [button setTitle:@"" forState:UIControlStateNormal];
        if (isleft) {
            
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -32, 0, 0);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
            UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            space.width = -20;
            self.navigationItem.leftBarButtonItems = @[space,item];
        }else{
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
            UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            space.width = -10;
            self.navigationItem.rightBarButtonItems = @[space,item];
        }
    }
}

- (UIView *)whiteView{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kHeightIphone7(76))];
        _whiteView.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightIphone7(76)-1, kScreenSize.width, kHeightIphone7(1))];
        lineView.backgroundColor = [UIColor grayLineColor];
        [_whiteView addSubview:lineView];
    }
    return _whiteView;
}

- (void)setIsTwoTitle:(BOOL)isTwoTitle{
    _isTwoTitle = isTwoTitle;
    if (isTwoTitle) {
        UIView *titleView = [UIView new];
        titleView.bounds = CGRectMake(0, 0, kWidthIphone7(150), 44);
        _superTitle = [UILabel new];
        _superTitle.textColor = [UIColor appThemeColor];
        _superTitle.textAlignment = NSTextAlignmentCenter;
        _superTitle.font = [UIFont appFontOne];
        [titleView addSubview:_superTitle];
        
        _subTitle = [UILabel new];
        _subTitle.textColor = [UIColor blackColor];
        _subTitle.textAlignment = NSTextAlignmentCenter;
        _subTitle.font = [UIFont appFontThree];
        [titleView addSubview:_subTitle];
        
        [_superTitle makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleView.top);
            make.centerX.equalTo(titleView.centerX);
            make.height.equalTo(24);
            make.width.equalTo(100);
        }];
        [_subTitle makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_superTitle.bottom);
            make.centerX.equalTo(titleView.centerX);
            make.height.equalTo(20);
            make.width.equalTo(_superTitle.width);
        }];
        self.navigationItem.titleView = titleView;
    }
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
