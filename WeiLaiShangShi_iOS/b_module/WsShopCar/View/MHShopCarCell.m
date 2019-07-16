//
//  MHShopCarCell.m
//  mohu
//
//  Created by 余浩 on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHShopCarCell.h"
#import "MHShopCarCountView.h"
#import "MHShopCarProductModel.h"
@interface  MHShopCarCell()
@property (nonatomic, strong) UIButton *productSelectButton;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *productNameLable;
@property (nonatomic, strong) UILabel *productSizeLable;
@property (nonatomic, strong) UILabel *productPriceLable;
@property (nonatomic, strong) MHShopCarCountView *shopcartCountView;
@property (nonatomic, strong) UILabel *productNumLable;
@property (nonatomic, strong) UIImageView *shopcartBgView;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, assign) BOOL isEditable;
@property (nonatomic, strong) UIView *deletebg;
@end


@implementation MHShopCarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createview];

    }
    return self;
}
- (void)configureShopcartCellWithProductURL:(NSString *)productURL productName:(NSString *)productName productSize:(NSString *)productSize productPrice:(NSString *)productPrice productCount:(NSInteger)productCount productStock:(NSInteger)productStock productSelected:(BOOL)productSelected  isEdit:(BOOL)isEdit {
    isEdit = YES;
    self.productNameLable.text = productName;
    self.productSizeLable.text = productSize;
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:productURL] placeholderImage:nil];
    self.productPriceLable.text = [NSString stringWithFormat:@"￥%@", productPrice];
    self.productSelectButton.selected = productSelected;
    
    if (isEdit) {
        self.shopcartCountView.hidden = NO;
        self.productNumLable.hidden = YES;
         [self.shopcartCountView configureShopcartCountViewWithProductCount:productCount productStock:productStock];
    }else{
        self.shopcartCountView.hidden = YES;
         self.productNumLable.hidden = NO;
        self.productNumLable.text = [NSString stringWithFormat:@"x%ld", productCount];
    }
   
}



-(void)createview
{

    self.contentView.backgroundColor = KColorFromRGB(0xF1F2F1);
    [self.contentView addSubview:self.shopcartBgView];
    
    self.viewline = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(11), 0, kRealValue(335), 1/kScreenScale)];
    self.viewline.backgroundColor = KColorFromRGB(0xF1F2F1);
    [self.shopcartBgView addSubview:self.viewline];
    
    [self.shopcartBgView addSubview:self.productSelectButton];
    [self.shopcartBgView addSubview:self.productImageView];
    [self.shopcartBgView addSubview:self.productNameLable];
    [self.shopcartBgView addSubview:self.productSizeLable];
    [self.shopcartBgView addSubview:self.productPriceLable];
    [self.shopcartBgView addSubview:self.shopcartCountView];
    [self.shopcartBgView addSubview:self.productNumLable];
    [self.shopcartBgView addSubview:self.topLineView];
//    self.productImageView.backgroundColor = kRandomColor;
   
   
    

    
    
    
}


