//
//  MHPayClass.m
//  mohu
//
//  Created by yuhao on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHPayClass.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
@interface MHPayClass ()<WXApiDelegate>

@property (nonatomic, copy) void(^PaySuccess)(payresult code);
@property (nonatomic, copy) void(^PayError)(payresult code);

@end


@implementation MHPayClass
/**
 *  获取单例
 */
+ (instancetype)sharedApi
{
    static MHPayClass *_sharedApi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedApi = [[[self class] alloc] init];
    });
    return _sharedApi;
    
}
/**
 *  发起微信支付请求
 *
 *  @param pay_param    支付参数
 *  @param successBlock 成功
 *  @param failBlock    失败
 */
- (void)wxPayWithPayParam:(NSMutableDictionary *)pay_param
                  success:(void (^)(payresult ResultCode))successBlock
                  failure:(void (^)(payresult ResultCode))failBlock
{
    self.PaySuccess = successBlock;
    self.PayError = failBlock;
    if (![WXApi isWXAppInstalled]) {
        failBlock(wxuninstall);
        return;
    }
    if (![WXApi isWXAppSupportApi]) {
        failBlock(wxunsupport);
        return;
    }
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = [pay_param valueForKey:@"partnerid"];
    request.prepayId= [pay_param valueForKey:@"prepayid"];
    request.package = [pay_param valueForKey:@"package"];
    request.nonceStr= [pay_param valueForKey:@"noncestr"];
    request.timeStamp= [[pay_param valueForKey:@"timestamp"] intValue];
    request.sign= [pay_param valueForKey:@"sign"];
    [WXApi sendReq:request];
    //
    
}

#pragma mark - 微信回调
// 微信终端返回给第三方的关于支付结果的结构体
- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]])
    {
        switch (resp.errCode) {
            case WXSuccess:
                self.PaySuccess(wxsuceess);
                break;
                
            case WXErrCodeUserCancel:   //用户点击取消并返回
                self.PayError(wxcancel);
                break;
                
            default:        //剩余都是支付失败
                self.PayError(wxfail);
                break;
        }
    }
}


/**
 *  发起支付宝支付请求
 *
 *  @param pay_param    支付参数，订单信息
 *  @param successBlock 成功
 *  @param failBlock    失败
 */
- (void)aliPayWithPayParam:(NSString *)pay_param
                   success:(void (^)(payresult code))successBlock
                   failure:(void (^)(payresult code))failBlock
{
    self.PaySuccess = successBlock;
    self.PayError = failBlock;
    NSString * appScheme =  @"aphskd";
    
    //注：若公司服务器返回的json串可以直接使用，就不用下面的json解析了
    //    NSData *jsonData = [pay_param dataUsingEncoding:NSUTF8StringEncoding];
    //    NSError *err;
    //    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    //    if(err) {
    //        NSLog(@"json解析失败：%@",err);
    //    }
    //    NSString * orderSS = [NSString stringWithFormat:@"app_id=%@&biz_content=%@&charset=%@&method=%@&sign_type=%@&timestamp=%@&version=%@&format=%@&notify_url=%@",dic[@"app_id"],dic[@"biz_content"],dic[@"charset"],dic[@"method"],dic[@"sign_type"],dic[@"timestamp"],dic[@"version"],dic[@"format"],dic[@"notify_url"]];
    //
    //    NSString * signedStr = [self urlEncodedString:dic[@"sign"]];
    //    NSString * orderString = [NSString stringWithFormat:@"%@&sign=%@",orderSS, signedStr];
    
    [[AlipaySDK defaultService] payOrder:pay_param fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        MHLog(@"----- %@",resultDic);
        NSInteger resultCode = [resultDic[@"resultStatus"] integerValue];
        NSString *reultStr = [NSString stringWithFormat:@"%@",resultDic[@"result"]];
        if (resultCode == 4000) {
           if ([reultStr rangeOfString:@"40006"].location !=NSNotFound){
               [[MHUserService sharedInstance]initwithAliPayFailCallBackCompletionBlock:^(NSDictionary *response, NSError *error) {
                   
               }];
            }
        }
        switch (resultCode) {
            case 9000:     //支付成功
                successBlock(alipaysuceess);
                break;
                
            case 6001:     //支付取消
                failBlock(alipaycancel);
                break;
                
            default:        //支付失败
                failBlock(alipayfail);
                break;
        }
    }];
}

///回调处理
- (BOOL) handleOpenURL:(NSURL *) url
{
    if ([url.host isEqualToString:@"safepay"])
    {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            MHLog(@"result = %@",resultDic);
            
            NSInteger resultCode = [resultDic[@"resultStatus"] integerValue];
            NSString *reultStr = [NSString stringWithFormat:@"%@",resultDic[@"result"]];
            if (resultCode == 4000) {
                if ([reultStr rangeOfString:@"40006"].location !=NSNotFound){
                    [[MHUserService sharedInstance]initwithAliPayFailCallBackCompletionBlock:^(NSDictionary *response, NSError *error) {
                        
                    }];
                }
            }
            switch (resultCode) {
                case 9000:     //支付成功
                    self.PaySuccess(alipaysuceess);
                    break;
                    
                case 6001:     //支付取消
                    self.PayError(alipaycancel);
                    break;
                    
                default:        //支付失败
                    self.PayError(alipayfail);
                    break;
            }
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            MHLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            MHLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        return YES;
    } //([url.host isEqualToString:@"pay"]) //微信支付
    return [WXApi handleOpenURL:url delegate:self];
}
//url 加密
- (NSString*)urlEncodedString:(NSString *)string
{
    NSString * encodedString = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    
    return encodedString;
}


-(NSString *) compareCurrentTime:(NSString *)str
{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    long temp = 0;
    NSString *result;
    if (timeInterval/60 < 1)
    {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return  result;
}

@end
