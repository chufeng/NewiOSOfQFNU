//
//  AppDelegate.m
//  NewiOSOfQFNU
//
//  Created by lyngame on 2018/1/18.
//  Copyright © 2018年 yida. All rights reserved.
//

#import "AppDelegate.h"
#import "QFNUMainViewController.h"
#import "ZMUserInfo.h"
@interface AppDelegate ()
@property (nonatomic, strong) QFNUMainViewController *mainViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    QFNUMainViewController *vc = [[QFNUMainViewController alloc] init];
    self.mainViewController = vc;
    self.mainViewController.selectedIndex = 1;
    self.window.rootViewController = vc;
    //启用数据存储模块
    [AVOSCloud setApplicationId:@"omd1ftqwhek2RvKXA0cSuzOL-gzGzoHsz" clientKey:@"4dGjoA81tGcs4J9s96efgW8d"];
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [AVOSCloud setAllLogsEnabled:YES];
    [AVAnalytics updateOnlineConfigWithBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            // 从 dict 中读取参数，dict["k1"] 值应该为 v1
            NSLog(@"dict:%@",dict);
        }
    }];
    //此处加载用户sessionToken
    [[ZMUserInfo shareUserInfo] loadUserInfoFromSandbox];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
