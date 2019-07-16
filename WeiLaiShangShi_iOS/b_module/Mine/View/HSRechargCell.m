//
//  HSRechargCell.m
//  HSKD
//
//  Created by AllenQin on 2019/3/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSRechargCell.h"

@implementation HSRechargCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(20), 0, kRealValue(335), kRealValue(71))];
        ViewRadius(bgView, kRealValue(3));
        bgView.backgroundColor = [UIColor colorWithHexString:@"#FFF5EF"];
        [self addSubview:bgView];
        
        
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        [bgView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(42), kRealValue(42)));
            make.centerY.equalTo(bgView.mas_centerY).with.offset(0);
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(18));
        }];
        
        _titlesLabel = [[UILabel alloc]init];
        _titlesLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        _titlesLabel.textColor =[UIColor colorWithHexString:@"222222"];
        _titlesLabel.text  = @"       ";
        _titlesLabel.numberOfLines = 1;
        [bgView addSubview:_titlesLabel];
        [_titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_top).with.offset(kRealValue(12));
            make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(15));
            
        }];
        
        
        _dingdanLabel = [[UILabel alloc]init];
        _dingdanLabel.text = @"          ";
        _dingdanLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        _dingdanLabel.textColor =[UIColor colorWithHexString:@"#666666"];
        _dingdanLabel.numberOfLines = 1;
        [bgView addSubview:_dingdanLabel];
        [_dingdanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bgView.mas_bottom).with.offset(-kRealValue(16));
            make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(15));
        }];
        
    }
    return self;
}
@end
