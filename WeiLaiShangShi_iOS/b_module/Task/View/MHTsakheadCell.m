
//
//  MHTsakheadCell.m
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTsakheadCell.h"

@implementation MHTsakheadCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = KColorFromRGB(0xF2F3F5);
        [self createview];
    }
    return self;
}
-(void)createview
{
    self.headtitle = [[UILabel alloc]init];
    self.headtitle.text =@"金牌推手任务";
    self.headtitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    self.headtitle.textColor = KColorFromRGB(0x000000);
    self.headtitle.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.headtitle];
    
    self.headprosess = [[UILabel alloc]init];
    self.headprosess.text =@"今日可领任务次数(2/2)";
    self.headprosess.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.headprosess.textColor = KColorFromRGB(0x6E6E6E);
    self.headprosess.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.headprosess];
    
    
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.headtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(16));
        make.centerY.equalTo(self.mas_centerY).offset(kRealValue(0));
        
    }];
    [self.headprosess mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-kRealValue(16));
        make.centerY.equalTo(self.mas_centerY).offset(kRealValue(0));
        
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
