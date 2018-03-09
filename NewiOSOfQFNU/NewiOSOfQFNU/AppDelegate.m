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
#define appleid @"1277107501"
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
            NSString *notstr=[[NSString alloc]init];
            NSDictionary *parameters=dict[@"parameters"];
            [[QFInfo sharedInstance]setHoliday:[parameters objectForKey:@"holiday"]];
            notstr=[parameters objectForKey:@"not"];
            if ([parameters[@"notswitch"] isEqualToString:@"1"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self ShowNotice:notstr];
                });
            }
                }
    }];
    //此处加载用户sessionToken
    [[ZMUserInfo shareUserInfo] loadUserInfoFromSandbox];
    [self shareAppVersionAlert];
    //取出cookie，没有就不取。
    [[QFInfo sharedInstance]setCoookie];
    return YES;
}
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    if (_allowRotation == YES) {   // 如果属性值为YES,仅允许屏幕向左旋转,否则仅允许竖屏
        return  (1 << UIInterfaceOrientationPortrait) | (1 << UIInterfaceOrientationPortraitUpsideDown)
        | (1 << UIInterfaceOrientationLandscapeRight) | (1 << UIInterfaceOrientationLandscapeLeft);  // 这里是屏幕要旋转的方向
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}

-(void)ShowNotice:(NSString *)content{
    //初始化提示框；
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"公告" message:content preferredStyle:  UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];

    [kWindow.rootViewController presentViewController:alert animated:true completion:nil];
}
     //判断是否需要提示更新App
     - (void)shareAppVersionAlert {
         if(![self judgeNeedVersionUpdate])  return ;
         //App内info.plist文件里面版本号
         NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
         NSString *appVersion = infoDict[@"CFBundleShortVersionString"];
         //    NSString *bundleId   = infoDict[@"CFBundleIdentifier"];
         NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@", appleid];
         //两种请求appStore最新版本app信息 通过bundleId与appleId判断
         //[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?bundleid=%@", bundleId]
         //[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@", appleid]
         NSURL *urlStr = [NSURL URLWithString:urlString];
         //创建请求体
         NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlStr];
         [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
             if (connectionError) {
                 //            NSLog(@"connectionError->%@", connectionError.localizedDescription);
                 return ;
             }
             NSError *error;
             NSDictionary *resultsDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
             if (error) {
                 //            NSLog(@"error->%@", error.localizedDescription);
                 return;
             }
             NSArray *sourceArray = resultsDict[@"results"];
             if (sourceArray.count >= 1) {
                 //AppStore内最新App的版本号
                 NSDictionary *sourceDict = sourceArray[0];
                 NSString *newVersion = sourceDict[@"version"];
                 if ([self judgeNewVersion:newVersion withOldVersion:appVersion])
                 {
                     UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示:\n您的App不是最新版本，更新版本会提高App的稳定性哟" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                         //                    [alertVc dismissViewControllerAnimated:YES completion:nil];
                     }];
                     [alertVc addAction:action1];
                     UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                         //跳转到AppStore，该App下载界面
                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sourceDict[@"trackViewUrl"]]];
                     }];
                     [alertVc addAction:action2];
                     [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertVc animated:YES completion:nil];
                 }
             }
         }];
     }
     //每天进行一次版本判断
     - (BOOL)judgeNeedVersionUpdate {
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         [formatter setDateFormat:@"yyyy-MM-dd"];
         //获取年-月-日
         NSString *dateString = [formatter stringFromDate:[NSDate date]];
         NSString *currentDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentDate"];
         if ([currentDate isEqualToString:dateString]) {
             return NO;
         }
         [[NSUserDefaults standardUserDefaults] setObject:dateString forKey:@"currentDate"];
         return YES;
     }
     //判断当前app版本和AppStore最新app版本大小
     - (BOOL)judgeNewVersion:(NSString *)newVersion withOldVersion:(NSString *)oldVersion {
         NSArray *newArray = [newVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
         NSArray *oldArray = [oldVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
         for (NSInteger i = 0; i < newArray.count; i ++) {
             if ([newArray[i] integerValue] > [oldArray[i] integerValue]) {
                 return YES;
             } else if ([newArray[i] integerValue] < [oldArray[i] integerValue]) {
                 return NO;
             } else { }
         }
         return NO;
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
