//
//  MHShopCarHeadView.m
//  mohu
//
//  Created by 余浩 on 2018/9/21.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHShopCarHeadView.h"

@interface MHShopCarHeadView ()

@property (nonatomic, strong) UIView *shopcartHeaderBgView;
@property (nonatomic, strong) UIButton *allSelectButton;
@property (nonatomic, strong) UILabel *brandLable;
@end;
@implementation MHShopCarHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {

    [self addSubview:self.shopcartHeaderBgView];
    
    UIView *viewline = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(10), kRealValue(0),  kScreenWidth-kRealValue(20), kRealValue(10))];
    viewline.backgroundColor = KColorFromRGB(0xF0F1F0);
    [self addSubview:viewline];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(10), kRealValue(10), kScreenWidth-kRealValue(20), kRealValue(35))];
    view1.backgroundColor = [UIColor whiteColor] ;
    [self addSubview:view1];
    [view1 addSubview:self.allSelectButton];
    [self.allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1.mas_left).offset(kRealValue(10));
        make.centerY.equalTo(view1.mas_centerY).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
    }];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(35), kScreenWidth, kRealValue(30))];
    view2.userInteractionEnabled = YES;
    [self addSubview:view2];
    
    _leftImageView = [[UIImageView alloc] init];
//    _leftImageView.backgroundColor = kRandomColor;
    _leftImageView.layer.masksToBounds = YES;
    _leftImageView.layer.cornerRadius = kRealValue(6);
    //        [_leftImageView setImage:[UIImage imageNamed:@"left_back"]];
    [view1 addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
        make.centerY.equalTo(view1.mas_centerY).with.offset(5);
      make.left.equalTo(self.allSelectButton.mas_right).with.offset(kRealValue(10));
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"魅惑炫彩唇膏礼";
    _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    _titleLabel.textColor = [UIColor blackColor];
    [view1 addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view1.mas_centerY).with.offset(5);
        make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(10));
    }];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:@"frong"]];
    [view2 addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kRealValue(27), kRealValue(14)));
        make.centerY.equalTo(view2.mas_centerY).with.offset(6);
       make.left.equalTo(self.allSelectButton.mas_left).with.offset(kRealValue(0));
    }];
    
    _footLabel= [[UILabel alloc] init];
    _footLabel.text = @"升级掌柜子可再减10元";
    _footLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    _footLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [view2 addSubview:_footLabel];
    [_footLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view2.mas_centerY).with.offset(6);
        make.left.equalTo(imageView.mas_right).with.offset(kRealValue(8));
    }];
    

    
    self.imge = [[UIImageView alloc]init];
    self.imge.image =kGetImage(@"ic_public_more_main");
    [view2 addSubview:self.imge];
    [self.imge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
        make.centerY.equalTo(view2.mas_centerY).with.offset(6);
        make.right.equalTo(self.mas_right).with.offset(kRealValue(-10));
    }];
    self.goUpdatelabel = [[UILabel alloc]init];
    self.goUpdatelabel.text = @"去升级";
    self.goUpdatelabel.textColor = KColorFromRGB(kThemecolor);
    self.goUpdatelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
    self.goUpdatelabel.userInteractionEnabled = YES;
    [view2 addSubview:self.goUpdatelabel];
    [self.goUpdatelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imge.mas_left).offset(kRealValue(10));
         make.centerY.equalTo(view2.mas_centerY).with.offset(6);
    }];
    
    
    if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"4"]) {
        self.imge.hidden = YES;
        self.goUpdatelabel.hidden =YES;
    }else{
        self.imge.hidden = NO;
        self.goUpdatelabel.hidden = NO;
    }

    UITapGestureRecognizer *gotogradetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotograde)];
    [self.goUpdatelabel addGestureRecognizer:gotogradetap];
    

}
-(void)gotograde
{
    if (self.Gotoupgrade) {
        self.Gotoupgrade();
    }
}
- (void)configureShopcartHeaderViewWithBrandName:(NSString *)brandName imgaeurl:(NSString *)imageurl brandSelect:(BOOL)brandSelect  userInfo:(NSString *)userinfo{
    self.allSelectButton.selected = brandSelect;
    self.titleLabel.text = brandName;
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:kGetImage(@"img_bitmap_white")];
    self.footLabel.text = [NSString stringWithFormat:@"%@",userinfo];
}

- (void)allSelectButtonAction {
    self.allSelectButton.selected = !self.allSelectButton.isSelected;
    
    if (self.shopcartHeaderViewBlock) {
        self.shopcartHeaderViewBlock(self.allSelectButton.selected);
    }
}

- (UIView *)shopcartHeaderBgView {
    if (_shopcartHeaderBgView == nil){
        _shopcartHeaderBgView = [[UIView alloc] init];
        _shopcartHeaderBgView.backgroundColor = KColorFromRGB(0xF0F1F0);
        _shopcartHeaderBgView.backgroundColor = [UIColor whiteColor];
    }
    return _shopcartHeaderBgView;
}

- (UIButton *)allSelectButton {
    if (_allSelectButton == nil){
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setImage:kGetImage(@"check_off") forState:UIControlStateNormal];
        [_allSelectButton setImage:kGetImage(@"check_on") forState:UIControlStateSelected];
        [_allSelectButton addTarget:self action:@selector(allSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectButton;
}

- (UILabel *)brandLable {
    if (_brandLable == nil){
        _brandLable = [[UILabel alloc] init];
        _brandLable.font = [UIFont systemFontOfSize:14];
        _brandLable.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
    }
    return _brandLable;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.shopcartHeaderBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mas_left).offset(kRealValue(10));
        make.right.equalTo(self.mas_right).offset(kRealValue(0));
        make.height.mas_equalTo(self.mas_height);
    }];
    
    
    
    
}

@end





