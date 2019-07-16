//
//  MHSumbitHeadView.m
//  mohu
//
//  Created by AllenQin on 2018/9/21.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHSumbitHeadView.h"

@implementation MHSumbitHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
   
        
        self.label1 = [[UILabel alloc] init];
        self.label1.hidden = YES;
         self.label1.text = @"收货人：";
         self.label1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
         self.label1.textColor = [UIColor blackColor];
         self.label1.textAlignment = NSTextAlignmentLeft;
        [self addSubview: self.label1];
        [ self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(kRealValue(20));
            make.top.equalTo(self.mas_top).with.offset(kRealValue(13));
        }];
        
        
        
        
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"    ";
        
        _nameLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth/4);
            make.left.equalTo( self.label1.mas_right).with.offset(kRealValue(5));
            make.top.equalTo(self.mas_top).with.offset(kRealValue(13));
        }];
        
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.text = @"     ";
        _phoneLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _phoneLabel.textColor = [UIColor blackColor];
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(40));
            make.top.equalTo(self.mas_top).with.offset(kRealValue(13));
        }];
        
        
        
        self.label2 = [[UILabel alloc] init];
        self.label2.text = @"收货地址：";
        self.label2.hidden = YES;
        self.label2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        self.label2.textColor = [UIColor blackColor];
        self.label2.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.label2];
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(kRealValue(20));
            make.top.equalTo(_nameLabel.mas_bottom).with.offset(kRealValue(7));
        }];
        
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"  ";
        _addressLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _addressLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _addressLabel.numberOfLines = 2;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kRealValue(240));
            make.left.equalTo(_nameLabel.mas_left).with.offset(0);
            make.top.equalTo(_nameLabel.mas_bottom).with.offset(kRealValue(7));
//            make.bottom.equalTo(self.mas_bottom).with.offset(0);
        }];
        
        
    
        _emtyLabel = [[UILabel alloc] init];
        _emtyLabel.text = @"请填写您的收货信息";
        _emtyLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _emtyLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _emtyLabel.numberOfLines = 1;
        _emtyLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_emtyLabel];
        [_emtyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(kRealValue(54));
            make.top.equalTo(self.mas_top).with.offset(kRealValue(35));
        }];
        
        UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(343),kRealValue(30), kRealValue(22), kRealValue(22))];
        rightImageView.image = [UIImage imageNamed:@"add_choice"];
        [self addSubview:rightImageView];
        
    }
    return self;
}

@end
