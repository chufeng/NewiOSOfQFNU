//
//  ViewController.m
//  NewiOSOfQFNU
//
//  Created by lyngame on 2018/1/18.
//  Copyright © 2018年 yida. All rights reserved.
//

#import "ViewController.h"
#import "ZMLoginViewController.h"
#import "BaseNavigationController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 跳转登录
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ZMLoginViewController *vc = [[ZMLoginViewController alloc] init];
    //如果登录视图需要push的话就需要包装导航控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{
//        btn.enabled = YES;
    }];
}
- (void)clickLoginButton:(UIButton *)btn{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
