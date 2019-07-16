//
//  MHSumbitMessageView.m
//  mohu
//
//  Created by AllenQin on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHSumbitMessageView.h"

@implementation MHSumbitMessageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
       UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"留言";
        titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        titleLabel.textColor = [UIColor blackColor];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(16));
        }];
        
        _textView = [YYTextView new];
        _textView.frame = CGRectMake(kRealValue(50), kRealValue(10), kRealValue(309), kRealValue(31));
        _textView.layer.masksToBounds = YES;
        _textView.layer.cornerRadius = 5;

        _textView.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _textView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        _textView.textColor = [UIColor blackColor];
        _textView.placeholderText = @"建议留言前先与客服联系";
        _textView.placeholderTextColor = [UIColor  colorWithHexString:@"999999"];
        [self addSubview:_textView];
      
        
    }
    return self;
}

@end
