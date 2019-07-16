//
//  HSTaskNormalCell.m
//  HSKD
//
//  Created by yuhao on 2019/2/28.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSTaskNormalCell.h"
#import "MHTaskDetailModel.h"
@implementation HSTaskNormalCell

-(void)createWithModel:(MHTaskDetailModel *)singerModel
{
    
    if ([singerModel.property isEqualToString:@"REVIEW"]) {
        if ([singerModel.status isEqualToString:@"PENDING"]) {
//            [self.statubtn setTitle:@"做任务" forState:UIControlStateNormal];
//            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(kThemecolor)] forState:UIControlStateNormal];
            self.statubtn.text = @"做任务";
            self.statubtn.backgroundColor = KColorFromRGB(kThemecolor);
            
        }
        if ([singerModel.status isEqualToString:@"ACTIVE"]) {
//            [self.statubtn setTitle:@"进行中" forState:UIControlStateNormal];
//            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(kThemecolor)] forState:UIControlStateNormal];
            self.statubtn.text = @"进行中";
            self.statubtn.backgroundColor = KColorFromRGB(kThemecolor);
            
        }
        if ([singerModel.status isEqualToString:@"DONE"]) {
//            [self.statubtn setTitle:@"已完成" forState:UIControlStateNormal];
//            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateNormal];
            self.statubtn.text = @"已完成";
            self.statubtn.backgroundColor = KColorFromRGB(0xE0E0E0);
            
        }
        if ([singerModel.status isEqualToString:@"INVALID"]) {
//            [self.statubtn setTitle:@"已失效" forState:UIControlStateNormal];
//            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateNormal];
            self.statubtn.text = @"已失效";
            self.statubtn.backgroundColor = KColorFromRGB(0xE0E0E0);
        }
        if ([singerModel.status isEqualToString:@"FAILED"]) {
//            [self.statubtn setTitle:@"未达标" forState:UIControlStateNormal];
//            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateNormal];
            self.statubtn.text = @"未达标";
            self.statubtn.backgroundColor = KColorFromRGB(0xE0E0E0);
        }
        if ([singerModel.status isEqualToString:@"AUDIT"]) {
//            [self.statubtn setTitle:@"审核中" forState:UIControlStateNormal];
//            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(kThemecolor)] forState:UIControlStateNormal];
            self.statubtn.text = @"审核中";
            self.statubtn.backgroundColor = KColorFromRGB(0xE0E0E0);
        }
    }else if ([singerModel.property isEqualToString:@"READ"]||[singerModel.property isEqualToString:@"APPOINT"]) {
        if ([singerModel.status isEqualToString:@"PENDING"]) {
//            [self.statubtn setTitle:@"去阅读" forState:UIControlStateNormal];
//            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(kThemecolor)] forState:UIControlStateNormal];
            self.statubtn.text = @"去阅读";
            self.statubtn.backgroundColor = KColorFromRGB(kThemecolor);
        }
        if ([singerModel.status isEqualToString:@"ACTIVE"]) {
//            [self.statubtn setTitle:@"进行中" forState:UIControlStateNormal];
//            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(kThemecolor)] forState:UIControlStateNormal];
            self.statubtn.text = @"进行中";
            self.statubtn.backgroundColor = KColorFromRGB(kThemecolor);
        }
        if ([singerModel.status isEqualToString:@"DONE"]) {
//            [self.statubtn setTitle:@"已完成" forState:UIControlStateNormal];
//            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateNormal];
            self.statubtn.text = @"已完成";
            self.statubtn.backgroundColor = KColorFromRGB(0xE0E0E0);
        }
        if ([singerModel.status isEqualToString:@"INVALID"]) {
//            [self.statubtn setTitle:@"已失效" forState:UIControlStateNormal];
//            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateNormal];
            self.statubtn.text = @"已失效";
            self.statubtn.backgroundColor = KColorFromRGB(0xE0E0E0);
        }
        if ([singerModel.status isEqualToString:@"FAILED"]) {
//            [self.statubtn setTitle:@"未达标" forState:UIControlStateNormal];
//            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateNormal];
            self.statubtn.text = @"未达标";
            self.statubtn.backgroundColor = KColorFromRGB(0xE0E0E0);
        }
        if ([singerModel.status isEqualToString:@"AUDIT"]) {
//            [self.statubtn setTitle:@"审核中" forState:UIControlStateNormal];
//            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(kThemecolor)] forState:UIControlStateNormal];
            self.statubtn.text = @"审核中";
            self.statubtn.backgroundColor = KColorFromRGB(0xE0E0E0);
        }
    }else{
        if ([singerModel.status isEqualToString:@"PENDING"]) {
            //            [self.statubtn setTitle:@"做任务" forState:UIControlStateNormal];
            //            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(kThemecolor)] forState:UIControlStateNormal];
            self.statubtn.text = @"做任务";
            self.statubtn.backgroundColor = KColorFromRGB(kThemecolor);
            
        }
        if ([singerModel.status isEqualToString:@"ACTIVE"]) {
            //            [self.statubtn setTitle:@"进行中" forState:UIControlStateNormal];
            //            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(kThemecolor)] forState:UIControlStateNormal];
            self.statubtn.text = @"进行中";
            self.statubtn.backgroundColor = KColorFromRGB(kThemecolor);
            
        }
        if ([singerModel.status isEqualToString:@"DONE"]) {
            //            [self.statubtn setTitle:@"已完成" forState:UIControlStateNormal];
            //            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateNormal];
            self.statubtn.text = @"已完成";
            self.statubtn.backgroundColor = KColorFromRGB(0xE0E0E0);
            
        }
        if ([singerModel.status isEqualToString:@"INVALID"]) {
            //            [self.statubtn setTitle:@"已失效" forState:UIControlStateNormal];
            //            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateNormal];
            self.statubtn.text = @"已失效";
            self.statubtn.backgroundColor = KColorFromRGB(0xE0E0E0);
        }
        if ([singerModel.status isEqualToString:@"FAILED"]) {
            //            [self.statubtn setTitle:@"未达标" forState:UIControlStateNormal];
            //            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateNormal];
            self.statubtn.text = @"未达标";
            self.statubtn.backgroundColor = KColorFromRGB(0xE0E0E0);
        }
        if ([singerModel.status isEqualToString:@"AUDIT"]) {
            //            [self.statubtn setTitle:@"审核中" forState:UIControlStateNormal];
            //            [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(kThemecolor)] forState:UIControlStateNormal];
            self.statubtn.text = @"审核中";
            self.statubtn.backgroundColor = KColorFromRGB(0xE0E0E0);
        }
    }
    
   
    
    
    self.Tasktitlelabel.text =[NSString stringWithFormat:@"火币奖励：+%@火币",[NSString stringWithFormat:@"%@",singerModel.integral]];
    self.limitlabel.text =[NSString stringWithFormat:@"任务总数：%@/%@",singerModel.remainCount,singerModel.taskCount];
    self.titlelabel.text =[NSString stringWithFormat:@"%@",singerModel.title];
    if ([singerModel.property isEqualToString:@"READ"]) {
        self.moneylabel.hidden = NO;
        if ([[NSString stringWithFormat:@"%@",singerModel.userTaskRemark] isEqualToString:@""]) {
        
          
            NSString *Str = [NSString stringWithFormat:@"(进度0/%@)",singerModel.remark];
            NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:Str];
            [attstring addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0xFC263E) range:NSMakeRange(3,  1)];
            [attstring addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangRegular size:kFontValue(11)] range:NSMakeRange(3, 1)];
            self.moneylabel.attributedText = attstring;

        }else{
            NSArray *Arr= [singerModel.userTaskRemark componentsSeparatedByString:@","];
            
            NSString *Str = [NSString stringWithFormat:@"(进度%ld/%@)",Arr.count,singerModel.remark];
             NSString *Str1 = [NSString stringWithFormat:@"%ld",Arr.count];
            NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:Str];
            [attstring addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0xFC263E) range:NSMakeRange(3,  Str1.length)];
            [attstring addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangRegular size:kFontValue(11)] range:NSMakeRange(3, Str1.length)];
            self.moneylabel.attributedText = attstring;
