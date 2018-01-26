//
//  ZMSetupViewCell.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/8.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMSetupViewCell.h"

@implementation ZMSetupViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)view).delaysContentTouches = NO; // Remove touch delay for iOS 7
            break;
        }
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    return self;
}
- (UIView *)mainView{
    if (!_mainView) {
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
    }
    return _mainView;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"postDetail_arrow~iphone"];
        _arrowImageView.image = image;
        [self.mainView addSubview:_arrowImageView];
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _arrowImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.mainView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(self.arrowImageView.mas_left).with.offset(-12);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _nameLabel;
}

- (UIImageView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [UIImageView new];
        _bottomLine.image = [YYImage imageWithColor:[UIColor cyanColor]];
        [self.mainView addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _bottomLine;
}



- (void)setShowBottomLine:(BOOL)showBottomLine{
    self.bottomLine.hidden = !showBottomLine;
}

@end
