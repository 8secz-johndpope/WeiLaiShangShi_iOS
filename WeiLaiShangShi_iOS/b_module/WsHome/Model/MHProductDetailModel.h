//
//  MHProductDetailModel.h
//  mohu
//
//  Created by yuhao on 2018/9/26.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHProductDetailModel : MHBaseModel
//商品id
@property (nonatomic, strong)NSString *productId;
//商品名称
@property (nonatomic, strong)NSString *productName;
//产品简介
@property (nonatomic, strong)NSString *productSubtitle;
//产品组图
@property (nonatomic, strong)NSString *productImages;
//产品产品详情组图
@property (nonatomic, strong)NSMutableArray *productBigImage;
//零售价
@property (nonatomic, strong)NSString *retailPrice;
//已售数量
@property (nonatomic, strong)NSString *sellCount;
//是否收藏 1：是，0：否
@property (nonatomic, strong)NSString *collected;
//规格列表
@property (nonatomic, strong)NSMutableArray *skuList;
//商品规格属性列表
@property (nonatomic, strong)NSMutableArray *standardList;
//上下架状态（店主） 0：下架，1：上架
@property (nonatomic, strong)NSString *updown;
//
@property (nonatomic, strong)NSString *marketPrice;
//
//分享图片
@property (nonatomic, strong)NSString *productSmallImage;
//分享二维码
@property (nonatomic, strong)NSString *productUrl;
//该商品被发起的数量
@property (nonatomic, strong)NSString *shareCount;
//状态 PENDING：未开始，INITIATE：可发起，ACTIVE：进行中，UNOPENED：满员未开奖，OPENED：已开奖，INVALID：已过期
@property (nonatomic, strong)NSString *status;
//商品规格
@property (nonatomic, strong)NSString *productStandard;
//分享二维码
@property (nonatomic, strong)NSString *sharePath;
//活动结束时间
@property (nonatomic, assign)long restTime;
//商品价格
@property (nonatomic, strong)NSString *productPrice;
//ture：参与者，false：发起者
@property (nonatomic, assign)NSInteger relation;
//开奖人数
@property (nonatomic, strong)NSString *drawNumber;
//用户参与时间
@property (nonatomic, strong)NSString *winnerTime;
//中奖用户id
@property (nonatomic, strong)NSString *winnerUserId;
//中奖用户头像
@property (nonatomic, strong)NSString *winnerUserImage;
//中奖用户昵称
@property (nonatomic, strong)NSString *winnerUserNickName;
;
@end
