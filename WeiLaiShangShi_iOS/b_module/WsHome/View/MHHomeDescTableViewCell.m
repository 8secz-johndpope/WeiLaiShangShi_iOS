//
//  MHHomeDescTableViewCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHHomeDescTableViewCell.h"

@implementation MHHomeDescTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self addSubview:self.descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(kRealValue(10));
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(10));
            make.top.equalTo(self.mas_top).with.offset(kRealValue(15));
        }];
        
        
    }
    return self;
}


-(UILabel *)descLabel
{
    if (!_descLabel) {
        
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _descLabel.textColor =[UIColor colorWithHexString:@"ffffff"];
        _descLabel.numberOfLines = 0 ;
        _descLabel.text = self.descStr;
    }
    return _descLabel;
}

@end
