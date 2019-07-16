//
//  MHProductDetailBottomView.m
//  mohu
//
//  Created by 余浩 on 2018/9/22.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHProductDetailBottomView.h"

@implementation MHProductDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        self.backgroundColor = [UIColor whiteColor];
   [self createview];
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame comeform:(NSString *)comeform
{
    self = [super initWithFrame:frame];
    if (self) {
        _comeform = comeform;
        self.backgroundColor = [UIColor whiteColor];
        if ([comeform isEqualToString:@"vip"]) {
            
            [self createviewWithcomeform:comeform];
            
        }else if ([comeform isEqualToString:@"hasclose"]){
            [self createviewWithhasclose];
        }else if ([comeform isEqualToString:@"willopen"]){
            [self createviewWithwillopen];
        }else{
             [self createview];
        }
      
        
    }
    return self;
}
-(void)createviewWithcomeform:(NSString *)comeform
{
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight - kRealValue(51)- kBottomHeight , kScreenWidth, 1/kScreenScale)];
    lineview.backgroundColor = KColorFromRGB(0xF1F2F1);
    [self addSubview:lineview];
    [self addSubview:self.customContactbtn];
    [self addSubview:self.Buybtn];
    if ([[GVUserDefaults standardUserDefaults].userRole integerValue ]== 1 || [GVUserDefaults standardUserDefaults].accessToken == nil) {
         [self.Buybtn setTitle:@"立即购买" forState:UIControlStateNormal];
    }else{
         [self.Buybtn setTitle:@"立即分享" forState:UIControlStateNormal];
    }
    
    self.Buybtn.frame = CGRectMake(self.customContactbtn.frame.origin.x + self.customContactbtn.frame.size.width+kRealValue(15), kRealValue(0),kScreenWidth - self.customContactbtn.frame.origin.x-self.customContactbtn.frame.size.width-kRealValue(15), kRealValue(50));
}

