//
//  MHProdesCell.m
//  wgts
//
//  Created by yuhao on 2018/11/9.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHProdesCell.h"

@implementation MHProdesCell
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
    UIView *linebg2 =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,  kRealValue(10))];
    linebg2.backgroundColor = KColorFromRGB(0xF1F3F4);
    //    linebg.backgroundColor = [UIColor redColor];
    [self addSubview:linebg2];
    
    self.labeltitle1 = [[UILabel alloc]init];
    self.labeltitle1.text = @"商品简介";
    self.labeltitle1.textColor = KColorFromRGB(0x000000);
    self.labeltitle1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [self addSubview:self.labeltitle1];
    
    
    self.labeldetail1 = [[UILabel alloc]init];
    self.labeldetail1.text = @"蕴藏在圆形瓶身中的花果香调香水。柔美、温婉的开瓶香气引领你沉醉于幸福与幸运的环绕中。一场嗅觉的香氛邂逅。 ";
    self.labeldetail1.textColor = KColorFromRGB(0x333333);
    //    labeldetail1.backgroundColor= kRandomColor;
    self.labeldetail1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    [self addSubview:self.labeldetail1];
    //
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.labeltitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(16));
        make.top.equalTo(self.mas_top).offset(kRealValue(25));
        make.width.mas_equalTo(kRealValue(60));
        make.height.mas_equalTo(kRealValue(20));
    }];
    self.labeldetail1.numberOfLines = 0;

    [self.labeldetail1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labeltitle1.mas_right).offset(kRealValue(19));
//        make.top.equalTo(self.mas_top).offset(kRealValue(25));
        make.centerY.equalTo(self.labeltitle1.mas_centerY).offset(0);
        //        make.right.equalTo(self.activityScroll.mas_right).offset(16);
        make.width.mas_equalTo(kRealValue(264));
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
