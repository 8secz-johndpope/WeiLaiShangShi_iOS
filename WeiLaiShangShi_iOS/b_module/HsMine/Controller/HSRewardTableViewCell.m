//
//  HSRewardTableViewCell.m
//  HSKD
//
//  Created by AllenQin on 2019/3/12.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSRewardTableViewCell.h"

@implementation HSRewardTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= [UIColor whiteColor];
        
        self.textsLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(13), 0, kRealValue(36), kRealValue(36))];
        //        textsLabel.text = @"提现";
        ViewRadius(self.textsLabel, kRealValue(18));
        self.textsLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(11)];
        self.textsLabel.backgroundColor = [UIColor colorWithHexString:@"#F32B2B"];
        self.textsLabel.textAlignment = NSTextAlignmentCenter;
        self.textsLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.textsLabel];
        self.textsLabel.centerY = kRealValue(35);
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(69)-1/kScreenScale, kScreenWidth, 1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#E2E2E2"];
        [self.contentView addSubview:lineView];
        
        
        [self createview];
        
        
    }
    return self;
}
-(void)createview
{
    [self addSubview:self.RecordPresentname];
    [self addSubview:self.RecordPresenttime];
    [self addSubview:self.RecordPresentcardnum];
    [self addSubview:self.RecordPresentstate];
    
    [self.RecordPresentname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kRealValue(15));
        make.left.equalTo(self.mas_left).offset(kRealValue(61));
        make.width.mas_equalTo(kRealValue(210));
        make.height.mas_equalTo(kRealValue(20));
        
    }];
    
    [self.RecordPresenttime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-kRealValue(15));
        make.left.equalTo(self.mas_left).offset(kRealValue(61));
        make.width.mas_equalTo(kRealValue(200));
        make.height.mas_equalTo(kRealValue(12));
        
    }];
    
    [self.RecordPresentcardnum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.RecordPresentname.mas_centerY).offset(0);
        make.right.equalTo(self.mas_right).offset(-kRealValue(12));
        make.width.mas_equalTo(kRealValue(200));
        make.height.mas_equalTo(kRealValue(20));
        
    }];
    [self.RecordPresentstate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.RecordPresenttime.mas_centerY).offset(0);
        make.right.equalTo(self.mas_right).offset(-kRealValue(12));
        make.width.mas_equalTo(kRealValue(200));
        make.height.mas_equalTo(kRealValue(12));

    }];
    
    
    
}
-(UILabel *)RecordPresentname
{
    if (!_RecordPresentname) {
        _RecordPresentname = [[UILabel alloc]init];
        _RecordPresentname.text = @"余额提现";
        _RecordPresentname.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _RecordPresentname.textAlignment = NSTextAlignmentLeft;
        _RecordPresentname.textColor = KColorFromRGB(0x222222);
        
    }
    return _RecordPresentname;
}
-(UILabel *)RecordPresenttime
{
    if (!_RecordPresenttime) {
        _RecordPresenttime = [[UILabel alloc]init];
        _RecordPresenttime.text = @"09-10 19:28";
        _RecordPresenttime.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        _RecordPresenttime.textAlignment = NSTextAlignmentLeft;
        _RecordPresenttime.textColor = KColorFromRGB(0x999999);
    }
    return _RecordPresenttime;
}
-(UILabel *)RecordPresentcardnum
{
    if (!_RecordPresentcardnum) {
        _RecordPresentcardnum = [[UILabel alloc]init];
        _RecordPresentcardnum.text = @"188****8888";
        _RecordPresentcardnum.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        _RecordPresentcardnum.textAlignment = NSTextAlignmentRight;
        _RecordPresentcardnum.textColor = KColorFromRGB(0xF32B2B);
    }
    return _RecordPresentcardnum;
}
-(UILabel *)RecordPresentstate
{
    if (!_RecordPresentstate) {
        _RecordPresentstate = [[UILabel alloc]init];
        _RecordPresentstate.text = @"提现失败";
        _RecordPresentstate.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _RecordPresentstate.textAlignment = NSTextAlignmentRight;
        _RecordPresentstate.textColor = KColorFromRGB(0x666666);
    }
    return _RecordPresentstate;
}


@end
