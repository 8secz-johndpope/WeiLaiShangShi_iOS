//
//  MHOrderNormalTableViewCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/11.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHOrderNormalTableViewCell.h"

@implementation MHOrderNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
        _nameLabel.textColor =[UIColor colorWithHexString:@"333333"];
        _nameLabel.text  = @"商品数量";
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(16));
        }];
        
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _numberLabel.textColor =[UIColor colorWithHexString:@"000000"];
        _numberLabel.text  = @"2件";
        [self.contentView addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-kRealValue(10));
        }];
        
        UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(10), kRealValue(40)-1/kScreenScale, kScreenWidth, 1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        [self.contentView addSubview:lineView];
        
    }
    
    return self;
}
@end
