//
//  MHProductDetailBottomView.h
//  mohu
//
//  Created by 余浩 on 2018/9/22.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ProductDetailBottomViewContact)(NSString *productID);
typedef void(^ProductDetailBottomViewGoshopCar)(NSString *productID);
typedef void(^ProductDetailBottomVieAddShopCar)(NSString *productID,NSString *brandID);
typedef void(^ProductDetailBottomVieBuynow)(NSString *productID,NSString *brandID);
typedef void(^ProductDetailBottomVieCollect)(BOOL select);
@interface MHProductDetailBottomView : UIView
@property (nonatomic, strong)UIButton *customContactbtn;
@property (nonatomic, strong)UIButton *shopcarbtn;
@property (nonatomic, strong)UIButton *Collectbtn;
@property (nonatomic, strong)UIButton *Addshopcarbtn;
@property (nonatomic, strong)UIButton *Buybtn;
@property (nonatomic, copy)ProductDetailBottomViewContact  productDetailBottomViewContact;
@property (nonatomic, copy)ProductDetailBottomVieCollect  productDetailBottomViewCollect;
@property (nonatomic, copy)ProductDetailBottomViewGoshopCar  productDetailBottomViewGoshopCar;
@property (nonatomic, copy)ProductDetailBottomVieAddShopCar  productDetailBottomVieAddShopCar;
@property (nonatomic, copy)ProductDetailBottomVieBuynow  productDetailBottomVieBuynow;
@property (nonatomic, strong)NSString *comeform;
- (instancetype)initWithFrame:(CGRect)frame comeform:(NSString *)comeform;


@end
