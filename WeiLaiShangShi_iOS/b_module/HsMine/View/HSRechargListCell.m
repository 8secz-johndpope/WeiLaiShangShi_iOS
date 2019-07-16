//
//  HSRechargListCell.m
//  HSKD
//
//  Created by AllenQin on 2019/3/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSRechargListCell.h"

@implementation HSRechargListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.paimingView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.paimingView];
        [self.paimingView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(20));
            make.width.mas_equalTo(kRealValue(25));
            make.height.mas_equalTo(kRealValue(25));
        }];
        
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(20),0 , kScreenWidth - kRealValue(40), 1/kScreenScale)];
        lineview.backgroundColor = KColorFromRGB(0xE2E2E2);
        [self.contentView addSubview:lineview];
        
        
        self.paimingLabel = [[UILabel alloc]init];
        self.paimingLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        self.paimingLabel .textColor =[UIColor colorWithHexString:@"#666666"];
        self.paimingLabel .numberOfLines = 2;
        self.paimingLabel.textAlignment = NSTextAlignmentCenter;
        self.paimingLabel.text =  @" ";
        [self.contentView addSubview:self.paimingLabel];
        [self.paimingLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(20));
            make.width.mas_equalTo(kRealValue(27));
            make.height.mas_equalTo(kRealValue(25));
        }];
        
        self.headView = [[UIImageView alloc] init];
        ViewRadius(self.headView, kRealValue(13));
        [self.contentView addSubview:self.headView];
        [self.headView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(61));
            make.width.mas_equalTo(kRealValue(26));
            make.height.mas_equalTo(kRealValue(26));
        }];
        
        
        
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        self.nameLabel .textColor =[UIColor colorWithHexString:@"#222222"];
        self.nameLabel .numberOfLines = 1;
        self.nameLabel.text =  @"    ";
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(91));
            make.width.mas_equalTo(kRealValue(80));
        }];
        
        
        self.levelLabel = [[UILabel alloc]init];
        self.levelLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        self.levelLabel .textColor =[UIColor colorWithHexString:@"#222222"];
        self.levelLabel .numberOfLines = 1;
        self.levelLabel.text =  @"  ";
        [self.contentView addSubview:self.levelLabel];
        [self.levelLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(173));
        }];
        
        self.jifenLabel  = [[UILabel alloc]init];
        self.jifenLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
        self.jifenLabel.textColor =[UIColor colorWithHexString:@"#FD7215"];
        self.jifenLabel.numberOfLines = 1;
        self.jifenLabel.text =  @"     ";
        [self.contentView addSubview:self.jifenLabel];
        [self.jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(20));
        }];
        

        
        
        
    }
    return self;
}

@end
