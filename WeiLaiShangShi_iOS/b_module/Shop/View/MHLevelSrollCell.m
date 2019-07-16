//
//  MHLevelSrollCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/17.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHLevelSrollCell.h"

@implementation MHLevelSrollCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        
        _leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(10), 0, kRealValue(46), kRealValue(50))];
        _leftTitle.text = @"谁懂我...";
        _leftTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _leftTitle.textColor = [UIColor colorWithHexString:@"#333333"];
        _leftTitle.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_leftTitle];
        
        _descTitle = [[UILabel alloc] init];
        _descTitle.frame = CGRectMake(kRealValue(60), 0, kRealValue(168), kRealValue(50));
        _descTitle.text = @"成功邀请“爱过弃过…”升级为店主";
        _descTitle.numberOfLines = 1;
        _descTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _descTitle.textColor = [UIColor colorWithHexString:@"#333333"];
        _descTitle.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_descTitle];
        _descTitle.centerX = kRealValue(165);
    
        _rightTitle = [[UILabel alloc] init];
        _rightTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _rightTitle.textColor = [UIColor colorWithHexString:@"#df3030"];
        _rightTitle.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_rightTitle];
        [_rightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(10));
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
        }];
        
    }
    return self;
}


-(void)creatModel:(MHLevelRecordModel *)model{
    if (model.userNickName.length >= 3) {
        NSString *first = [model.userNickName substringToIndex:1];//字符串开始
        NSString *last = [model.userNickName substringFromIndex:model.userNickName.length-1];//字符串结尾
        _leftTitle.text = [NSString stringWithFormat:@"%@*%@",first,last];
    }else{
         _leftTitle.text = model.userNickName;
    }
    NSString *relationName = @"";
    if (model.relationUserNickName.length >= 3) {
        NSString *first = [model.relationUserNickName substringToIndex:1];//字符串开始
        NSString *last = [model.relationUserNickName substringFromIndex:model.relationUserNickName.length-1];//字符串结尾
        relationName = [NSString stringWithFormat:@"%@*%@",first,last];
    }else{
        relationName = model.relationUserNickName;
    }
    
    if ([GVUserDefaults standardUserDefaults].accessToken == nil) {
        _descTitle.text = [NSString stringWithFormat:@"邀请%@成为金牌推手",relationName];
    }else{
        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"0"]) {
             _descTitle.text = [NSString stringWithFormat:@"邀请%@成为金牌推手",relationName];
        }else{
            _descTitle.text = [NSString stringWithFormat:@"邀请%@成为钻石推手",relationName];
        }
    }
    _rightTitle.text = [NSString stringWithFormat:@"奖励%.0f元",model.scoreRecordMoney];
   
}

@end
