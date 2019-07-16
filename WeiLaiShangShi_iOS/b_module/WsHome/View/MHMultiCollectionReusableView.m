//
//  MHMultiCollectionReusableView.m
//  mohu
//
//  Created by AllenQin on 2018/9/8.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHMultiCollectionReusableView.h"

@implementation MHMultiCollectionReusableView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _headTitle = [[UILabel alloc] init];
        _headTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _headTitle.textColor = [UIColor blackColor];
        [self addSubview:_headTitle];
        [_headTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(kRealValue(5));
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
        }];
        
        UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(5), self.height-1, kScreenWidth, 1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
        [self addSubview:lineView];
    }
    return self;
}

@end
