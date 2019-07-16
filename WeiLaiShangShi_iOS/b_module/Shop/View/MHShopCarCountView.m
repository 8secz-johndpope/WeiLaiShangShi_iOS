
//
//  MHShopCarCountView.m
//  mohu
//
//  Created by 余浩 on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHShopCarCountView.h"


@interface MHShopCarCountView()
@property (nonatomic, strong) UIButton *increaseButton;
@property (nonatomic, strong) UIButton *decreaseButton;
@property (nonatomic, strong) UILabel *editTextField;
@end


@implementation MHShopCarCountView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createview];
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
-(void)createview
{
    [self addSubview:self.increaseButton];
    [self addSubview:self.decreaseButton];
    [self addSubview:self.editTextField];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.decreaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_height);
    }];
    
    [self.increaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(self.mas_height);
    }];
    
    [self.editTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.height);
        make.centerY.equalTo(self.decreaseButton.mas_centerY).offset(0);
        make.left.equalTo(self.decreaseButton.mas_right).offset(0);
        make.right.equalTo(self.increaseButton.mas_left).offset(-0);
    }];
    
}
- (void)configureShopcartCountViewWithProductCount:(NSInteger)productCount productStock:(NSInteger)productStock {
    if (productCount == 1) {
        self.decreaseButton.enabled = NO;
        self.increaseButton.enabled = YES;
    } else if (productCount == productStock) {
        self.decreaseButton.enabled = YES;
        self.increaseButton.enabled = NO;
    } else {
        self.decreaseButton.enabled = YES;
        self.increaseButton.enabled = YES;
    }
    
    self.editTextField.text = [NSString stringWithFormat:@"%ld", productCount];
}
- (void)decreaseButtonAction {
    NSInteger count = self.editTextField.text.integerValue;
    if (self.shopcarCountViewEditBlock) {
        self.shopcarCountViewEditBlock(-- count);
    }
}

- (void)increaseButtonAction {
    NSInteger count = self.editTextField.text.integerValue;
    if (self.shopcarCountViewEditBlock) {
        self.shopcarCountViewEditBlock(++ count);
    }
}
#pragma mark  lazy
- (UIButton *)decreaseButton {
    if(_decreaseButton == nil) {
        _decreaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_decreaseButton setImage:[UIImage imageNamed:@"jianh2"] forState:UIControlStateNormal];
        [_decreaseButton setImage:[UIImage imageNamed:@"jianh1"] forState:UIControlStateDisabled];
        [_decreaseButton addTarget:self action:@selector(decreaseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _decreaseButton;
}

- (UIButton *)increaseButton
{
    if(_increaseButton == nil)
    {
        _increaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_increaseButton setImage:[UIImage imageNamed:@"jiah"] forState:UIControlStateNormal];
        [_increaseButton setImage:[UIImage imageNamed:@"product_detail_add_no"] forState:UIControlStateDisabled];
        [_increaseButton addTarget:self action:@selector(increaseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _increaseButton;
}
- (UILabel *)editTextField {
    if(_editTextField == nil) {
        _editTextField = [[UILabel alloc] init];
        _editTextField.textColor = [UIColor colorWithHexString:@"6E6E6E"];
        _editTextField.textAlignment = NSTextAlignmentCenter;
        _editTextField.clipsToBounds = YES;
        _editTextField.layer.borderColor = KColorFromRGB(0xE1E2E1).CGColor;
        _editTextField.layer.borderWidth = 1/kScreenScale;
        _editTextField.font=[UIFont systemFontOfSize:kFontValue(12)];
        _editTextField.backgroundColor = [UIColor whiteColor];
    }
    return _editTextField;
}


@end
