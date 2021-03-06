//
//  QFNUMainViewController.m
//  NewiOSOfQFNU
//
//  Created by lyngame on 2018/1/22.
//  Copyright © 2018年 yida. All rights reserved.
//
#import "ViewController.h"
#import "QFNUMainViewController.h"
#import <AudioToolbox/AudioToolbox.h>
//#import "ZMColor.h"
#import "ZMMineViewController.h"
#import "BaseNavigationController.h"
#import "MainController.h"
#import "AppDelegate.h"
#import "QFNUCConsultController.h"
#import "CFWebViewController.h"
@interface QFNUMainViewController ()

@end

@implementation QFNUMainViewController



- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[self presentingVC] isKindOfClass:[CFWebViewController class]]) {
        return (1 << UIInterfaceOrientationPortrait) | (1 << UIInterfaceOrientationPortraitUpsideDown)
        | (1 << UIInterfaceOrientationLandscapeRight) | (1 << UIInterfaceOrientationLandscapeLeft);
    }
    return UIInterfaceOrientationMaskPortrait;
}
- (void)setSelectedViewController:(UIViewController *)selectedViewController {
    [super setSelectedViewController:selectedViewController];
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (self.selectedIndex ==1 && UIDeviceOrientationIsLandscape(orientation)) {
        // 由于属性 orientation是只读的, 所以采用以下方法实现
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            SEL selector =NSSelectorFromString(@"setOrientation:");
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            int val =UIInterfaceOrientationPortrait;
            [invocation setArgument:&val atIndex:2];
            [invocation invoke];
        }
    }
}
- (UIViewController *)presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildVc:[MainController new] title:@"首页" image:@"tabbar_icon0" selectedImage:@"tabbar_icon0_s"];
     [self addChildVc:[QFNUCConsultController new] title:@"资讯" image:@"tabbar_icon1" selectedImage:@"tabbar_icon1_s"];
    [self addChildVc:[ZMMineViewController new] title:@"我的" image:@"tabbar_icon3" selectedImage:@"tabbar_icon3_s"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
#pragma mark - 添加子控制器
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:childVc];
    
    //设置item按钮
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:136/255.0 green:134/255.0 blue:135/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    
    //选中字体颜色
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[ZMColor appMainColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
    
    [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    // 添加子控制器
    [self addChildViewController:nav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self playSound];//点击时音效
    [self animationWithIndex:index];
}

-(void) playSound{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"like" ofType:@"caf"];
    SystemSoundID soundID;
    NSURL *soundURL = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&soundID);
    AudioServicesPlaySystemSound(soundID);
    
}
- (void)animationWithIndex:(NSInteger) index {
    if (self.selectedIndex == index) {
        return;
    }
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CATransition* animation = [CATransition animation];
    [animation setDuration:0.3f];
    //动画切换风格
    [animation setType:kCATransitionFade];
    //animation.type = @"cube";
    //动画切换方向
    [animation setSubtype:kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[tabbarbuttonArray[index] layer]addAnimation:animation forKey:@"UITabBarButton.transform.scale"];
    
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
