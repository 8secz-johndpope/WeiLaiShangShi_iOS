//
//  HSWalletTwoCell.m
//  HSKD
//
//  Created by AllenQin on 2019/5/8.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWalletTwoCell.h"

@implementation HSWalletTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *backView = [[UIImageView alloc] initWithImage:kGetImage(@"wallet_cell")];
        backView.frame = CGRectMake(kRealValue(15), 0, kRealValue(345), kRealValue(175));
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
        
        
        
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(22),kRealValue(105), kRealValue(150), kRealValue(30))];
        label1.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
        label1.textColor =[UIColor colorWithHexString:@"#666666"];
        label1.text = @"银勺粉丝奖励";
        label1.textAlignment = NSTextAlignmentLeft;
        [backView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(195),kRealValue(105), kRealValue(150), kRealValue(30))];
        label2.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
        label2.textColor =[UIColor colorWithHexString:@"#666666"];
        label2.text = @"金勺粉丝奖励";
        label2.textAlignment = NSTextAlignmentLeft;
        [backView addSubview:label2];
        
        

        
        UIImageView *lineImageView1 = [[UIImageView alloc] initWithImage:kGetImage(@"today_lineView")];
        lineImageView1.frame = CGRectMake(0, kRealValue(111), 1,44);
        [backView addSubview:lineImageView1];
        lineImageView1.centerX = backView.centerX - kRealValue(10);
        
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(22),kRealValue(125), kRealValue(150), kRealValue(30))];
        self.leftLabel .font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
        self.leftLabel .textColor =[UIColor colorWithHexString:@"#666666"];
        self.leftLabel .text = @"   ";
        self.leftLabel .textAlignment = NSTextAlignmentLeft;
        [backView addSubview:self.leftLabel];
        
        self.midLabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(195),kRealValue(125), kRealValue(150), kRealValue(30))];
        self.midLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
        self.midLabel.textColor =[UIColor colorWithHexString:@"#666666"];
        self.midLabel.text = @"  ";
        self.midLabel.textAlignment = NSTextAlignmentLeft;
        [backView addSubview:self.midLabel];
        
        
        
        
    }
    return self;
}
@end

