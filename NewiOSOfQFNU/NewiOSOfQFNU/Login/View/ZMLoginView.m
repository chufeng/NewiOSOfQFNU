//
//  ZMLoginView.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/5.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMLoginView.h"
#import "ZMRegisterViewController.h"
#import "BaseNavigationController.h"
#import <Masonry.h>
#import "UIView+extension.h"
#import <YYKit/YYLabel.h>
#import <TFHpple/TFHpple.h>
#import <MBProgressHUD+NHAdd.h>
@interface ZMLoginView()

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIImageView   *bgImageView;
@property (nonatomic, strong) UIButton      *closeButton;

@property (nonatomic, strong) UIImageView   *logoImageView;
@property (nonatomic, strong) UITextField   *userNameField;
@property (nonatomic, strong) UITextField   *passwordField;
@property (nonatomic, strong) YYLabel       *forgetPwdLabel;
@property (nonatomic, strong) YYLabel       *registerLabel;
@property (nonatomic, strong) UIButton      *loginButton;
@property (nonatomic, strong) YYLabel       *closeLabel;

@property (nonatomic, strong) UILabel       *bottomLine1;
@property (nonatomic, strong) UILabel       *bottomLine2;

@end

@implementation ZMLoginView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(self.frame.size.width);
            make.height.mas_equalTo(self.frame.size.height + 50);
        }];
    }
    return _mainView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self addSubview:_scrollView];
        [self insertSubview:_scrollView aboveSubview:self.bgImageView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(self.frame.size.width);
            make.height.mas_equalTo(self.frame.size.height);
        }];
        [_scrollView.superview layoutIfNeeded];
        _scrollView.contentSize = CGSizeMake(0, _scrollView.frame.size.height + 1);
    }
    return _scrollView;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"login_bg_640X1136"];
        [self addSubview:_bgImageView];
        [self sendSubviewToBack:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _bgImageView;
}

- (UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"login_alert_cancel"];
        _closeButton.layer.cornerRadius = 30 * 0.5;
        _closeButton.layer.masksToBounds = YES;
        _closeButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _closeButton.layer.borderWidth = 1;
        [_closeButton setImage:image forState:UIControlStateNormal];
        [self addSubview:_closeButton];
        [self bringSubviewToFront:_closeButton];
        [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20 + 5);
            make.left.mas_equalTo(5);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        [_closeButton.superview layoutIfNeeded];
        [_closeButton addTarget:self action:@selector(clickLoginOut:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)setupUI{
    [self closeButton];
    [self bgImageView];
    [self mainView];
    WEAKSELF;
    self.logoImageView = [UIImageView new];
    UIImage *logoImage = [UIImage imageNamed:@"qfnulogo"];
    self.logoImageView.image = logoImage;
    [self.mainView addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(logoImage.size);
        make.centerX.mas_equalTo(self.mainView);
        make.top.mas_equalTo(CGRectGetMaxY(self.closeButton.frame) + 40);
    }];
    
    self.userNameField = [[UITextField alloc] init];
    self.userNameField.font = [UIFont systemFontOfSize:15];
    NSAttributedString *userNameString = [[NSAttributedString alloc] initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName:[ZMColor appLightGrayColor],NSFontAttributeName:            self.userNameField.font}];
    self.userNameField.attributedPlaceholder = userNameString;
    self.userNameField.textColor = [UIColor whiteColor];
    self.userNameField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.mainView addSubview:self.userNameField];
    [self.userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.logoImageView.mas_bottom).with.offset(60);
    }];
    UIView *userNameMainView = [UIView new];
    
    UIImageView *userNameView = [UIImageView new];
    UIImage *userNameLeftImage = [UIImage imageNamed:@"icon_telephone"];
    userNameView.image = userNameLeftImage;
    userNameView.size = userNameLeftImage.size;
    userNameView.x = 0;
    userNameView.y = 0;
    userNameMainView.size = CGSizeMake(userNameLeftImage.size.width + 10, userNameLeftImage.size.height);
    [userNameMainView addSubview:userNameView];
    
    self.userNameField.leftView = userNameMainView;
    self.userNameField.leftViewMode = UITextFieldViewModeAlways;
    
    self.bottomLine1 = [UILabel new];
    self.bottomLine1.backgroundColor = [UIColor lightGrayColor];
    [self.mainView addSubview:self.bottomLine1];
    [self.bottomLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.userNameField.mas_bottom).with.offset(1);
    }];
    
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.font = [UIFont systemFontOfSize:15];
    self.passwordField.textColor = [UIColor whiteColor];
    NSAttributedString *passwordString = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:[ZMColor appLightGrayColor],
                    NSFontAttributeName:self.userNameField.font}];
    self.passwordField.attributedPlaceholder = passwordString;
    self.passwordField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.mainView addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.userNameField.mas_bottom).with.offset(1);
    }];
    UIView *passwordMainView = [UIView new];
    
    UIImageView *passwordView = [UIImageView new];
    UIImage *passwordLeftImage = [UIImage imageNamed:@"icon_lock"];
    passwordView.image = passwordLeftImage;
    passwordView.size = passwordLeftImage.size;
    passwordView.x = 0;
    passwordView.y = 0;
    passwordMainView.size = CGSizeMake(passwordLeftImage.size.width + 10, passwordLeftImage.size.height);
    [passwordMainView addSubview:passwordView];
    
    self.passwordField.leftView = passwordMainView;
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    self.bottomLine2 = [UILabel new];
    self.bottomLine2.backgroundColor = [UIColor lightGrayColor];
    [self.mainView addSubview:self.bottomLine2];
    [self.bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.passwordField.mas_bottom).with.offset(1);
    }];

    //忘记密码
    self.forgetPwdLabel = [YYLabel new];
    self.forgetPwdLabel.font = [UIFont systemFontOfSize:13];
    self.forgetPwdLabel.text = @"忘记密码？";
    self.forgetPwdLabel.textColor = [UIColor whiteColor];
    [self.mainView addSubview:self.forgetPwdLabel];
    [self.forgetPwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameField.mas_left);
        make.top.mas_equalTo(self.passwordField.mas_bottom).with.offset(20);
    }];
    self.forgetPwdLabel.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了忘记密码");
    };
    
    //注册
