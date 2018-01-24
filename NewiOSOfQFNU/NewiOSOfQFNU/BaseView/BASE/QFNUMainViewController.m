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
#import "BaseNavigationController.h"
@interface QFNUMainViewController ()

@end

@implementation QFNUMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVc:[ViewController new] title:@"首页" image:@"tabbar_icon0" selectedImage:@"tabbar_icon0_s"];
        [self addChildVc:[ViewController new] title:@"2" image:@"tabbar_icon0" selectedImage:@"tabbar_icon0_s"];
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
