//
//  MHAddWithDrawyzCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHAddWithDrawyzCell.h"

@implementation MHAddWithDrawyzCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"持卡人姓名";
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(16));
        }];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = [GVUserDefaults standardUserDefaults].phone;
        _contentLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#FB3131"];
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).offset(kRealValue(100));
        }];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(44) , kScreenWidth,1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
        [self addSubview:lineView];
        
    }
    return self;
}



@end
