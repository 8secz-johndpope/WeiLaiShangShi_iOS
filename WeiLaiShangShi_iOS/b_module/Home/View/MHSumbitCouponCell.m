//
//  MHSumbitCouponCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHSumbitCouponCell.h"

@implementation MHSumbitCouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        _leftImageView = [[UIImageView alloc] init];
//        _leftImageView.backgroundColor = kRandomColor;
//        [_leftImageView setImage:[UIImage imageNamed:@"left_back"]];
        [self.contentView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(30), kRealValue(30)));
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(16));
        }];

        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"优惠券";
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(kRealValue(8));
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(70));
        }];
        
        _footLabel= [[UILabel alloc] init];
        _footLabel.text = @"已优惠80元&每日分享可获优惠券";
        _footLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _footLabel.textColor = [UIColor colorWithHexString:@"666666"];
        [self.contentView addSubview:_footLabel];
        [_footLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-kRealValue(8));
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(70));
        }];
        
        _selectBtn = [[UIButton alloc] init];
        _selectBtn.userInteractionEnabled = NO;
        
        [_selectBtn setImage:kGetImage(@"ic_choice_unselect") forState:UIControlStateDisabled];
        [_selectBtn setImage:kGetImage(@"ic_choice_unselect_border") forState:UIControlStateNormal];
        [_selectBtn setImage:kGetImage(@"ic_choice_select") forState:UIControlStateSelected];

        [self.contentView addSubview:_selectBtn];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(55), kRealValue(55)));
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0);
        }];
        
        UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(64), kScreenWidth , 1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        [self.contentView  addSubview:lineView];
    }
    return self;
}

@end