//            self.moneylabel.text = [NSString stringWithFormat:@"(进度%ld/%@)",Arr.count,singerModel.remark];
        }
        
    }else{
        self.moneylabel.hidden=YES;
    }
  
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = KColorFromRGB(0xF1F2F1);
        [self createview];
    }
    return self;
}
-(void)createview
{
    self.bgview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(12), 0,kScreenWidth- kRealValue(24), kRealValue(67))];
    self.bgview.backgroundColor = KColorFromRGB(0xffffff);
    [self addSubview:self.bgview];
    [self.bgview addSubview:self.titlelabel];
    [self.bgview addSubview:self.Tasktitlelabel];
    [self.bgview addSubview:self.statubtn];
    [self.bgview addSubview:self.limitlabel];
    [self.bgview addSubview:self.moneylabel];
    
    self.lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(13), kRealValue(66), self.bgview.frame.size.width - kRealValue(26), 1/kScreenScale)];
    self.lineview.backgroundColor = KColorFromRGB(0xE7E7E7);
    [self addSubview:self.lineview];
    
    
}
-(UILabel *)titlelabel
{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.text =@"每日浏览新闻";
        _titlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _titlelabel.textColor = KColorFromRGB(0x222222);
        _titlelabel.textAlignment=NSTextAlignmentLeft;
    }
    return _titlelabel;
}
-(UILabel *)limitlabel
{
    if (!_limitlabel) {
        _limitlabel = [[UILabel alloc]init];
        _limitlabel.text =@"任务总数：124/500";
        _limitlabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        _limitlabel.textColor = KColorFromRGB(0x999999);
        _limitlabel.textAlignment=NSTextAlignmentLeft;
        _limitlabel.hidden = NO;
    }
    return _limitlabel;
}

