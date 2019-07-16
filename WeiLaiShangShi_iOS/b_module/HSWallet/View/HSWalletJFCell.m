//
//  HSWalletJFCell.m
//  HSKD
//
//  Created by AllenQin on 2019/5/8.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWalletJFCell.h"


@implementation HSWalletJFCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.oneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(10), kRealValue(16), kRealValue(49), kRealValue(49))];
        self.oneImageView .image = kGetImage(@"wallet_today");
        [self addSubview:self.oneImageView ];
        
        self.todayLabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(70),kRealValue(14), kRealValue(150), kRealValue(30))];
        self.todayLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(16)];
        self.todayLabel.textColor =[UIColor colorWithHexString:@"#333333"];
        [self addSubview:self.todayLabel];
        
//       
        
        self.todayDescLabel = [[UILabel alloc] init];
        self.todayDescLabel.text = @" ";
        self.todayDescLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        self.todayDescLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [self addSubview:self.todayDescLabel];
        [self.todayDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.oneImageView .mas_bottom).offset(0);
            make.left.equalTo(self.mas_left).offset(kRealValue(70));
        }];
        
        
        _jfLabel = [[UILabel alloc] init];
        _jfLabel.text = @" ";
        _jfLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
        _jfLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:_jfLabel];
        [_jfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.oneImageView .mas_centerY).offset(0);
            make.right.equalTo(self.mas_right).offset(-kRealValue(10));
        }];
        
        
        
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(10),kRealValue(82) - 1/kScreenScale, kRealValue(345), 1/kScreenScale)];
        lineview.backgroundColor = KColorFromRGB(0xE2E2E2);
        [self addSubview:lineview];
        
    }
    return self;
}
@end
