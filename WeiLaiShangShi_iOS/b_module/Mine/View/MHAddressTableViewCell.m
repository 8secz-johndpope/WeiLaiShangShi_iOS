//
//  MHAddressTableViewCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/11.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHAddressTableViewCell.h"

@implementation MHAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(10),kRealValue(25), kRealValue(34), kRealValue(34))];
        leftImageView.image = [UIImage imageNamed:@"address_logo"];
        [self addSubview:leftImageView];
        
        UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kRealValue(83), kScreenWidth, kRealValue(3))];
        lineView.image = [UIImage imageNamed:@"back_map_bg"];
        [self addSubview:lineView];
        
        _nameLabel = [[UILabel alloc] init];
//        _nameLabel.text = @"阿静静呐";
        _nameLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth/5);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(54));
            make.top.equalTo(self.mas_top).with.offset(kRealValue(13));
        }];
        
        _phoneLabel = [[UILabel alloc] init];
//        _phoneLabel.text = @"12443332222";
        _phoneLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _phoneLabel.textColor = [UIColor colorWithHexString:@"666666"];
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel.mas_right).with.offset(kRealValue(5));
            make.top.equalTo(self.mas_top).with.offset(kRealValue(13));
        }];
        
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"的好机会接电话就好的和建华大街觉得的建华大街好接口好覅好几段话空间大大加快递费就卡号多少的";
        _addressLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _addressLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _addressLabel.numberOfLines = 2;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kRealValue(305));
            make.left.equalTo(self.mas_left).with.offset(kRealValue(54));
            make.top.equalTo(_nameLabel.mas_bottom).with.offset(kRealValue(7));
        }];
        
    }
    
    return self;
}

@end
