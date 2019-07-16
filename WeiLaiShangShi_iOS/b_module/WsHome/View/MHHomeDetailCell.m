//
//  MHHomeDetailCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/18.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHHomeDetailCell.h"

@implementation MHHomeDetailCell

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
    //    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgView];
    [self addSubview:self.imagebg];
    [self.bgView addSubview:self.img];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.pricelabel];
    [self.bgView addSubview:self.Originpricelabel];
    [self.bgView addSubview:self.salenumlabel];
    [self.bgView addSubview:self.Buybtn];
    [self.bgView addSubview:self.richLabel];
//    [self.bgView addSubview:self.shangjiaBtn];
    if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"] || ([GVUserDefaults standardUserDefaults].accessToken == nil)) {
        self.richLabel.hidden = YES;
        self.Originpricelabel.hidden = NO;
        self.pricelabel.textColor = [UIColor colorWithHexString:@"f54241"];
//        self.shangjiaBtn.hidden = YES;
    }else{
        self.richLabel.hidden = NO;
        self.Originpricelabel.hidden = YES;
        self.pricelabel.textColor = [UIColor colorWithHexString:@"000000"];
//        self.shangjiaBtn.hidden = NO;
    }
}


-(void)setProductModel:(MHProductModel *)ProductModel{
    
    _ProductModel = ProductModel;
    self.titleLabel.text = ProductModel.productName;
    if (ValidStr(ProductModel.productSmallImage)) {
        [self.img sd_setImageWithURL:[NSURL URLWithString:ProductModel.productSmallImage] placeholderImage:kGetImage(@"img_bitmap_white")];
    }else{
        [self.img sd_setImageWithURL:[NSURL URLWithString:ProductModel.productImage] placeholderImage:kGetImage(@"img_bitmap_white")];
    }
    self.pricelabel.text = [NSString stringWithFormat:@"¥ %@",ProductModel.retailPrice];
    self.salenumlabel.text = [NSString stringWithFormat:@"已售%@件",ProductModel.sellCount];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",ProductModel.marketPrice] attributes:attribtDic];
    _Originpricelabel.attributedText = attribtStr;
   [_richLabel setAttributedText:[NSString stringWithFormat:@"赚 %@",ProductModel.marketPrice] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"c81f25"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(14)]}];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(145));
        make.left.equalTo(self.mas_left).offset(kRealValue(10));
        make.right.equalTo(self.mas_right).offset(-kRealValue(10));
        make.top.mas_equalTo(self.mas_top).offset(0);
    }];
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(125));
        make.width.mas_equalTo(kRealValue(125));
        make.centerY.mas_equalTo(self.bgView);
         make.left.equalTo(self.bgView.mas_left).offset(kRealValue(10));
    }];
    
    [self.Buybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kRealValue(80));
        make.height.mas_equalTo(kRealValue(25));
        make.right.equalTo(self.bgView.mas_right).offset(-kRealValue(10));
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-kRealValue(15));
    }];
    
//    [self.shangjiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(kRealValue(56));
//        make.height.mas_equalTo(kRealValue(25));
//        make.right.mas_equalTo(self.Buybtn.mas_left).offset(-kRealValue(10));
//        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-kRealValue(15));
//    }];
//
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(kRealValue(10));
         make.right.equalTo(self.bgView.mas_right).offset(-kRealValue(10));
        make.top.equalTo(self.img.mas_top).offset(0);
    }];
    
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_img.mas_right).offset(kRealValue(10));
        make.top.mas_equalTo(_img.mas_top).offset(kRealValue(76));
    }];
    [_Originpricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_img.mas_bottom).offset(-kRealValue(10)); make.left.equalTo(_img.mas_right).offset(kRealValue(10));
    }];
    
    [_richLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
       make.bottom.mas_equalTo(_img.mas_bottom).offset(-kRealValue(5));
       make.left.equalTo(_img.mas_right).offset(kRealValue(10));
    }];
    
    
    
    [self.salenumlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_img.mas_right).offset(kRealValue(10));
        make.top.equalTo(_titleLabel.mas_bottom).offset(kRealValue(8));
    }];
    
    //
    ViewRadius(self.Buybtn, kRealValue(4));
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = kRealValue(5);
    
    
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
        _titleLabel.numberOfLines = 2;
        
        _titleLabel.textColor =[UIColor colorWithHexString:@"282828"];
        
    }
    return _titleLabel;
}


-(UILabel *)richLabel
{
    if (!_richLabel) {
        _richLabel = [[RichStyleLabel alloc]initWithFrame:CGRectZero];
        _richLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(11)];
        _richLabel.textColor =[UIColor colorWithHexString:@"c81f25"];
        
    }
    return _richLabel;
}

-(UILabel *)pricelabel
{
    if (!_pricelabel) {
        _pricelabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _pricelabel.font = [UIFont fontWithName:kPingFangMedium size:kRealValue(18)];
        _pricelabel.textColor =[UIColor colorWithHexString:@"f54241"];
        
    }
    return _pricelabel;
}
-(UILabel *)Originpricelabel
{
    if (!_Originpricelabel) {
        _Originpricelabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _Originpricelabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
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
        _salenumlabel.text = @"已售2345";
    }
    return _salenumlabel;
}

-(UIButton *)Buybtn
{
    if (!_Buybtn) {
        _Buybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Buybtn setBackgroundColor:[UIColor colorWithHexString:@"e20a0a"]];
//        [_Buybtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"ff6041"],[UIColor colorWithHexString:@"e81400"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(76), kRealValue(24))] forState:UIControlStateNormal];
        _Buybtn.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
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
//        [_shangjiaBtn addTarget:self action:@selector(changeState) forControlEvents:UIControlEventTouchUpInside];
//        [_shangjiaBtn setTitleColor:[UIColor colorWithHexString:@"404040"] forState:UIControlStateNormal];
//        ViewBorderRadius(_shangjiaBtn, kRealValue(4), 1/kScreenScale, [UIColor colorWithHexString:@"404040"]);
//
//    }
//    return _shangjiaBtn;
//}





@end
