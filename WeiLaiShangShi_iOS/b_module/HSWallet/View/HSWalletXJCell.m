//
//  HSWalletXJCell.m
//  HSKD
//
//  Created by AllenQin on 2019/5/8.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWalletXJCell.h"
#import "RichStyleLabel.h"


@implementation HSWalletXJCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
//        UIImageView *oneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(10), kRealValue(16), kRealValue(49), kRealValue(49))];
//        oneImageView.image = kGetImage(@"wallet_today");
//        [self addSubview:oneImageView];
        
        self.todayLabel= [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(10),kRealValue(14), kRealValue(340), kRealValue(30))];
        self.todayLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(16)];
        self.todayLabel.textColor =[UIColor colorWithHexString:@"#333333"];
        [self addSubview:self.todayLabel];
        
//        [todayLabel setAttributedText:@"升级银勺奖励（火币）" withRegularPattern:@"[（火币）]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#666666"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(12)]}];
        
        self.todayDescLabel = [[UILabel alloc] init];
         self.todayDescLabel.text = @"2019/5/5 15:30";
         self.todayDescLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
         self.todayDescLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [self addSubview: self.todayDescLabel];
        [ self.todayDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.todayLabel.mas_bottom).offset(0);
            make.left.equalTo(self.mas_left).offset(kRealValue(10));
        }];
        
        
        _jfLabel = [[UILabel alloc] init];
        _jfLabel.text = @"+1880000";
        _jfLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
        _jfLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:_jfLabel];
        [_jfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.todayLabel.mas_centerY).offset(0);
            make.right.equalTo(self.mas_right).offset(-kRealValue(10));
        }];
        
        
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.text = @"汇款中";
        _stateLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _stateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [self addSubview:_stateLabel];
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.todayDescLabel.mas_centerY).offset(0);
               make.right.equalTo(self.mas_right).offset(-kRealValue(10));
        }];
        
        
        
        
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(10),kRealValue(82) - 1/kScreenScale, kRealValue(345), 1/kScreenScale)];
        lineview.backgroundColor = KColorFromRGB(0xE2E2E2);
        [self addSubview:lineview];
        
    }
    return self;
}
@end
