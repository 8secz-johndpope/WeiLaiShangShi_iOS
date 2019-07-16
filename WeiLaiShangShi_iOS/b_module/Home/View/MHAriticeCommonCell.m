//
//  MHAriticeCommonCell.m
//  wgts
//
//  Created by yuhao on 2018/11/7.
//  Copyright © 2018 mhyouping. All rights reserved.
//

#import "MHAriticeCommonCell.h"

@implementation MHAriticeCommonCell
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
   self.bigimage = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(10), kRealValue(90) , kRealValue(90))];
//    self.bigimage.backgroundColor = kRandomColor;
    self.bigimage.layer.masksToBounds = YES;
    self.bigimage.layer.cornerRadius = kRealValue(5);
    [self addSubview:self.bigimage];
    
    self.introdeslabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(122), kRealValue(10), kScreenWidth - kRealValue(122), kRealValue(50))];
    self.introdeslabel.text = @"LELIFT香奈儿升级版修护眼部护理套装";
    self.introdeslabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    self.introdeslabel.textAlignment =  NSTextAlignmentLeft;
    self.introdeslabel.textColor = KColorFromRGB(0x000000);
    self.introdeslabel.numberOfLines = 2;
    [self addSubview:self.introdeslabel];
    
    self.authorlabel = [[UILabel alloc]init];
    self.authorlabel.text = @"微广运营团队";
    self.authorlabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    self.authorlabel.textAlignment =  NSTextAlignmentLeft;
    self.authorlabel.textColor = KColorFromRGB(0x999999);
    self.authorlabel.numberOfLines = 1;
    [self addSubview:self.authorlabel];
    [self.authorlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bigimage.mas_right).offset(kRealValue(16));
        make.bottom.equalTo(self.bigimage.mas_bottom).offset(-kRealValue(0));
    }];
    
    self.publishtimelabel = [[UILabel alloc]init];
    self.publishtimelabel.text = @"2018-11-26";
    self.publishtimelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    self.publishtimelabel.textAlignment =  NSTextAlignmentLeft;
    self.publishtimelabel.textColor = KColorFromRGB(0x999999);
    self.publishtimelabel.numberOfLines = 1;
    [self addSubview:self.publishtimelabel];
    [self.publishtimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-kRealValue(16));
        make.bottom.equalTo(self.bigimage.mas_bottom).offset(-kRealValue(0));
    }];
    
    
    
    
    
    
    self.lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(108), kScreenWidth - kRealValue(32), 1/kScreenScale)];
    self.lineview.backgroundColor=  KColorFromRGB(0xF0F0F0);
    [self addSubview:self.lineview];
    
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