-(UILabel *)Tasktitlelabel
{
    if (!_Tasktitlelabel) {
        _Tasktitlelabel = [[UILabel alloc]init];
        _Tasktitlelabel.text =@"火币奖励：+10火币";
        _Tasktitlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        _Tasktitlelabel.textColor = KColorFromRGB(0x999999);
        _Tasktitlelabel.textAlignment=NSTextAlignmentLeft;
    }
    return _Tasktitlelabel;
}
-(UILabel *)statubtn
{
    if (!_statubtn) {
        _statubtn = [[UILabel alloc]init];
        _statubtn.text = @"去完成";
        _statubtn.backgroundColor = KColorFromRGB(kThemecolor);
          _statubtn.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
          _statubtn.textAlignment  =NSTextAlignmentCenter;
        _statubtn.textColor = KColorFromRGB(0xfffffff);
        
//        [_statubtn setTitle:@"去完成" forState:UIControlStateNormal];
       
        //    [self.statubtn setTitle:@"已完成" forState:UIControlStateDisabled];
//        [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xFF273F)] forState:UIControlStateNormal];
        // [_statubtn setBackgroundImage:[UIImage imageWithColor: KColorFromRGB(0xE0E0E0)] forState:UIControlStateDisabled];
//        _statubtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
//        _statubtn.titleLabel.textAlignment  =NSTextAlignmentCenter;
//        [_statubtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
//        [_statubtn addTarget:self action:@selector(butAct) forControlEvents:UIControlEventTouchUpInside];
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
        _moneylabel.text =@"(进度0/10)";
        _moneylabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        _moneylabel.textColor = KColorFromRGB(0x222222);
        _moneylabel.textAlignment=NSTextAlignmentRight;
        [self addSubview:_moneylabel];
    }
    return _moneylabel;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
   
    [self.statubtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(10));
        make.centerY.equalTo(self.bgview.mas_centerY).offset(kRealValue(0));
        make.width.mas_equalTo(kRealValue(74));
        make.height.mas_equalTo(kRealValue(34));
        
    }];
    ViewRadius(self.statubtn, kRealValue(17));
    
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgview.mas_left).offset(kRealValue(12));
        make.top.equalTo(self.bgview.mas_top).offset(kRealValue(12));
//         make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(80));
    }];
    
    [self.moneylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titlelabel.mas_right).offset(kRealValue(16));
        make.centerY.equalTo(self.titlelabel.mas_centerY).offset(kRealValue(0));
    }];
    
    [self.Tasktitlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(26));
        make.top.equalTo(self.titlelabel.mas_bottom).offset(kRealValue(8));
        
       
    }];
    
    [self.limitlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.Tasktitlelabel.mas_right).offset(kRealValue(16));
        make.centerY.equalTo(self.Tasktitlelabel.mas_centerY).offset(0);
       
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