//    self.registerLabel = [YYLabel new];
//    self.registerLabel.font = [UIFont systemFontOfSize:13];
//    self.registerLabel.textColor = [UIColor whiteColor];
//    self.registerLabel.text = @"去注册";
//    [self.mainView addSubview:self.registerLabel];
//    [self.registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.userNameField.mas_right);
//        make.top.mas_equalTo(self.passwordField.mas_bottom).with.offset(20);
//    }];
//    self.registerLabel.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//        NSLog(@"点击了注册");
//        //如果在弹出模态框之前没有包装导航控制器，这里是不会push成功的
//        ZMRegisterViewController *vc = [[ZMRegisterViewController alloc] init];
//        [weakSelf.viewController.navigationController pushViewController:vc animated:YES];
//    };
    
    //登录
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 20;
    self.loginButton.backgroundColor = [UIColor grayColor];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.mainView addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.forgetPwdLabel.mas_bottom).with.offset(25);
        make.height.mas_equalTo(45);
    }];
    [self.loginButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //继续浏览
    self.closeLabel = [YYLabel new];
    self.closeLabel.font = [UIFont systemFontOfSize:13];
    self.closeLabel.textColor = [UIColor whiteColor];
    self.closeLabel.textAlignment = NSTextAlignmentCenter;
    self.closeLabel.text = @"继续浏览";
    [self.mainView addSubview:self.closeLabel];
    [self.closeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mainView);
        make.top.mas_equalTo(self.loginButton.mas_bottom).with.offset(25);
    }];
    self.closeLabel.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [weakSelf.viewController dismissViewControllerAnimated:YES completion:^{
        }];
    };
}

