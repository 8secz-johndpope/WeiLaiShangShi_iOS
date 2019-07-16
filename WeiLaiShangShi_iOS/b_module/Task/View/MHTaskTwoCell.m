

//
//  MHTaskTwoCell.m
//  wgts
//
//  Created by yuhao on 2018/11/9.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTaskTwoCell.h"
#import "UIImage+Common.h"
#import "MHTaskListSingerModel.h"
@implementation MHTaskTwoCell

-(void)setSingerModel:(MHTaskListSingerModel *)singerModel
{
    if ([singerModel.status isEqualToString:@"PENDING"]) {
        [self.statubtn setTitle:@"做任务" forState:UIControlStateNormal];
         [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xFF3344)] forState:UIControlStateNormal];
    }
    if ([singerModel.status isEqualToString:@"ACTIVE"]) {
        [self.statubtn setTitle:@"进行中" forState:UIControlStateNormal];
         [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xFF3344)] forState:UIControlStateNormal];
    }
    if ([singerModel.status isEqualToString:@"DONE"]) {
        [self.statubtn setTitle:@"已完成" forState:UIControlStateNormal];
         [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateNormal];
    }
    if ([singerModel.status isEqualToString:@"INVALID"]) {
        [self.statubtn setTitle:@"已失效" forState:UIControlStateNormal];
         [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateNormal];
    }
    if ([singerModel.status isEqualToString:@"FAILED"]) {
        [self.statubtn setTitle:@"未达标" forState:UIControlStateNormal];
        [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateNormal];
    }
    if ([singerModel.status isEqualToString:@"AUDIT"]) {
        [self.statubtn setTitle:@"审核中" forState:UIControlStateNormal];
        [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xFF3344)] forState:UIControlStateNormal];
    }
    
    
    self.moneylabel.text =[NSString stringWithFormat:@"奖励%@元",[NSString stringWithFormat:@"%@",singerModel.money]];
    self.Tasktitlelabel.text =[NSString stringWithFormat:@"%@",singerModel.taskName];
    self.titlelabel.text =[NSString stringWithFormat:@"%@",singerModel.produceName];
}
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
    [self addSubview:self.Tasktitlelabel];
    [self addSubview:self.statubtn];
    [self addSubview:self.moneylabel];
    self.lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(0), kRealValue(70), kScreenWidth , 1/kScreenScale)];
    self.lineview.backgroundColor=  KColorFromRGB(0xF0F0F0);
    [self addSubview:self.lineview];
}
-(UILabel *)titlelabel
{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.text =@"暂无数据";
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
      // [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateDisabled];
        _statubtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _statubtn.titleLabel.textAlignment  =NSTextAlignmentCenter;
        [_statubtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       [_statubtn setTitleColor:[UIColor colorWithHexString:@"#6E6E6E"] forState:UIControlStateDisabled];
        [_statubtn addTarget:self action:@selector(butAct) forControlEvents:UIControlEventTouchUpInside];
    }
    return _statubtn;
}
-(void)butAct
{
    if (self.dotask) {
        self.dotask();
    }
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
    [self.moneylabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(self.mas_right).offset(-kRealValue(16));
        make.top.equalTo(self.mas_top).offset(kRealValue(10));
        make.height.mas_equalTo(kRealValue(17));
    }];
    [self.statubtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-kRealValue(16));
         make.top.equalTo(self.moneylabel.mas_bottom).offset(kRealValue(8));
        make.width.mas_equalTo(kRealValue(60));
        make.height.mas_equalTo(kRealValue(24));
        
    }];
    ViewRadius(self.statubtn, kRealValue(12));
    
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(16));
        make.top.equalTo(self.mas_top).offset(kRealValue(10));
        make.right.equalTo(self.moneylabel.mas_left).offset(-kRealValue(10));
        make.height.mas_equalTo(kRealValue(20));
    }];
    [self.Tasktitlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(16));
        make.top.equalTo(self.titlelabel.mas_bottom).offset(kRealValue(14));
        make.width.mas_equalTo(kRealValue(218));
        make.height.mas_equalTo(kRealValue(17));
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
