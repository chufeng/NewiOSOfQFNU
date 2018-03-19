//
//  QFLoginViewController.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/5.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "QFLoginViewController.h"
#import "QFLoginView.h"
#import <Masonry.h>
@interface QFLoginViewController ()

@property (nonatomic, strong) QFLoginView       *loginView;

@end

@implementation QFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMainView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)setupMainView{
    self.loginView = [[QFLoginView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0+KStatusBarHeight);
    }];
    [self.loginView.superview layoutIfNeeded];
    [self.loginView setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
