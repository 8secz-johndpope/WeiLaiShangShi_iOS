//
//  MHAddWithDrawnomalCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHAddWithDrawnomalCell.h"

@implementation MHAddWithDrawnomalCell



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"持卡人姓名";
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _titleLabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self  addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(16));
        }];
        _numberTextField = [UITextField new];
        _numberTextField.keyboardType = UIKeyboardTypeDefault;
        _numberTextField.placeholder = @"请输入账号";
        [_numberTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(13)]];
        [self  addSubview:_numberTextField];
        [_numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRealValue(44));
            make.left.equalTo(self.mas_left).offset(kRealValue(100));
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self.mas_top).offset(0);
        }];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(44) , kScreenWidth,1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
        [self  addSubview:lineView];
        
    }
    return self;
}



@end