- (void)layoutSubviews {
    [super layoutSubviews];

    [self.shopcartBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.left.equalTo(self.mas_left).offset(kRealValue(10));
        make.right.equalTo(self.mas_right).offset(kRealValue(0));
        make.height.mas_equalTo(self.mas_height);
    }];
    [self.productSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView).offset(kRealValue(11));
        make.centerY.equalTo(self.shopcartBgView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRealValue(23), kRealValue(100)));
    }];
    
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView).offset(kRealValue(44));
        make.centerY.equalTo(self.shopcartBgView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRealValue(100), kRealValue(100)));
    }];
    self.productImageView.layer.borderColor = [[UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f] CGColor];
    self.productImageView.layer.borderWidth = 0.5;
    self.productImageView.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
    self.productImageView.alpha = 1;
    
    
    [self.productNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(kRealValue(10));
        make.top.equalTo(self.shopcartBgView).offset(kRealValue(15));
        make.right.equalTo(self.shopcartBgView).offset(-kRealValue(18));
    }];
    
    
    [self.productSizeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(kRealValue(10));
        make.top.equalTo(self.productNameLable.mas_bottom).offset(kRealValue(3));
       
    }];
    
    [self.productPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(kRealValue(10));
         make.bottom.equalTo(self.productImageView.mas_bottom).offset(-kRealValue(8));
       
    }];
    
    [self.shopcartCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shopcartBgView.mas_right).offset(-kRealValue(7));
        make.centerY.equalTo(self.productPriceLable.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRealValue(97), kRealValue(29)));
    }];
    
    [self.productNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shopcartBgView.mas_right).offset(-10);
        make.centerY.equalTo(self.shopcartCountView);
    }];
    
   
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView).offset(kRealValue(50));
        make.top.right.equalTo(self.shopcartBgView);
        make.height.equalTo(@0);
    }];
}
-(void)productSelectButtonAction
{
    self.productSelectButton.selected = !self.productSelectButton.isSelected;
    if (self.shopCarCellBlock) {
        self.shopCarCellBlock(self.productSelectButton.selected);
    }
}
#pragma mark lazy
- (UIButton *)productSelectButton
{
    if(_productSelectButton == nil)
    {
        _productSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_productSelectButton setImage:kGetImage(@"check_off") forState:UIControlStateNormal];
        [_productSelectButton setImage:kGetImage(@"check_on") forState:UIControlStateSelected];
        [_productSelectButton addTarget:self action:@selector(productSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productSelectButton;
}

- (UIImageView *)productImageView {
    if (_productImageView == nil){
        _productImageView = [[UIImageView alloc] init];
    }
    return _productImageView;
}

- (UILabel *)productNameLable {
    if (_productNameLable == nil){
        _productNameLable = [[UILabel alloc] init];
        _productNameLable.numberOfLines = 2;
        _productNameLable.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        _productNameLable.textColor = KColorFromRGB(0x282828);
    }
    return _productNameLable;
}

- (UILabel *)productSizeLable {
    if (_productSizeLable == nil){
        _productSizeLable = [[UILabel alloc] init];
        _productSizeLable.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(10)];
        _productSizeLable.textColor = KColorFromRGB(0x989898);
    }
    _productSizeLable.userInteractionEnabled =YES;
    return _productSizeLable;
}
-(void)ShowSize:(UITapGestureRecognizer *)sender{
    if (self.shopCarCellShowSizeBlock) {
        self.shopCarCellShowSizeBlock(@"11");
    }
}

- (UILabel *)productPriceLable {
    if (_productPriceLable == nil){
        _productPriceLable = [[UILabel alloc] init];
        _productPriceLable.font = [UIFont systemFontOfSize:14];
        _productPriceLable.textColor = KColorFromRGB(0xf74b16);
    }
    return _productPriceLable;
}

- (MHShopCarCountView *)shopcartCountView {
    if (_shopcartCountView == nil){
        _shopcartCountView = [[MHShopCarCountView alloc] init];
        __weak __typeof(self) weakSelf = self;
        _shopcartCountView.shopcarCountViewEditBlock  = ^(NSInteger count){
            if (weakSelf.shopCarCellEditBlock) {
                weakSelf.shopCarCellEditBlock(count);
            }
        };
       
    }
    return _shopcartCountView;
}

- (UILabel *)productNumLable {
    if (_productNumLable == nil){
        _productNumLable = [[UILabel alloc] init];
        _productNumLable.font = [UIFont systemFontOfSize:13];
        _productNumLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    }
    return _productNumLable;
}

- (UIView *)shopcartBgView {
    if (_shopcartBgView == nil){
        _shopcartBgView = [[UIImageView alloc] init];
        _shopcartBgView.backgroundColor = [UIColor whiteColor];
        _shopcartBgView.userInteractionEnabled = YES;
        _shopcartBgView.backgroundColor = [UIColor whiteColor];
//        _shopcartBgView.image = kGetImage(@"shadow_produce");
    }
    return _shopcartBgView;
}

- (UIView *)topLineView {
    if (_topLineView == nil){
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _topLineView;
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
