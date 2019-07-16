//
//  MHOrderServiceListCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/19.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHOrderServiceListCell.h"

@implementation MHOrderServiceListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= [UIColor whiteColor];
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(0);
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
        }];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(16), kRealValue(5), kRealValue(70), kRealValue(15))];
        _label.text = @"16:52:11";
        _label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_label];
        
        _label2 = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(25), kRealValue(70), kRealValue(15))];;
        _label2.text = @"9/15";
        _label2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _label2.textColor = [UIColor colorWithHexString:@"#666666"];
        _label2.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_label2];
        
        
        
        _label3 = [[UILabel alloc] init];
        _label3.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _label3.textColor = [UIColor colorWithHexString:@"#6E6E6E"];
        _label3.numberOfLines = 0;
        _label3.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_label3];
        [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView.mas_top).with.offset(kRealValue(10));
            make.bottom.equalTo(self.bgView.mas_bottom).with.offset(-kRealValue(10));
            make.left.equalTo(self.bgView.mas_left).with.offset(kRealValue(120));
            make.width.mas_equalTo(kRealValue(249));
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
        [_bgView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bgView.mas_bottom).with.offset(0);
            make.left.equalTo(self.bgView.mas_left).with.offset(0);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(1/kScreenScale);
        }];
        
    }
    return self;
}




-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    _label.text = dict[@"time"];
    _label2.text = dict[@"date"];
    _label3.text = dict[@"progress"];
}

@end
