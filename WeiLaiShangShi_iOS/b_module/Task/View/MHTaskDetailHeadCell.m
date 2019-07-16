//
//  MHTaskDetailHeadCell.m
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTaskDetailHeadCell.h"

@implementation MHTaskDetailHeadCell
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
    self.headtitle = [[UILabel alloc]init];
    self.headtitle.text =@"金牌推手任务";
    self.headtitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    self.headtitle.textColor = KColorFromRGB(0x000000);
    self.headtitle.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.headtitle];
//    
//    self.lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(0), kRealValue(39), kScreenWidth , 1/kScreenScale)];
//    self.lineview.backgroundColor=  KColorFromRGB(0xF0F0F0);
//    [self addSubview:self.lineview];
//    
    
    self.savePic = [[UILabel alloc]init];
    self.savePic.userInteractionEnabled = YES;
    self.savePic.text = @"保存";
    self.savePic.textAlignment = NSTextAlignmentCenter;
    self.savePic.backgroundColor = KColorFromRGB(kThemecolor);
    self.savePic.textColor = KColorFromRGB(0xffffff);
   
    self.savePic.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [self addSubview:self.savePic];
    self.savePic.hidden  = YES;
    
    
    UITapGestureRecognizer *savpictap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(save)];
    [self.savePic addGestureRecognizer:savpictap];
}
-(void)save
{
    if (self.SaveAct) {
        self.SaveAct();
    }
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.headtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(16));
        make.centerY.equalTo(self.mas_centerY).offset(kRealValue(0));
        
    }];
    [self.savePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-kRealValue(16));
        make.centerY.equalTo(self.mas_centerY).offset(kRealValue(0));
        make.width.mas_equalTo(kRealValue(57));
        make.height.mas_equalTo(kRealValue(27));
    }];
    self.savePic.layer.masksToBounds = YES;
    self.savePic.layer.cornerRadius = 4;
    
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
