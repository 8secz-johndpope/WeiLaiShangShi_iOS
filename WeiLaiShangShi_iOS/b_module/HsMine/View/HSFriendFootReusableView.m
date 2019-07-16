//
//  HSFriendFootReusableView.m
//  HSKD
//
//  Created by AllenQin on 2019/5/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSFriendFootReusableView.h"

@implementation HSFriendFootReusableView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"#F2F3F3"];
        [self addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
            make.height.mas_equalTo(kRealValue(10));
            make.width.mas_equalTo(kScreenWidth);
        }];
        
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.text = @"友力值说明";
        textLabel.font = [UIFont fontWithName:kPingFangMedium size:kRealValue(16)];
        textLabel.textColor = [UIColor colorWithHexString:@"222222"];
        [self addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.top.equalTo(self.mas_top).offset(kRealValue(43));
        }];
        
        UIImageView *arrowView = [[UIImageView alloc]init];
        arrowView.image = kGetImage(@"sm_right_icon");
        [self addSubview:arrowView];
        [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(textLabel.mas_centerY).offset(0);
            make.left.equalTo(textLabel.mas_right).offset(kRealValue(10));
            make.height.mas_equalTo(kRealValue(4));
            make.width.mas_equalTo(kRealValue(33));
        }];
        
        UIImageView *arrowView1 = [[UIImageView alloc]init];
        arrowView1.image = kGetImage(@"sm_left_icon");
        [self addSubview:arrowView1];
        [arrowView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(textLabel.mas_centerY).offset(0);
            make.right.equalTo(textLabel.mas_left).offset(-kRealValue(10));
            make.height.mas_equalTo(kRealValue(4));
            make.width.mas_equalTo(kRealValue(33));
        }];
        
        
        self.subtitleLabel = [[UILabel alloc]init];
        self.subtitleLabel.numberOfLines = 0;
        self.subtitleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        self.subtitleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [self addSubview:self.subtitleLabel];
        [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(textLabel.mas_centerX).offset(0);
            make.top.equalTo(self.mas_top).offset(kRealValue(80));
            make.width.mas_equalTo(kRealValue(345));
        }];
    }
    return self;
    
}

@end
