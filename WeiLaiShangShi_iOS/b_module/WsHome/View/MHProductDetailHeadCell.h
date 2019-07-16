//
//  MHProductDetailHeadCell.h
//  mohu
//
//  Created by 余浩 on 2018/9/19.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHProductDetailCellHead.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "RichStyleLabel.h"

typedef void(^ChooseSize)(NSString *productID, NSString *brandID);
typedef void(^productUPorDown)(BOOL selete);
typedef void(^showshareAlet)(void);
@protocol MHProductDetailHeadCellDelegate<NSObject>
-(void)addShopcarWithProductId:(NSString *)productID skuID:(NSString *)skuID amount:(NSString *)amount;
@end

@interface MHProductDetailHeadCell : UITableViewCell
@property (nonatomic, weak)id<MHProductDetailHeadCellDelegate> delegate;
@property (nonatomic, copy)showshareAlet ShowshareAlert;
@property (nonatomic, copy)ChooseSize chooseSizeAct;
@property (nonatomic, copy)productUPorDown productUpAct;
@property (nonatomic, strong)UIImageView *headImgView;
@property (nonatomic, strong)UIImageView *rightImgView;
@property (nonatomic, strong) TYCyclePagerView *headImgScrollview;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) UIView * limitTimeBuy;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UIView *titlebgView;
@property (nonatomic, strong) UIView *SizebgView;
@property (nonatomic, strong) UIImageView *SaledPicView;
@property (nonatomic, strong)UIImageView *leftImgView;
@property (nonatomic, strong)RichStyleLabel *currentPrice ;
@property (nonatomic, strong)UILabel *originalPrice;
@property (nonatomic, strong)UILabel *SalelNum;
@property (nonatomic, strong)UIButton *likebt;
@property (nonatomic, strong)UILabel *likelabel;
@property (nonatomic, strong)YYLabel *titlelabel;
@property (nonatomic, strong)MHProductDetailCellHead *choseePropertyView;
@property(nonatomic, strong) NSMutableArray *bannerArr;
@property (nonatomic, strong)UILabel *labeltime;
@property (nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, strong)NSMutableDictionary *expandDic;
@property (nonatomic, assign)long CellrestTimer;
@property (nonatomic, strong)UIButton *sharebt;
@property(nonatomic, strong)UILabel *secondelabel;
@property(nonatomic, strong)UILabel *minutelabel;
@property(nonatomic, strong)UILabel *hourlabel;
@property(nonatomic, strong)UILabel *labeltitle ;
@property(nonatomic, strong)UILabel *maohao1;
@property(nonatomic, strong)UILabel *maohao2;
@end
