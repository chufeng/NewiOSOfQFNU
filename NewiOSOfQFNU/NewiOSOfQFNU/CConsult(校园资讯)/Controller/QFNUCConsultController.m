//
//  QFNUCConsultController.m
//  QFNU for opooc
//
//  Created by doushuyao on 17/6/5.
//  Copyright © 2017年 opooc. All rights reserved.
//

#import "CFWebViewController.h"
#import "QFNUCConsultController.h"
#import <SPPageMenu.h>
@interface QFNUCConsultController ()<SPPageMenuDelegate,UIScrollViewDelegate,UIWebViewDelegate>
@property (nonatomic, strong) NSArray          *dataArr;
@property (nonatomic, weak) SPPageMenu         *pageMenu;
@property (nonatomic, weak) UIScrollView       *scrollView;
@property (nonatomic, strong) NSMutableArray   *myChildViewControllers;
@end
#define pageMenuH 40
#define NaviH (kScreenHeight == 812 ? 88 : 64) // 812是iPhoneX的高度
@implementation QFNUCConsultController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMenu];
    [self setupNavView];
        [self.navView.centerButton setTitle:@"资讯" forState:UIControlStateNormal];
}
- (void)setupMenu{
    
    self.dataArr = @[@"校园资讯",@"图书馆",@"教务资讯"];
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64 + KStatusBarHeight, kScreenWidth, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    pageMenu.selectedItemTitleColor =   [QFColor blackColor];
    pageMenu.unSelectedItemTitleColor = [QFColor appSupportColor];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    [self.view bringSubviewToFront:pageMenu];
    _pageMenu = pageMenu;
    
    for (NSInteger index = 0; index < self.dataArr.count; index++) {
        [self.myChildViewControllers addObject:@1];
    }
    
    //滚动容器
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NaviH+pageMenuH, kScreenWidth, kScreenHeight - NaviH - pageMenuH - self.tabBarController.tabBar.height)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    //scrollView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(_pageMenu.frame), 0, 0, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    [self.view addSubview:scrollView];
    
    [self.view sendSubviewToBack:scrollView];
    _scrollView = scrollView;
    
    // 这一行赋值，可实现pageMenu的跟踪器时刻跟随scrollView滑动的效果
    self.pageMenu.bridgeScrollView = self.scrollView;
    
    scrollView.contentOffset = CGPointMake(kScreenWidth * self.pageMenu.selectedItemIndex, 0);
    scrollView.contentSize = CGSizeMake(self.dataArr.count * kScreenWidth, 0);
    // pageMenu.selectedItemIndex就是选中的item下标 选中下标
    [self setupView:self.pageMenu.selectedItemIndex];
}
#pragma mark - 初始化视图
- (void)setupView:(NSInteger)index{
    id table = [self.myChildViewControllers objectAtIndex:index];
    //避免重复创建视图
    if ([table isKindOfClass:[UIView class]]) {
        return;
    }
    
    switch (index) {
        case 0:
        {
            
            UIWebView *view = [[UIWebView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.qfnu.edu.cn"]]];
            [self.scrollView addSubview:view];
            //将当前视图存到数组中
            [self.myChildViewControllers replaceObjectAtIndex:index withObject:view];
        }
            break;
        case 1:
        {
            UIWebView *view = [[UIWebView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.5read.com/4581"]]];
            view.delegate=self;
            [self.scrollView addSubview:view];
            //将当前视图存到数组中
            [self.myChildViewControllers replaceObjectAtIndex:index withObject:view];
//            ZMDiscoverInsetView *view = [[ZMDiscoverInsetView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
//            [self.scrollView addSubview:view];
//            view.pageType = pageViewTypeInset;
//            //将当前视图存到数组中
//            [self.myChildViewControllers replaceObjectAtIndex:index withObject:view];
        }
            break;
        case 2:
        {
            UIWebView *view = [[UIWebView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://jwc.qfnu.edu.cn/xw.htm"]]];
            [self.scrollView addSubview:view];
            //将当前视图存到数组中
            [self.myChildViewControllers replaceObjectAtIndex:index withObject:view];
//            ZMDiscoverArticleView *view = [[ZMDiscoverArticleView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
//            [self.scrollView addSubview:view];
//            //将当前视图存到数组中
//            [self.myChildViewControllers replaceObjectAtIndex:index withObject:view];
        }
            break;

        default:
            break;
    }
}
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    NSLog(@"%zd",index);
    [self setupView:index];
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    NSLog(@"%zd------->%zd",fromIndex,toIndex);
    // 如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth * toIndex, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth * toIndex, 0) animated:YES];
    }
    if (self.myChildViewControllers.count <= toIndex) return;
    
    //获取索引对应的视图
    [self setupView:toIndex];
}
- (NSMutableArray *)myChildViewControllers {
    if (!_myChildViewControllers) {
        _myChildViewControllers = [NSMutableArray array];
    }
    return _myChildViewControllers;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// UIWebViewDelegate 方法回调
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if ([webView.request.URL.absoluteString isEqualToString:@"http://m.5read.com/4581"]||[webView.request.URL.absoluteString isEqualToString:@"http://m.5read.com/157"]) {
        [webView stringByEvaluatingJavaScriptFromString:@"close()"];
    }

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
