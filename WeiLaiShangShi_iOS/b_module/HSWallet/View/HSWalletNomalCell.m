//
//  HSWalletNomalCell.m
//  HSKD
//
//  Created by AllenQin on 2019/5/8.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWalletNomalCell.h"

@implementation HSWalletNomalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *backView = [[UIImageView alloc] initWithImage:kGetImage(@"wallet_cell_nomal")];
        backView.frame = CGRectMake(kRealValue(15), 0, kRealValue(345), kRealValue(95));
        [self.contentView addSubview:backView];
        
        
        self.headLabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(23),kRealValue(17), kRealValue(150), kRealValue(30))];
        self.headLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(15)];
        self.headLabel.textColor =[UIColor colorWithHexString:@"#666666"];
        self.headLabel.textAlignment = NSTextAlignmentLeft;
        [backView addSubview:self.headLabel];
        
        NSMutableAttributedString *hotStr = [[NSMutableAttributedString alloc]      initWithString:@"邀请奖励（火币）"];
        [hotStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangMedium size:kFontValue(13)] range:NSMakeRange(4,4)];
        self.headLabel.attributedText = hotStr;
        
        
        self.chargeLabel = [[UILabel alloc]init];
        self.chargeLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(27)];
        self.chargeLabel.textColor =[UIColor colorWithHexString:@"#D1AA6D"];
        self.chargeLabel.textAlignment = NSTextAlignmentLeft;
        self.chargeLabel.text = @"  ";
        [backView addSubview: self.chargeLabel];
        [self.chargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backView.mas_top).offset(kRealValue(41));
            make.left.equalTo(backView.mas_left).offset(kRealValue(23));
        }];
        
    }
    return self;
}
@end

