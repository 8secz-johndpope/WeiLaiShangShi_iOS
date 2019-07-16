//
//  MHPayClass.h
//  mohu
//
//  Created by yuhao on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, payresult) {
    
    wxsuceess          = 1001,   /**< 成功    */
    wxfail             = 1002,   /**< 失败    */
    wxcancel           = 1003,   /**< 取消    */
    wxuninstall        = 1004,   /**< 未安装微信   */
    wxunsupport        = 1005,   /**< 微信不支持    */
    wxerrorparam       = 1006,   /**< 支付参数解析错误   */
    wxneterror         = 1007,   /**< 网络异常   */
    
    alipaysuceess        = 1101,   /**< 支付宝支付成功 */
    alipayfail           = 1102,   /**< 支付宝支付错误 */
    alipaycancel         = 1103,   /**< 支付宝支付取消 */
    alipayneterror       = 1104,   /**< 网络异常   */
};

@interface MHPayClass : NSObject

/**
 *  获取单例
 */
+ (instancetype)sharedApi;
/**
 *  发起微信支付请求
 *
 *  @param pay_param    支付参数
 *  @param successBlock 成功
 *  @param failBlock    失败
 */
- (void)wxPayWithPayParam:(NSMutableDictionary *)pay_param
                  success:(void (^)(payresult ResultCode))successBlock
                  failure:(void (^)(payresult ResultCode))failBlock;
/**
 *  发起支付宝支付请求
 *
 *  @param pay_param    支付参数，订单信息
 *  @param successBlock 成功
 *  @param failBlock    失败
 */
- (void)aliPayWithPayParam:(NSString *)pay_param
                   success:(void (^)(payresult code))successBlock
                   failure:(void (^)(payresult code))failBlock;


/**
 *  回调入口
 *
 *  @param url
 *
 *  @return  value
 */
- (BOOL) handleOpenURL:(NSURL *) url;


/*
 日期转换
 */
-(NSString *) compareCurrentTime:(NSString *)str;

@end
