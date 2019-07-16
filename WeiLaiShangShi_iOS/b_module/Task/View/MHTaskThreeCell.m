//
//  MHTaskThreeCell.m
//  wgts
//
//  Created by yuhao on 2018/11/20.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTaskThreeCell.h"

@implementation MHTaskThreeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createview];
    }
    return self;
}
-(void)createview
{
    
    [self addSubview:self.titlelabel];
    
    
    
}
-(UILabel *)titlelabel
{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.text =@"";
        _titlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        _titlelabel.textColor = KColorFromRGB(0x000000);
        _titlelabel.textAlignment=NSTextAlignmentLeft;
    }
    return _titlelabel;
}
-(UILabel *)Tasktitlelabel
{
    if (!_Tasktitlelabel) {
        _Tasktitlelabel = [[UILabel alloc]init];
        _Tasktitlelabel.text =@"这里中文字符限制在十五个字以内…";
        _Tasktitlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _Tasktitlelabel.textColor = KColorFromRGB(0x2b2b2b);
        _Tasktitlelabel.textAlignment=NSTextAlignmentLeft;
    }
    return _Tasktitlelabel;
}
-(UIButton *)statubtn
{
    if (!_statubtn) {
        _statubtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_statubtn setTitle:@"去邀请" forState:UIControlStateNormal];
        //    [self.statubtn setTitle:@"已完成" forState:UIControlStateDisabled];
        [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xFF3344)] forState:UIControlStateNormal];
        [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateDisabled];
        _statubtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _statubtn.titleLabel.textAlignment  =NSTextAlignmentCenter;
        [_statubtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_statubtn setTitleColor:[UIColor colorWithHexString:@"#6E6E6E"] forState:UIControlStateDisabled];
    }
    return _statubtn;
}
-(UILabel *)moneylabel
{
    if (!_moneylabel) {
        _moneylabel = [[UILabel alloc]init];
        _moneylabel.text =@"";
        _moneylabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _moneylabel.textColor = KColorFromRGB(0xFF0116);
        _moneylabel.textAlignment=NSTextAlignmentRight;
        [self addSubview:_moneylabel];
    }
    return _moneylabel;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(16));
        make.centerY.equalTo(self.mas_centerY).offset(kRealValue(0));
        make.height.mas_equalTo(kRealValue(20));
    }];
    
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
