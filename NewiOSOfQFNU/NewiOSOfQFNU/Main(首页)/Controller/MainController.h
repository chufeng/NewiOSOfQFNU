//
//  MainController.h
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/10.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LGSideMenuController.h"
#import "TQMultistageTableView.h"
@interface MainController :UIViewController <TQTableViewDataSource,TQTableViewDelegate>

@property (nonatomic, strong) TQMultistageTableView *mTableView;


@end
