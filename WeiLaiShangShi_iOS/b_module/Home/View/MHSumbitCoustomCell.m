//
//  MHSumbitCoustomCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHSumbitCoustomCell.h"

@implementation MHSumbitCoustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _leftImageView = [[UIImageView alloc] init];
//        _leftImageView.backgroundColor = kRandomColor;
        [_leftImageView setImage:[UIImage imageNamed:@"ic_play_coupon"]];
        [self.contentView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(40), kRealValue(40)));
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
        _footLabel.text = @"每日分享可获优惠券";
        _footLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _footLabel.textColor = [UIColor colorWithHexString:@"666666"];
        [self.contentView addSubview:_footLabel];
        [_footLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-kRealValue(8));
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(70));
        }];
        
        _selectBtn = [[UIButton alloc] init];
        _selectBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:_selectBtn];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(55), kRealValue(55)));
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0);
        }];
        
        _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - kRealValue(86), 0, kRealValue(78), kRealValue(64))];
        _selectBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        [_selectBtn setImage:[UIImage imageNamed:@"leve_desc_arrow"] forState:UIControlStateNormal];
        [_selectBtn setTitle:@"暂未开放" forState:UIControlStateNormal];
        [_selectBtn setTitleColor:[UIColor colorWithHexString:@"#FB3131"] forState:UIControlStateNormal];
        [_selectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _selectBtn.imageView.image.size.width +kRealValue(4), 0, _selectBtn.imageView.image.size.width)];
        [_selectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _selectBtn.titleLabel.bounds.size.width-kRealValue(4), 0, -_selectBtn.titleLabel.bounds.size.width+kRealValue(4))];
        [self.contentView  addSubview:_selectBtn];
    }
    return self;
}

@end
