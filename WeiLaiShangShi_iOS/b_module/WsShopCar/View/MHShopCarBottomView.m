
//
//  MHShopCarBottomView.m
//  mohu
//
//  Created by 余浩 on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHShopCarBottomView.h"
@interface MHShopCarBottomView()

@end

@implementation MHShopCarBottomView
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.allSelectButton];
    [self addSubview:self.totalPriceLable];
    [self renderWithTotalPrice:@"合计￥0"];
    [self addSubview:self.settleButton];
    [self addSubview:self.starButton];
    [self addSubview:self.deleteButton];
    [self addSubview:self.separateLine];
}

- (void)changeShopcartBottomViewWithStatus:(BOOL)status {
    self.starButton.hidden =YES;
    self.deleteButton.hidden = !status;
   
}

- (void)configureShopcartBottomViewWithTotalPrice:(float)totalPrice totalCount:(NSInteger)totalCount isAllselected:(BOOL)isAllSelected {
    self.allSelectButton.selected = isAllSelected;
    
    self.totalPriceLable.text = [NSString stringWithFormat:@"合计￥%.2f", totalPrice];
    [self renderWithTotalPrice:[NSString stringWithFormat:@"合计￥%.2f", totalPrice]];
    
    [self.settleButton setTitle:[NSString stringWithFormat:@"去结算(%ld)", totalCount] forState:UIControlStateNormal];
    self.settleButton.enabled = totalCount && totalPrice;
    self.starButton.enabled = totalCount && totalPrice;
    self.deleteButton.enabled = totalCount && totalPrice;
      [_allSelectButton setTitle:[NSString stringWithFormat:@"全选"] forState:UIControlStateNormal];
    if (self.settleButton.isEnabled) {
//        [self.settleButton setBackgroundColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1]];
        [self.deleteButton setBackgroundColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1]];
        [self.starButton setBackgroundColor:[UIColor colorWithRed:243/255.0 green:176/255.0 blue:74/255.0 alpha:1]];
    } else {
//        [self.settleButton setBackgroundColor:[UIColor lightGrayColor]];
        [self.deleteButton setBackgroundColor:[UIColor lightGrayColor]];
        [self.starButton setBackgroundColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1]];
    }
}

- (void)allSelectButtonAction {
    self.allSelectButton.selected = !self.allSelectButton.isSelected;
    
    if (self.shopcartBotttomViewAllSelectBlock) {
        self.shopcartBotttomViewAllSelectBlock(self.allSelectButton.isSelected);
    }
}


- (void)settleButtonAction {
    if (self.shopcartBotttomViewSettleBlock) {
        self.shopcartBotttomViewSettleBlock();
    }
}

- (void)starButtonAction {
    if (self.shopcartBotttomViewStarBlock) {
        self.shopcartBotttomViewStarBlock();
    }
}

- (void)deleteButtonAction {
    if (self.shopcartBotttomViewDeleteBlock) {
        self.shopcartBotttomViewDeleteBlock();
    }
}

- (void)renderWithTotalPrice:(NSString *)totalPrice {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.totalPriceLable.text attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:KColorFromRGB(0x2b2b2b)} range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, attributedString.length)];
    self.totalPriceLable.attributedText = attributedString;
    self.totalPriceLable.textAlignment = NSTextAlignmentLeft;
}


- (UIButton *)allSelectButton {
    if (_allSelectButton == nil){
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectButton setTitleColor:KColorFromRGB(0xF85510) forState:UIControlStateNormal];
        _allSelectButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_allSelectButton setImage:kGetImage(@"check_off") forState:UIControlStateNormal];
        [_allSelectButton setImage:kGetImage(@"check_on") forState:UIControlStateSelected];
        [_allSelectButton setTitleEdgeInsets:UIEdgeInsetsMake(0,  -_allSelectButton.imageView.image.size.width +kRealValue(30) , 0, 0)];
        [_allSelectButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, _allSelectButton.titleLabel.bounds.size.width)];
 
        [_allSelectButton addTarget:self action:@selector(allSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectButton;
}

- (UILabel *)totalPriceLable {
    if (_totalPriceLable == nil){
        _totalPriceLable = [[UILabel alloc] init];
        _totalPriceLable.font = [UIFont systemFontOfSize:14];
        _totalPriceLable.textColor = [UIColor colorWithHexString:@"#FF5100"];
        _totalPriceLable.numberOfLines = 2;
        _totalPriceLable.text = @"合计￥0";
    }
    return _totalPriceLable;
}

- (UIButton *)settleButton {
    if (_settleButton == nil){
        _settleButton = [UIButton buttonWithType:UIButtonTypeCustom];
         [_settleButton setBackgroundColor:KColorFromRGB(0xF95212)];
        [_settleButton setTitle:@"去结算" forState:UIControlStateNormal];
        _settleButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_settleButton addTarget:self action:@selector(settleButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _settleButton.enabled = NO;
    }
    return _settleButton;
}

- (UIButton *)starButton {
    if (_starButton == nil){
        _starButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_starButton setTitle:@"收藏" forState:UIControlStateNormal];
        [_starButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _starButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_starButton setBackgroundColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1]];
        [_starButton addTarget:self action:@selector(starButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _starButton.enabled = NO;
        _starButton.hidden = YES;
    }
    return _starButton;
}

- (UIButton *)deleteButton {
    if (_deleteButton == nil){
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_deleteButton setBackgroundColor:KColorFromRGB(0xF95212)];
        [_deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.enabled = NO;
        _deleteButton.hidden = YES;
    }
    return _deleteButton;
}

- (UIView *)separateLine {
    if (_separateLine == nil){
        _separateLine = [[UIView alloc] init];
        _separateLine.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _separateLine;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRealValue(13));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kRealValue(80), kRealValue(23)));
    }];
    
    [self.settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(@100);
    }];
    
    [self.starButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.deleteButton.mas_left);
        make.width.equalTo(@100);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(@100);
    }];
    
    [self.totalPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.allSelectButton.mas_right);
        make.right.equalTo(self.settleButton.mas_left).offset(-5);
    }];
    
    [self.separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@0.3);
    }];
}

@end
