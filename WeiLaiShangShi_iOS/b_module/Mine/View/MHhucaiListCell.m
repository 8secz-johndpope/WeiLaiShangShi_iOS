


//
//  MHhucaiListCell.m
//  mohu
//
//  Created by yuhao on 2018/10/9.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHhucaiListCell.h"

@implementation MHhucaiListCell

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
    [self addSubview:self.headimage];
    [self addSubview:self.username];
    [self addSubview:self.acttime];
    [self.headimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.width.height.mas_equalTo(kRealValue(32));
        make.left.equalTo(self.mas_left).offset(kRealValue(15));
    }];
    self.headimage.layer.masksToBounds = YES;
    self.headimage.layer.cornerRadius = kRealValue(16);
    
    [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.left.equalTo(self.headimage.mas_right).offset(kRealValue(15));
    }];
    [self.acttime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.right.equalTo(self.mas_right).offset(kRealValue(-16));
    }];
    
    self.lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(0), kRealValue(60), kScreenWidth , 1/kScreenScale)];
    self.lineview.backgroundColor=  KColorFromRGB(0xF0F0F0);
    [self addSubview:self.lineview];
    
}
-(UIImageView *)headimage
{
    if (!_headimage) {
        _headimage = [[UIImageView alloc]init];
//        _headimage.backgroundColor =kRandomColor;
    }
    return _headimage;
}
-(UILabel *)username
{
    if (!_username) {
        
        _username = [[UILabel alloc]init];
        _username.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        _username.textColor =[UIColor colorWithHexString:@"#222222"];
        _username.text =@"长情****不仄言";
    }
    return _username;
}
-(UILabel *)acttime
{
    if (!_acttime) {
        
        _acttime = [[UILabel alloc]init];
        _acttime.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _acttime.textColor =[UIColor colorWithHexString:@"#999999"];
        _acttime.text =@"07/29 08:53";
    }
    return _acttime;
}


@end