#pragma mark - 登录
- (void)clickLoginButton:(UIButton *)btn{
    
    if (![self.userNameField.text stringByTrim].length) {
        [MBProgressHUD showError:@"请输入用户名" toView:kWindow];
//                [MBProgressHUD showPromptMessage:@"请输入用户名"];
        return;
    }
    if (![self.passwordField.text stringByTrim].length) {
                [MBProgressHUD showError:@"请输入密码" toView:kWindow];
        return;
    }
    NSLog(@"去登录");
    NSString *username = self.userNameField.text;
    NSString *password = self.passwordField.text;
    WEAKSELF;
    [MBProgressHUD showMessage:@"正在登录..." toView:self];
    if (username.length && password.length) {
         NSDictionary* dic=[[NSDictionary alloc]init];
        NSString *Lt=[[NSString alloc]init];
        NSString *urlstring=@"http://ids.qfnu.edu.cn/authserver/login?service=http%3A%2F%2F202.194.188.19%2Fcaslogin.jsp";
        NSData *htmlData=[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:urlstring]];
        TFHpple *xpathParser=[[TFHpple alloc]initWithXMLData:htmlData];
        NSArray *dataArray=[xpathParser searchWithXPathQuery:@"//input"];
        for (TFHppleElement *hppleElement in dataArray){
            if ([[hppleElement objectForKey:@"name"] isEqualToString:@"lt"]) {
                NSLog(@"%@",[hppleElement objectForKey:@"value"]);
                Lt=[[NSString alloc]init];
                Lt=[hppleElement objectForKey:@"value"];
                NSLog(@"Lt:%@",Lt);
            }
        }
//        if (ischeck) {
            dic = @{@"username":_userNameField.textField.text,
                    @"password":_passwordField.textField.text,
                    @"lt":Lt,
//                    @"captchaResponse":_captchaField.textField.text,
                    @"execution":@"e1s1",
                    @"_eventId":@"submit",
                    @"submit":@"%%E7%%99%%BB%%E5%%BD%%95"
                    };
//        }else{
//            dic = @{@"username":_userNameField.textField.text,
//                    @"password":_passwordField.textField.text,
//                    @"lt":Lt,
//                    @"execution":@"e1s1",
//                    @"_eventId":@"submit",
//                    @"submit":@"%%E7%%99%%BB%%E5%%BD%%95"
//                    };
        }
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];//请求
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 7.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [manager POST:urlstring parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
            NSLog(@"str:%@",responses.URL);
            TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSString *isLogin=[NSString stringWithFormat:@"%@",responses.URL];
            if ([isLogin isEqualToString:@"http://ids.qfnu.edu.cn/authserver/login?service=http%3A%2F%2F202.194.188.19%2Fcaslogin.jsp"]) {
                NSLog(@"登陆失败");
                //一开始让我清cookie我是拒绝的，但是学校登陆系统里面的Lt，在登陆失败的时候，网页里获取的Lt会更新，但是我查了下，会更新的居然只有我这边！学校那边没更新！只能清cookie让学校认为我是新人了。
                NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
                for (id obj in _tmpArray) {
                    [cookieJar deleteCookie:obj];
                }
                
                //刷新验证码
                
                NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ids.qfnu.edu.cn/authserver/captcha.html"]];
                UIImage* resultImage = [UIImage imageWithData: imageData];
                _imageview.image=resultImage;
                
                
                [button failedAnimationWithCompletion:^{
                    
                    [self didPresentControllerButtonTouch];
                }];
                [MBProgressHUD showError:@"1.用户名或密码错误,2.服务器连接失败" toView:self.view];
                //            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"1.用户名或密码错误,2.服务器连接失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                //            [alert show];
                
            }
            if([isLogin isEqualToString:@"http://202.194.188.19/caslogin.jsp"]){
                NSLog(@"登陆成功");
                [[QFInfo sharedInstance] SaveCookie];
                [button succeedAnimationWithCompletion:^{
                    [self didPresentControllerButtonTouch];
                }];
                [self didPresentControllerButtonTouch];
                [[QFInfo sharedInstance]loginqfnu:_userNameField.textField.text password:_passwordField.textField.text];
                
                
                
                
            }
            
            
            NSArray *dataArray=[xpathParser searchWithXPathQuery:@"//title"];
            for (TFHppleElement *hppleElement in dataArray){
                
                NSLog(@"title:%@",hppleElement.text);
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //清cookie
            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
            for (id obj in _tmpArray) {
                [cookieJar deleteCookie:obj];
            }
            //刷新验证码
            
            NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ids.qfnu.edu.cn/authserver/captcha.html"]];
            UIImage* resultImage = [UIImage imageWithData: imageData];
            _imageview.image=resultImage;
            
            [button failedAnimationWithCompletion:^{
                
                [self didPresentControllerButtonTouch];
            }];
            if (error.code==-1001) {
                [MBProgressHUD showError:@"校园服务器连接超时，提示：在访问高峰期会导致此情况" toView:self.view];
                //            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"校园服务器连接超时，提示：在访问高峰期会导致此情况" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                //            [alert show];
                
            }else{
                [MBProgressHUD showError:@"服务器连接失败" toView:self.view];
                //            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"服务器连接失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                //            [alert show];
            }
        }];
//        [QFInfo sharedInstance]loginqfnu:<#(NSString *)#> password:<#(NSString *)#>
        
        
        
//        [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
//            [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
//            if (error) {
//                NSDictionary *dic = error.userInfo;
//                NSLog(@"登录失败 %@", dic[@"error"]);
//                [MBProgressHUD showPromptMessage:@"用户名和密码不匹配"];
//            } else {
//                [MBProgressHUD showPromptMessage:@"登录成功"];
//                //这里存储 sessionToken，下次直接用sessionToken 登录
//                [[ZMUserInfo shareUserInfo] loadUserInfo:user];
//                [[ZMUserInfo shareUserInfo] saveUserInfoToSandbox];
//
//                //发送登录成功通知
//                [[NSNotificationCenter defaultCenter] postNotificationName:KLoginStateChangeNotice object:nil];
//
//                [weakSelf.viewController dismissViewControllerAnimated:YES completion:^{
//                }];
//
////                //尝试解析图片,这是自定义属性
////                NSData *imageStr = [user objectForKey:@"thumb"];
////                // 将NSData转为UIImage
////                UIImage *decodedImage = [UIImage imageWithData: imageStr];
////                if (decodedImage) {
////                    [ZMUserInfo shareUserInfo].headImage = decodedImage;
////                }
////                NSLog(@"%@",decodedImage);
//            }
//        }];
    }
}

#pragma mark - 退出页面
- (void)clickLoginOut:(UIButton *)btn{
    btn.enabled = NO;
    [self.viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