-(void)createviewWithhasclose{
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight - kRealValue(51)- kBottomHeight , kScreenWidth, 1/kScreenScale)];
    lineview.backgroundColor = KColorFromRGB(0xF1F2F1);
    [self addSubview:lineview];
    [self addSubview:self.customContactbtn];
    [self addSubview:self.Buybtn];
    self.Buybtn.frame = CGRectMake(self.customContactbtn.frame.origin.x + self.customContactbtn.frame.size.width+kRealValue(15), kRealValue(0),kScreenWidth - self.customContactbtn.frame.origin.x-self.customContactbtn.frame.size.width-kRealValue(15), kRealValue(50));
    self.Buybtn.backgroundColor = KColorFromRGB(0xe0e0e0);
    [self.Buybtn setTitle:@"已结束" forState:UIControlStateNormal];
    self.Buybtn.userInteractionEnabled = NO;
    
}
-(void)createviewWithwillopen{
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight - kRealValue(51)- kBottomHeight , kScreenWidth, 1/kScreenScale)];
    lineview.backgroundColor = KColorFromRGB(0xF1F2F1);
    [self addSubview:lineview];
    [self addSubview:self.customContactbtn];
    [self addSubview:self.Buybtn];
    self.Buybtn.frame = CGRectMake(self.customContactbtn.frame.origin.x + self.customContactbtn.frame.size.width+kRealValue(15), kRealValue(0),kScreenWidth - self.customContactbtn.frame.origin.x-self.customContactbtn.frame.size.width-kRealValue(15), kRealValue(50));
    self.Buybtn.backgroundColor = KColorFromRGB(0xFA4919);
    [self.Buybtn setTitle:@"即将开抢" forState:UIControlStateNormal];
    self.Buybtn.userInteractionEnabled = NO;
}
-(void)createview
{
    
    [self addSubview:self.customContactbtn];
    [self addSubview:self.shopcarbtn];
    [self addSubview:self.Collectbtn];
    [self addSubview:self.Addshopcarbtn];
    [self addSubview:self.Buybtn];
    
}
-(UIButton *)customContactbtn
{
    if (!_customContactbtn) {
        _customContactbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _customContactbtn.frame = CGRectMake(kRealValue(15), kRealValue(0), kRealValue(30), kRealValue(50));
        
        [_customContactbtn setImage:kGetImage(@"kefu") forState:UIControlStateNormal];
        [_customContactbtn setTitle:@"客服" forState:UIControlStateNormal];
        [_customContactbtn setTitleColor:KColorFromRGB(0x000000) forState:UIControlStateNormal];
        _customContactbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _customContactbtn.titleLabel.textColor = [UIColor blackColor];
        _customContactbtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        // button标题的偏移量
        self.customContactbtn.titleEdgeInsets = UIEdgeInsetsMake(self.customContactbtn.imageView.frame.size.height, -self.customContactbtn.imageView.bounds.size.width, 0,0);
        // button图片的偏移量
        self.customContactbtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.customContactbtn.titleLabel.frame.size.width/2, self.customContactbtn.titleLabel.frame.size.height, -self.customContactbtn.titleLabel.frame.size.width/2);

        [_customContactbtn addTarget:self action:@selector(customcontact) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customContactbtn;
}


-(void)customcontact
{
    if (self.productDetailBottomViewContact) {
        self.productDetailBottomViewContact(@"");
    }
}
-(UIButton *)Collectbtn
{
    if (!_Collectbtn) {
        _Collectbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _Collectbtn.frame = CGRectMake(self.customContactbtn.frame.origin.x+self.customContactbtn.frame.size.width + kRealValue(9), kRealValue(0), kRealValue(40), kRealValue(50));
        [_Collectbtn setImage:kGetImage(@"sc") forState:UIControlStateNormal];
         [_Collectbtn setImage:kGetImage(@"asc") forState:UIControlStateSelected];
        [_Collectbtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_Collectbtn setTitle:@"已收藏" forState:UIControlStateSelected];
        [_Collectbtn setTitleColor:KColorFromRGB(0x000000) forState:UIControlStateNormal];
        _Collectbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _Collectbtn.titleLabel.textColor = [UIColor blackColor];
        _Collectbtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        // button标题的偏移量
        self.Collectbtn.titleEdgeInsets = UIEdgeInsetsMake(self.Collectbtn.imageView.frame.size.height, -self.Collectbtn.imageView.bounds.size.width, 0,0);
        // button图片的偏移量
        self.Collectbtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.Collectbtn.titleLabel.frame.size.width/2, self.Collectbtn.titleLabel.frame.size.height, -self.Collectbtn.titleLabel.frame.size.width/2);
        [_Collectbtn addTarget:self action:@selector(Collectbtnact:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Collectbtn;
}
-(void)Collectbtnact:(UIButton *)sender
{
   
    if (self.productDetailBottomViewCollect) {
        self.productDetailBottomViewCollect(sender.selected);
    }
}

-(UIButton *)shopcarbtn
{
    if (!_shopcarbtn) {
        _shopcarbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shopcarbtn.frame = CGRectMake(self.Collectbtn.frame.origin.x+self.Collectbtn.frame.size.width + kRealValue(9), kRealValue(0), kRealValue(40), kRealValue(50));
        [_shopcarbtn setImage:kGetImage(@"gwc") forState:UIControlStateNormal];
        [_shopcarbtn setTitle:@"购物车" forState:UIControlStateNormal];
        [_shopcarbtn setTitleColor:KColorFromRGB(0x000000) forState:UIControlStateNormal];
        _shopcarbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _shopcarbtn.titleLabel.textColor = [UIColor blackColor];
        _shopcarbtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        // button标题的偏移量
        self.shopcarbtn.titleEdgeInsets = UIEdgeInsetsMake(self.shopcarbtn.imageView.frame.size.height, -self.shopcarbtn.imageView.bounds.size.width, 0,0);
        // button图片的偏移量
        self.shopcarbtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.shopcarbtn.titleLabel.frame.size.width/2, self.shopcarbtn.titleLabel.frame.size.height, -self.shopcarbtn.titleLabel.frame.size.width/2);
        [_shopcarbtn addTarget:self action:@selector(goshopcar) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopcarbtn;
}
-(void)goshopcar
{
    if (self.productDetailBottomViewGoshopCar) {
        self.productDetailBottomViewGoshopCar(@"");
    }
}
-(UIButton *)Addshopcarbtn
{
    if (!_Addshopcarbtn) {
        _Addshopcarbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _Addshopcarbtn.frame = CGRectMake( self.shopcarbtn.frame.origin.x + self.shopcarbtn.frame.size.width+ kRealValue(6), kRealValue(0), (kScreenWidth -  (self.shopcarbtn.frame.origin.x + self.shopcarbtn.frame.size.width+ kRealValue(6)))/2, kRealValue(50));
        _Addshopcarbtn.backgroundColor = KColorFromRGB(0xFF8819);
        [_Addshopcarbtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_Addshopcarbtn setTitleColor:KColorFromRGB(0xffffff) forState:UIControlStateNormal];
        _Addshopcarbtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        [_Addshopcarbtn addTarget:self action:@selector(Addshopcar) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _Addshopcarbtn;
}
-(void)Addshopcar
{
    if (self.productDetailBottomVieAddShopCar) {
        self.productDetailBottomVieAddShopCar(@"", @"");
    }
   
}
-(UIButton *)Buybtn
{
    if (!_Buybtn) {
        _Buybtn = [UIButton buttonWithType:UIButtonTypeCustom];
         _Buybtn.frame = CGRectMake(self.Addshopcarbtn.frame.origin.x + self.Addshopcarbtn.frame.size.width, kRealValue(0), (kScreenWidth -  (self.shopcarbtn.frame.origin.x + self.shopcarbtn.frame.size.width+ kRealValue(6)))/2, kRealValue(50));
//        [_Buybtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(133), kRealValue(44))] forState:UIControlStateNormal];
        _Buybtn.backgroundColor = KColorFromRGB(0xFA4919);
        _Buybtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        [_Buybtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_Buybtn addTarget:self action:@selector(buyNew) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _Buybtn;
}
-(void)buyNew
{
    if (self.productDetailBottomVieBuynow) {
        self.productDetailBottomVieBuynow(@"",@"");
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
