//
//  MHWithDrawTitleCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHWithDrawTitleCell.h"

@implementation MHWithDrawTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(44))];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        
        
        UILabel *titlesLabel = [[UILabel alloc]init];
        titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        titlesLabel.textColor =[UIColor colorWithHexString:@"#666666"];
        titlesLabel.text  = @"可提现金额";
        [bgView addSubview:titlesLabel];
        [titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView.mas_centerY).with.offset(0);
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(15));
        }];
//
        UILabel *mobiLabel = [[UILabel alloc]init];
        mobiLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        mobiLabel.textColor =[UIColor colorWithHexString:@"#666666"];
        mobiLabel.textAlignment = NSTextAlignmentRight;
        mobiLabel.text  = @"元";
        [bgView addSubview:mobiLabel];
        [mobiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView.mas_right).with.offset(-kRealValue(15));
            make.bottom.equalTo(bgView.mas_bottom).with.offset(-kRealValue(12));
        }];

        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(24)];
        _moneyLabel.textColor = [UIColor colorWithHexString:@"#222222"];
        _moneyLabel.text  = @"134";
        _moneyLabel.numberOfLines = 1;
        [bgView addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView.mas_centerY).with.offset(0);
            make.right.equalTo(mobiLabel.mas_left).with.offset(-kRealValue(3));
        }];

        
        
    }
    
    return self;
}

@end
