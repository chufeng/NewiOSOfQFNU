//
//  ZMSetupViewCell.h
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/8.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMSetupViewCell : UITableViewCell

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UIImageView   *arrowImageView;
@property (nonatomic, strong) UIImageView   *bottomLine;
@property (nonatomic, assign) BOOL          showBottomLine;

@end
