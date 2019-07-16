//
//  MHAssestCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/30.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHAssestCell.h"

@implementation MHAssestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , kRealValue(58))];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.frame = CGRectMake(kRealValue(10), kRealValue(31), kRealValue(85), kRealValue(17));
        _dataLabel.text = @"2022/08/20";
        _dataLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _dataLabel.textColor = [UIColor colorWithHexString:@"#6E6E6E"];
        _dataLabel.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:_dataLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.frame = CGRectMake(kRealValue(10), kRealValue(11), kRealValue(85), kRealValue(17));
        _timeLabel.text = @"08:20";
        _timeLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:_timeLabel];
        
        
        _descLabel = [[UILabel alloc] init];
        _descLabel.frame = CGRectMake(kRealValue(110), kRealValue(31), kRealValue(200), kRealValue(17));
//        _descLabel.text = @"恭喜您升级为店主恭喜您升级为店主恭喜您升级为店主恭喜";
        _descLabel.numberOfLines = 2;
        _descLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _descLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_descLabel];
      
        

        _titlesLabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(110),kRealValue(11), kRealValue(200), kRealValue(17))];
        _titlesLabel.numberOfLines = 1;
        _titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _titlesLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _titlesLabel.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_titlesLabel];
       
        
        
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.frame = CGRectMake(kRealValue(225),kRealValue(10),kRealValue(134),kRealValue(20));
        _moneyLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _moneyLabel.textColor = [UIColor colorWithHexString:@"#FF0116"];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        [_bgView addSubview:_moneyLabel];
       
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(57) , kScreenWidth - kRealValue(32),1/kScreenScale )];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
        [_bgView addSubview:lineView];
        
    }
    return self;
}


-(void)createModel:(MHShopAssetModel *)model{

    _dataLabel.text = model.date;
    _timeLabel.text = model.time;
    _titlesLabel.text = model.title;
    _descLabel.text = model.content;
    if ([model.type isEqualToString:@"INCOME"]) {
        _moneyLabel.text = [NSString stringWithFormat:@"+%@元",model.money];
    }else  if ([model.type isEqualToString:@"EXPENSE"]){
        _moneyLabel.text = [NSString stringWithFormat:@"-%@元",model.money];
    }else  if ([model.type isEqualToString:@"EXPENSE_FREEZE"]){
        _moneyLabel.text = [NSString stringWithFormat:@"-%@元(审核中)",model.money];
    }else  if ([model.type isEqualToString:@"EXPENSE_REJECT"]){
        _moneyLabel.text = [NSString stringWithFormat:@"+%@元(拒绝)",model.money];
    }
    
}


@end
