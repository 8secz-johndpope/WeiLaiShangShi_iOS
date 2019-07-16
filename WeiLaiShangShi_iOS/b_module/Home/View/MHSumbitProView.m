//
//  MHSumbitProView.m
//  mohu
//
//  Created by AllenQin on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHSumbitProView.h"

@implementation MHSumbitProView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(35))];
        [self addSubview:view1];
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(35), kScreenWidth, kRealValue(30))];
        [self addSubview:view2];
        
        _leftImageView = [[UIImageView alloc] init];
//        _leftImageView.backgroundColor = kRandomColor;
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.layer.cornerRadius = kRealValue(6);
        //        [_leftImageView setImage:[UIImage imageNamed:@"left_back"]];
        [view1 addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
            make.centerY.equalTo(view1.mas_centerY).with.offset(0);
            make.left.equalTo(view1.mas_left).with.offset(kRealValue(16));
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"魅惑炫彩唇膏礼";
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _titleLabel.textColor = [UIColor blackColor];
        [view1 addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view1.mas_centerY).with.offset(0);
            make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(10));
        }];
        
        
//        UIImageView *imageView = [[UIImageView alloc] init];
//        [imageView setImage:[UIImage imageNamed:@"data_member"]];
//        [view2 addSubview:imageView];
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(14)));
//            make.centerY.equalTo(view2.mas_centerY).with.offset(0);
//            make.left.equalTo(view2.mas_left).with.offset(kRealValue(19));
//        }];
//        
//        _footLabel= [[UILabel alloc] init];
//        _footLabel.text = @"升级掌柜子可再减10元";
//        _footLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//        _footLabel.textColor = [UIColor colorWithHexString:@"666666"];
//        [view2 addSubview:_footLabel];
//        [_footLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(view2.mas_centerY).with.offset(0);
//            make.left.equalTo(imageView.mas_right).with.offset(kRealValue(8));
//        }];
//        
        

    }
    return self;
}


@end
