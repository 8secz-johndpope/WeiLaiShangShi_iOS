//
//  MHTaskCell.m
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTaskCell.h"

@implementation MHTaskCell
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
    self.titlelabel = [[UILabel alloc]init];
    self.titlelabel.text =@"[微广]水果特卖任务水果特卖任务";
    self.titlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.titlelabel.textColor = KColorFromRGB(0x000000);
    self.titlelabel.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.titlelabel];
    
    self.statubtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.statubtn setTitle:@"去完成" forState:UIControlStateNormal];
    self.statubtn.backgroundColor = KColorFromRGB(0xFF3344);
    self.statubtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.statubtn.titleLabel.textAlignment  =NSTextAlignmentCenter;
    [self addSubview:self.statubtn];
    
    
    self.moneylabel = [[UILabel alloc]init];
    self.moneylabel.text =@"奖励4元";
    self.moneylabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.moneylabel.textColor = KColorFromRGB(0xFF0116);
    self.moneylabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.moneylabel];
    
    self.lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(0), kRealValue(43), kScreenWidth , 1/kScreenScale)];
    self.lineview.backgroundColor=  KColorFromRGB(0xF0F0F0);
    [self addSubview:self.lineview];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
   
    [self.statubtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-kRealValue(16));
        make.centerY.equalTo(self.mas_centerY).offset(kRealValue(0));
        make.width.mas_equalTo(kRealValue(60));
        make.height.mas_equalTo(kRealValue(24));
        
    }];
    self.statubtn.layer.cornerRadius = kRealValue(12);
    [self.moneylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.statubtn.mas_left).offset(-kRealValue(16));
        make.centerY.equalTo(self.mas_centerY).offset(kRealValue(0));
    }];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(16));
        make.centerY.equalTo(self.mas_centerY).offset(kRealValue(0));
        make.right.equalTo(self.moneylabel.mas_left).offset(-kRealValue(10));
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
