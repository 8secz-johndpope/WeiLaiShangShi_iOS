//
//  MHMultiTableViewCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/8.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHMultiTableViewCell.h"

@implementation MHMultiTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"F2F3F5"];
        _leftTitle = [[UILabel alloc] init];
        _leftTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _leftTitle.textColor = [UIColor colorWithHexString:@"FF5100"];
        [self.contentView addSubview:_leftTitle];
        [_leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        }];
        
        _leftIcon = [[UIView alloc] init];
        _leftIcon.backgroundColor = [UIColor colorWithHexString:@"FF5100"];
        [self.contentView addSubview:_leftIcon];
        _leftIcon.layer.cornerRadius = kRealValue(3);
        [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.leftTitle.mas_centerY).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(11));
            make.size.mas_equalTo(CGSizeMake(kRealValue(3),kRealValue(17)));
        }];
        
    }
    
    return self;
}


@end
