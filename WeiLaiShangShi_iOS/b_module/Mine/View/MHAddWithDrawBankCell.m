//
//  MHAddWithDrawBankCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHAddWithDrawBankCell.h"

@implementation MHAddWithDrawBankCell



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"请选择银行";
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(16));
        }];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"请选择银行卡";
        _contentLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#B0B0B0"];
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).offset(kRealValue(100));
            make.right.equalTo(self.mas_right).offset(0);
            make.height.mas_equalTo(kRealValue(44));
        }];
        _contentLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seletIndex)];
        [_contentLabel addGestureRecognizer:tap];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(44) , kScreenWidth,1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
        [self addSubview:lineView];
        
        UIImageView *rightView = [[UIImageView alloc] init];
        rightView.image = kGetImage(@"leve_desc_arrow");
        [self addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRealValue(22));
            make.width.mas_equalTo(kRealValue(22));
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(16));
        }];
        
    }
    return self;
}



-(void)seletIndex{
    
    if (self.selectClick) {
        self.selectClick();
    }

}

@end
