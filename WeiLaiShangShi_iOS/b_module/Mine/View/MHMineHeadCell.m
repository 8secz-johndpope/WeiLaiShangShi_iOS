//
//  MHMineHeadCell.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineHeadCell.h"

@implementation MHMineHeadCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createview];
        
    }
    return self;
}
-(void)createview
{
    [self addSubview:self.bgimageview];
    [self.bgimageview addSubview:self.bgimageSmallview];
    [self.bgimageSmallview addSubview:self.headimageview];
    [self.bgimageSmallview addSubview:self.username];
    [self.bgimageSmallview addSubview:self.MistakeInfo];
    [self.bgimageSmallview addSubview:self.userleverImage];
    [self.bgimageSmallview addSubview:self.userlever];
    [self.bgimageSmallview addSubview:self.superVipImage];
    self.headimageview.frame = CGRectMake(kRealValue(15), kRealValue(20), kRealValue(56), kRealValue(56));
    ViewBorderRadius(self.headimageview, kRealValue(28), 1, [UIColor whiteColor]);
    [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headimageview.mas_right).offset(kRealValue(10));
        make.top.equalTo(self.bgimageSmallview.mas_top).offset(kRealValue(25));
        make.height.mas_equalTo(kRealValue(20));
    }];
    
   
    [self.MistakeInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.username.mas_right).offset(kRealValue(10));
        make.top.equalTo(self.bgimageSmallview.mas_top).offset(kRealValue(25));
        make.height.mas_equalTo(kRealValue(20));
        make.width.mas_equalTo(kRealValue(60));
    }];
    self.MistakeInfo.hidden = YES;
    self.MistakeInfo.layer.masksToBounds = YES;
     self.MistakeInfo.layer.cornerRadius = kRealValue(10);
    [self.userleverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headimageview.mas_right).offset(kRealValue(10));
        make.top.equalTo(self.username.mas_bottom).offset(kRealValue(10));
        make.width.mas_equalTo(kRealValue(12));
        make.height.mas_equalTo(kRealValue(12));
    }];
    [self.userlever mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userleverImage.mas_right).offset(kRealValue(5));
        make.top.equalTo(self.username.mas_bottom).offset(kRealValue(10));
        make.width.mas_equalTo(kRealValue(60));
        make.height.mas_equalTo(kRealValue(12));
       
    }];
    
    [self.superVipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.username.mas_bottom).offset(kRealValue(8));
        make.width.mas_equalTo(kRealValue(48));
        make.height.mas_equalTo(kRealValue(18));
        make.left.equalTo(self.userlever.mas_right).offset(kRealValue(0));
    }];
    
    
    
    UIImageView *image = [[UIImageView alloc]init];
    image.image = kGetImage(@"ic_public_more");
    [self.bgimageSmallview addSubview:image];

    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgimageSmallview.mas_right).offset(-kRealValue(16));
        make.centerY.equalTo(self.bgimageSmallview.mas_centerY);
        make.width.mas_equalTo(kRealValue(25));
        make.height.mas_equalTo(kRealValue(25));
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    label.textColor = KColorFromRGB(0x666666);
    label.textAlignment = NSTextAlignmentRight;
    label.text =@"个人资料";
    [self.bgimageSmallview addSubview:label];

    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(image.mas_left).offset(kRealValue(5));
        make.centerY.equalTo(self.bgimageSmallview.mas_centerY);
        make.width.mas_equalTo(kRealValue(60));
        make.height.mas_equalTo(kRealValue(25));
    }];
    
    
    self.lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(0), kRealValue(95) +kStatusBarHeight, kScreenWidth , 1/kScreenScale)];
    self.lineview.backgroundColor=  KColorFromRGB(0xF0F0F0);
    [self addSubview:self.lineview];
    
}
-(UIImageView *)bgimageview
{
    if (!_bgimageview) {
        _bgimageview = [[UIImageView alloc]init];
        _bgimageview.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(97));
//        _bgimageview.image= kGetImage(@"back_shadow_my_head");
//         _bgimageview.backgroundColor = kRandomColor;
    }
    return _bgimageview;
}
-(UIImageView *)bgimageSmallview
{
    if (!_bgimageSmallview) {
        _bgimageSmallview = [[UIImageView alloc]init];
        _bgimageSmallview.frame = CGRectMake(kRealValue(16), kStatusBarHeight, kScreenWidth- kRealValue(16), kRealValue(97));
       // _bgimageSmallview.image= kGetImage(@"back_function_my_head");
    }
    return _bgimageSmallview;
}
-(UIImageView *)headimageview
{
    if (!_headimageview) {
        _headimageview = [[UIImageView alloc]init];
        _headimageview.image = kGetImage(@"icon-1024");
//        _headimageview.backgroundColor = kRandomColor;
    }
    return _headimageview;
}
-(UIImageView *)userleverImage
{
    if (!_userleverImage) {
        _userleverImage = [[UIImageView alloc]init];
//        _userleverImage.backgroundColor = kRandomColor;
    }
    return _userleverImage;
}
-(UIImageView *)superVipImage
{
    if (!_superVipImage) {
        _superVipImage = [[UIImageView alloc]init];
        _superVipImage.hidden =YES;
        //        _userleverImage.backgroundColor = kRandomColor;
    }
    return _superVipImage;
}
-(UILabel *)username
{
    if (!_username) {
        _username = [[UILabel alloc]init];
        _username.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _username.textColor = KColorFromRGB(0x000000);
        _username.textAlignment = NSTextAlignmentLeft;
//        _username.text =@"谁喊痛任凭眼泪一直流";
    }
    return _username;
}
-(UILabel *)userlever
{
    if (!_userlever) {
        _userlever = [[UILabel alloc]init];
        _userlever.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _userlever.textColor = KColorFromRGB(0x666666);
        _userlever.textAlignment = NSTextAlignmentLeft;
//        _userlever.text =@"微广会员";
    }
    return _userlever;
}
-(UILabel *)MistakeInfo
{
    if (!_MistakeInfo) {
        _MistakeInfo = [[UILabel alloc]init];
        _MistakeInfo.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _MistakeInfo.textColor = KColorFromRGB(0xFC4A57);
        _MistakeInfo.textAlignment = NSTextAlignmentCenter;
        _MistakeInfo.text =@"违规用户";
        _MistakeInfo.backgroundColor = KColorFromRGB(0xFDC6CC);
    }
    return _MistakeInfo;
}


@end
