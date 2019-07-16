//
//  MHProductCell.m
//  wgts
//
//  Created by yuhao on 2018/11/7.
//  Copyright © 2018 mhyouping. All rights reserved.
//

#import "MHProductCell.h"


@implementation MHProductCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kBackGroudColor;
        [self createview];
    }
    return self;
}

-(void)createview{

    [self addSubview:self.bgView];
    [self.bgView addSubview:self.img];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.pricelabel];
    [self.bgView addSubview:self.Originpricelabel];
    [self.bgView addSubview:self.salenumlabel];
    [self.bgView addSubview:self.Buybtn];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(268));
        make.width.mas_equalTo(kScreenWidth);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(0);
    }];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(175));
        make.width.mas_equalTo(kScreenWidth);
        make.centerX.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.bgView.mas_top);
    }];
    
    [self.Buybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kRealValue(80));
        make.height.mas_equalTo(kRealValue(25));
        make.right.mas_equalTo(self.bgView.mas_right).offset(-kRealValue(15));
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-kRealValue(15));
    }];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kRealValue(15));
        make.right.mas_equalTo(-kRealValue(15));
        make.top.mas_equalTo(self.img.mas_bottom).offset(kRealValue(10));
    }];
    
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(kRealValue(15));
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-kRealValue(15));
    }];
    [_Originpricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-kRealValue(17));
        make.left.mas_equalTo(_pricelabel.mas_right).offset(kRealValue(6));
    }];
    
    [self.salenumlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(kRealValue(15));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kRealValue(4));
    }];
    
    
    
    
    ViewRadius(self.Buybtn, 4);
    
    
    
}
-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor =[UIColor whiteColor];
    }
    return _bgView;
}
-(UIImageView *)img
{
    if (!_img) {
        _img = [[UIImageView alloc]init];
    }
    return _img;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
        _titleLabel.textColor =[UIColor blackColor];
        
    }
    return _titleLabel;
}
-(UILabel *)pricelabel
{
    if (!_pricelabel) {
        _pricelabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _pricelabel.font = [UIFont fontWithName:kPingFangMedium size:kRealValue(16)];
        _pricelabel.textColor =[UIColor colorWithHexString:@"f54241"];
        
    }
    return _pricelabel;
}
-(UILabel *)Originpricelabel
{
    if (!_Originpricelabel) {
        _Originpricelabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _Originpricelabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(11)];
        _Originpricelabel.textColor =[UIColor colorWithHexString:@"858585"];
        //        _Originpricelabel.numberOfLines =1;
        //        _Originpricelabel.text = @"¥337";
        
        
    }
    return _Originpricelabel;
}
-(UILabel *)salenumlabel
{
    if (!_salenumlabel) {
        _salenumlabel = [[UILabel alloc]init];
        _salenumlabel.font = [UIFont systemFontOfSize:kRealValue(11)];
        _salenumlabel.textColor =[UIColor colorWithHexString:@"858585"];
        _salenumlabel.text = @"";
    }
    return _salenumlabel;
}

-(UIButton *)Buybtn
{
    if (!_Buybtn) {
        _Buybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //        [_Buybtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"ff6041"],[UIColor colorWithHexString:@"e81400"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(76), kRealValue(24))] forState:UIControlStateNormal];
        _Buybtn.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _Buybtn.backgroundColor = KColorFromRGB(0xEB2109);
        _Buybtn.userInteractionEnabled = NO;
        [_Buybtn setTitle:@"立即购买" forState:UIControlStateNormal];
    }
    return _Buybtn;
}


//-(UIButton *)shangjiaBtn
//{
//    if (!_shangjiaBtn) {
//        _shangjiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_shangjiaBtn setBackgroundColor:[UIColor whiteColor]];
//        _shangjiaBtn.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
//         [_shangjiaBtn addTarget:self action:@selector(changeState) forControlEvents:UIControlEventTouchUpInside];
//        [_shangjiaBtn setTitleColor:[UIColor colorWithHexString:@"404040"] forState:UIControlStateNormal];
//        ViewBorderRadius(_shangjiaBtn, kRealValue(4), 1/kScreenScale, [UIColor colorWithHexString:@"404040"]);
//        [_shangjiaBtn setTitle:@"上架" forState:UIControlStateNormal];
//    }
//    return _shangjiaBtn;
//}




-(void)creatModel:(MHShopModel *)model{
    
    _titleLabel.text = model.productName;
    _salenumlabel.text = @"";
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.productSmallImage] placeholderImage:kGetImage(@"img_bitmap_long")];
    self.pricelabel.text = [NSString stringWithFormat:@"¥ %@",model.retailPrice];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",model.marketPrice] attributes:attribtDic];
    _Originpricelabel.attributedText = attribtStr;

}
@end
