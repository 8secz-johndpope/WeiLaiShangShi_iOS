//
//  HomeproductCell.m
//  mohu
//
//  Created by 余浩 on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "HomeproductCell.h"


@implementation HomeproductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kBackGroudColor;
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
    self.cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancle setTitle:@"取消收藏" forState:UIControlStateNormal];
    self.cancle.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.cancle.backgroundColor = KColorFromRGBA(0x000000, 0.4);
    self.cancle.layer.cornerRadius =5;
    self.cancle.tag =self.tag;
    self.cancle.frame = CGRectMake(kScreenWidth - kRealValue(100), kRealValue(20), kRealValue(70), kRealValue(22));
    [self addSubview:self.cancle];
    UITapGestureRecognizer *Canceltap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelAction:)];
    [self.cancle addGestureRecognizer:Canceltap];
    self.cancle.hidden = YES;
//    [self.bgView addSubview:self.shangjiaBtn];
    
    self.clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(280))];
    self.clearView.backgroundColor = KColorFromRGBA(0xffffff, 0.7);
    self.clearView.hidden = YES;
    [self addSubview:self.clearView];
    
   
}


-(void)setProductModel:(MHProductModel *)ProductModel{
     _ProductModel = ProductModel;
     self.titleLabel.text = ProductModel.productName;
    
    
    if (ValidStr(ProductModel.productSmallImage)) {
         [self.img sd_setImageWithURL:[NSURL URLWithString:ProductModel.productSmallImage] placeholderImage:kGetImage(@"img_bitmap_long")];
    }else{
         [self.img sd_setImageWithURL:[NSURL URLWithString:ProductModel.productImage] placeholderImage:kGetImage(@"img_bitmap_long")];
    }
    self.pricelabel.text = [NSString stringWithFormat:@"¥ %@",ProductModel.retailPrice];
//    self.Originpricelabel.text =[NSString stringWithFormat:@"¥ %@",ProductModel.marketPrice] ;
    self.salenumlabel.text = [NSString stringWithFormat:@"已售%@件",ProductModel.sellCount];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",ProductModel.marketPrice] attributes:attribtDic];
    _Originpricelabel.attributedText = attribtStr;
    [_richLabel setAttributedText:[NSString stringWithFormat:@"赚 %@",ProductModel.marketPrice] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"c81f25"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(14)]}];
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
    
    //    if ([ProductModel.status integerValue] == 1) {
//        [_shangjiaBtn setTitle:@"下架" forState:UIControlStateNormal];
//    }else{
//        [_shangjiaBtn setTitle:@"上架" forState:UIControlStateNormal];
//    }
    
    if (self.isCollect) {
        if ([ProductModel.status isEqualToString:@"ACTIVE"]) {
            self.cancle.hidden= NO;
             self.clearView.hidden = YES;
        }else{
             self.clearView.hidden = NO;
             self.cancle.hidden= YES;
            _Buybtn.backgroundColor = KColorFromRGB(0xD6D7D6);
            _Buybtn.userInteractionEnabled = NO;
            _Buybtn.titleLabel.textColor = [UIColor whiteColor];
            [_Buybtn setTitle:@"已下架" forState:UIControlStateNormal];
        }
    }
    
    
}

-(void)cancelAction:(UITapGestureRecognizer *)sender
{
    MHLog(@"点击%ld",sender.view.tag);
    if (self.CancelAct) {
        self.CancelAct(sender.view.tag);
    }
//   
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
    
    [_richLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-kRealValue(17));
        make.left.mas_equalTo(_pricelabel.mas_right).offset(kRealValue(6));
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
        _img.image =kGetImage(@"poster_01");
       
//        _img.backgroundColor =kRandomColor;
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
        _salenumlabel.text = @"已售2345";
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


-(UILabel *)richLabel
{
    if (!_richLabel) {
        _richLabel = [[RichStyleLabel alloc]initWithFrame:CGRectZero];
        _richLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(11)];
        _richLabel.textColor =[UIColor colorWithHexString:@"c81f25"];
        
    }
    return _richLabel;
}




@end
