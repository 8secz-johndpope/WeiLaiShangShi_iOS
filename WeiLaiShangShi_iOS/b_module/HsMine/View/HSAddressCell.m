//
//  HSAddressCell.m
//  HSKD
//
//  Created by yuhao on 2019/3/4.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSAddressCell.h"
#import "MHMineuserAddress.h"
@implementation HSAddressCell
-(void)createCellWithModel:(MHMineuserAddress *)model
{
    self.ReceviceName.text = [NSString stringWithFormat:@"收货人：%@",model.contact];
    self.phoneLabel.text =[NSString stringWithFormat:@"%@",model.phone];
    self.revicedetail.text = [NSString stringWithFormat:@"%@ %@ %@ %@",model.province,model.city, model.area, model.detail];
    if ([[ NSString stringWithFormat:@"%@", model.state] isEqualToString:@"1"] ) {
        self.defaultlabel.hidden = NO;
    }else{
        self.defaultlabel.hidden = YES;
    }
}
-(void)setAdressModel:(MHMineuserAddress *)adressModel
{
    _adressModel = adressModel;
    self.ReceviceName.text = [NSString stringWithFormat:@"%@",adressModel.contact];
    self.phoneLabel.text =[NSString stringWithFormat:@"%@",adressModel.phone];
    self.revicedetail.text = [NSString stringWithFormat:@"%@ %@ %@ %@",adressModel.province,adressModel.city, adressModel.area, adressModel.detail];
    if ([[ NSString stringWithFormat:@"%@", adressModel.state] isEqualToString:@"1"] ) {
        self.defaultlabel.hidden = NO;
    }else{
         self.defaultlabel.hidden = YES;
    }
    
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
   
    
    [self addSubview:self.ReceviceName];
    [self addSubview:self.defaultlabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.reviceTitle];
    [self addSubview:self.revicedetail];
    [self addSubview:self.rightImage];
    [self.ReceviceName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(15));
        make.top.equalTo(self.mas_top).offset(kRealValue(13));
    }];
    [self.defaultlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ReceviceName.mas_right).offset(kRealValue(5));
        make.centerY.equalTo(self.ReceviceName.mas_centerY).offset(kRealValue(0));
        make.width.mas_equalTo(kRealValue(32));
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(kRealValue(-50));
        make.centerY.equalTo(self.ReceviceName.mas_centerY).offset(kRealValue(0));
    }];
    [self.reviceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(15));
        make.top.equalTo(self.ReceviceName.mas_bottom).offset(kRealValue(8));
    }];
    [self.revicedetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reviceTitle.mas_right).offset(kRealValue(5));
        make.top.equalTo(self.ReceviceName.mas_bottom).offset(kRealValue(8));
        make.width.mas_equalTo(kRealValue(240));
    }];
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(kRealValue(-10));
        make.centerY.equalTo(self.mas_centerY).offset(kRealValue(0));
        make.width.height.mas_equalTo(kRealValue(22));
    }];
    
    self.lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(10),kRealValue(88) , kScreenWidth - kRealValue(20), 1/kScreenScale)];
    self.lineview.backgroundColor = KColorFromRGB(0xE2E2E2);
    [self addSubview:self.lineview];
    
    _defaultlabel.layer.masksToBounds = YES;
    _defaultlabel.layer.cornerRadius = kRealValue(2);
    
    
    
    UIView *AdressView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-kRealValue(40), kRealValue(88))];
    AdressView.backgroundColor = [UIColor clearColor];
    [self addSubview:AdressView];
    
    UIView *AdressView2  = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-kRealValue(40), 0, kRealValue(40), kRealValue(88))];
    AdressView2.backgroundColor = [UIColor clearColor];
    [self addSubview:AdressView2];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1Act)];
    [AdressView addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2Act)];
    [AdressView2 addGestureRecognizer:tap2];
    
}
-(void)tap1Act
{
    if (self.Tap1) {
        self.Tap1();
    }
//    MHLog(@"11");
   
}
-(void)tap2Act
{
    if (self.Tap2) {
        self.Tap2();
    }
//     MHLog(@"12");
    
}
-(UILabel *)ReceviceName
{
    if (!_ReceviceName) {
        _ReceviceName = [[UILabel alloc]init];
        _ReceviceName.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        _ReceviceName.textColor = KColorFromRGB(0x222222);
        _ReceviceName.text = @"收货人： 张大人";
        _ReceviceName.textAlignment = NSTextAlignmentLeft;
    }
    return _ReceviceName;
}
-(UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        _phoneLabel.textColor = KColorFromRGB(0x222222);
        _phoneLabel.text = @"15956057842";
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _phoneLabel;
}
-(UILabel *)reviceTitle
{
    if (!_reviceTitle) {
        _reviceTitle = [[UILabel alloc]init];
        _reviceTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _reviceTitle.textColor = KColorFromRGB(0x222222);
        _reviceTitle.text = @"收货地址：";
        _reviceTitle.textAlignment = NSTextAlignmentLeft;
    }
    return _reviceTitle;
}
-(UILabel *)revicedetail
{
    if (!_revicedetail) {
        _revicedetail = [[UILabel alloc]init];
        _revicedetail.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _revicedetail.textColor = KColorFromRGB(0x222222);
        _revicedetail.text = @"安徽省合肥市蜀山区莲花社区管理委员会翠微路与翡翠路交口百乐门门小区8号楼808室";
        _revicedetail.textAlignment = NSTextAlignmentLeft;
        _revicedetail.numberOfLines = 0;
    }
    return _revicedetail;
}
-(UILabel *)defaultlabel
{
    if (!_defaultlabel) {
        _defaultlabel = [[UILabel alloc]init];
        _defaultlabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        _defaultlabel.textColor = KColorFromRGB(0xFFFFFF);
        _defaultlabel.text = @"默认";
       
        _defaultlabel.backgroundColor = KColorFromRGB(0xFA3E3E);
        _defaultlabel.textAlignment = NSTextAlignmentCenter;
    }
    return _defaultlabel;
}
-(UIImageView *)rightImage
{
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc]init];
//        _rightImage.backgroundColor = kRandomColor;
        _rightImage.image = kGetImage(@"shop_redact_iocn"); 
    }
    return _rightImage;
}
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index {
    [super insertSubview:view atIndex:index];
    
    if ([view isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
        view.top = 10;
        view.height = self.height - 10;
        
        for (UIButton *btn in view.subviews) {
            
            if ([btn isKindOfClass:[UIButton class]]) {
                
                [btn setBackgroundColor:[UIColor orangeColor]];
                
                [btn setTitle:nil forState:UIControlStateNormal];
                
                UIImage *img = kGetImage(@"hsdelete");
                [btn setImage:img forState:UIControlStateNormal];
                [btn setImage:img forState:UIControlStateHighlighted];
                
                [btn setTintColor:[UIColor whiteColor]];
            }
        }
    }
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
