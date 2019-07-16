//
//  MHUserService.h
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^returnBlock)(NSDictionary *response,NSError *error);

@interface MHUserService : NSObject









+ (MHUserService*)sharedInstance;

//登录接口
- (void)initWithLogin:(NSString *)username
                  sms:(NSString *)smsCode
      completionBlock:(returnBlock)block;

//注册接口
- (void)initWithRegsietr:(NSString *)username
                password:(NSString *)password
                 smsCode:(NSString *)smsCode
              inviteCode:(NSString *)inviteCode
         completionBlock:(returnBlock)block;

//获取短信验证码
-(void)initWithSendCode:(NSString *)phone scene:(NSString *)scene completionBlock:(returnBlock)block;

//验证手机号
-(void)initWithValidCode:(NSString *)phone
                   scene:(NSString *)scene
                 smsCode:(NSString *)smsCode
         completionBlock:(returnBlock)block;

//修改手机号
-(void)initWithFixPassword:(NSString *)phone
                  password:(NSString *)password
           confirmPassword:(NSString *)confirmPassword
                   smsCode:(NSString *)smsCode
           completionBlock:(returnBlock)block;


//获取个人资料
-(void)initWithUserInfoCompletionBlock:(returnBlock)block;

//商品列表
-( void)initwithTypeIdList:(NSString *)productType pageSize:(NSInteger )pageSize pageIndex:(NSInteger )pageIndex completionBlock:(returnBlock)block;

//资产明细
-(void)initwithShopAssets:(NSString *)flowType  pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;


////我的订单
-(void)initwithMyorder:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;


//展示最新资讯
-(void)initWitArticlePageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;

//粉丝个数
-(void)initWithFansSummaryCompletionBlock:(returnBlock)block;

//粉丝统计
-(void)initWithFansSummaryRelationLevel:(NSInteger )relationLevel CompletionBlock:(returnBlock)block;

//粉丝详情
-(void)initwithShopFans:(NSInteger )relationLevel  userRole:(NSString *)userRole  pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;

///继续下单
-(void)initwithConfirmProduct:(NSArray *)products addressId:(NSString *)addressId payType:(NSString *)payType orderType:(NSString *)orderType orderTruePrice:(NSString *)orderTruePrice  payPassword:(NSString *)payPassword completionBlock:(returnBlock)block;

//确定i订单
-( void)initwithConfirmProduct:(NSArray *)products completionBlock:(returnBlock)block;


//下单
-(void)initwithSumitOrder:(NSArray *)order completionBlock:(returnBlock)block;


//任务列表
-(void)initwithWGTaskListcompletionBlock:(returnBlock)block;
//任务详情
-(void)initwithWGTaskDetailWithTaskID:(NSString *)taskID completionBlock:(returnBlock)block;
//提交任务
-(void)initwithWGTaskDetailWithTaskID:(NSString *)taskID taskCode:(NSString *)taskCode taskUrl:(NSString *)taskUrl completionBlock:(returnBlock)block;
//完成任务
-(void)initwithWGTaskCompleteWithuserTaskId:(NSString *)userTaskId completeUrl:(NSString *)completeUrl taskId:(NSString *)taskId completionBlock:(returnBlock)block;
//用户任务列表
-(void)initwithWGTaskUserListpageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;
//用户任务详情
-(void)initwithWGTaskUserDetailWithTaskID:(NSString *)taskID completionBlock:(returnBlock)block;
//验证任务是否可完成
-(void)initWithWGTaskIsCompeleteWithUserTaskID:(NSString *)taskID completionBlock:(returnBlock)block;
//分享类，下载类任务完成接口
-(void)initwithWGTaskCompleteWithuserTaskId:(NSString *)userTaskId  completionBlock:(returnBlock)block;



//判断host1是否能否使用
-(void)initwithHost1completionBlock:(returnBlock)block;

//判断host2是否能否使用
-(void)initwithHost2completionBlock:(returnBlock)block;

-(void)initwithHost3completionBlock:(returnBlock)block;

-(void)initwithHost4completionBlock:(returnBlock)block;

-(void)initwithWithHSFindHotAllListPageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;

-(void)initwithWithHSFindHotDayListPageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)bloc;


-(void)initwithContinuePay:(NSInteger )orderId  payType:(NSString *)payType payPassword:(NSString * )payPassword completionBlock:(returnBlock)block;

//商品详情
-( void)initwithProductId:(NSString *)productId completionBlock:(returnBlock)block;


//修改个人资料
-(void)initWithChangeUserInfoupdateType:(NSString *)updateType userNickname:(NSString*)userNickname userImage:(NSString*)userImage openId:(NSString*)openId unionId:(NSString*)unionId originUserPhone:(NSString*)originUserPhone originUserPhoneCode:(NSString*)originUserPhoneCode newUserPhone:(NSString*)newUserPhone newUserPhoneCode:(NSString*)newUserPhoneCode newPayPassword:(NSString*)newPayPassword  newConfirmPassword:(NSString*)newConfirmPassword newPayPasswordCode:(NSString*)newPayPasswordCode isOldPhone:(BOOL)isold CompletionBlock:(returnBlock)block;
// 获取用户收货地址列表
-(void)initWithGetUserAdressInfoCompletionBlock:(returnBlock)block;
//删除收货地址
-(void)initWithdeleteAdressInfoWithaddressId:(NSString *)addressId CompletionBlock:(returnBlock)block;
//设置某个地址为默认收货
-(void)initWithSetDefaultAdressInfoWithaddressId:(NSString *)addressId CompletionBlock:(returnBlock)block;
// 新增&修改用户收货地址
-(void)initWithChangeAdressInfoWithaddressId:(NSString *)addressId userName:(NSString *)userName userPhone:(NSString *)userPhone province:(NSString *)province city:(NSString *)city area:(NSString *)area details:(NSString *)details  addressState:(NSString *)addressState CompletionBlock:(returnBlock)block;


//取消订单
-(void)initwithCancleorder:(NSInteger )orderId completionBlock:(returnBlock)block;

//确认订单
-(void)initwithOkorder:(NSInteger )orderId completionBlock:(returnBlock)block;

//订单详情
-(void)initwithorderDetail:(NSInteger )orderId completionBlock:(returnBlock)block;

//退换货
-(void)initwithServiceList:(NSInteger)orderId  completionBlock:(returnBlock)block;




-(void)initwithWithdraw:(NSString  *)money  cardId:(NSString  * )cardId  payPassword:(NSString  * )payPassword fee:(NSString  * )fee completionBlock:(returnBlock)block;

//提现记录
-(void)initwithWithDrawDataPageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;


-(void)initwithDeleWithdraw:(NSString  *)cardId completionBlock:(returnBlock)block;

//新增提现
-(void)initwithAddWithdraw:(NSString  *)username  cardCode:(NSString  * )cardCode  verifyCode:(NSString  * )verifyCode withdrawType:(NSString  * )withdrawType  bankAccount:(NSString  * )bankAccount bankName:(NSString  * )bankName bankCode:(NSString  * )bankCode areaCode:(NSString  * )areaCode  bankSubAccount:(NSString  * )bankSubAccount completionBlock:(returnBlock)block;


//新增提现
-(void)initwitheditWithdraw:(NSString  *)userId  cardCode:(NSString  * )cardCode  verifyCode:(NSString  * )verifyCode withdrawType:(NSString  * )withdrawType  bankAccount:(NSString  * )bankAccount bankName:(NSString  * )bankName bankCode:(NSString  * )bankCode areaCode:(NSString  * )areaCode  bankSubAccount:(NSString  * )bankSubAccount completionBlock:(returnBlock)block;


//获取APP首页页面模块
-(void)initWithPageComponent:(NSString *)scene  completionBlock:(returnBlock)block;
//获取消息
-(void)initWithGetMessage:(NSString *)messageCode pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize completionBlock:(returnBlock)block;

-(void)initwithServiceInfo:(NSInteger)orderId  completionBlock:(returnBlock)block;


//售后
-(void)initwithCommitService:(NSInteger)orderId  reason:(NSString * )reason serviceType:(NSString *  )serviceType description:(NSString *  )description images:(NSString *  )images orderCode:(NSString *  )orderCode completionBlock:(returnBlock)block;
//邀请记录
-(void)initwithYaoqingrecord:(NSString *)userRole CompletionBlock:(returnBlock)block;

//回调后台支付结果
-(void)initwithCallBackHostPayResult:(NSString *)orderCode CompletionBlock:(returnBlock)block;


//回调后台支付结果
-(void)initwithHSCallBackHostPayResult:(NSString *)orderCode payType:(NSString *)payType CompletionBlock:(returnBlock)block;


-(void)initwithHSRecommendcompletionBlock:(returnBlock)block;

-(void)initwithHSShopCategorycompletionBlock:(returnBlock)block;

-(void)initwithHSShopDetail:(NSString *)prodId CompletionBlock:(returnBlock)block;


-(void)initwithHSWithdrawListCompletionBlock:(returnBlock)block;

//提现列表
-(void)initwithHSShopWithDrawMoneyList:(NSString *)withdrawType CompletionBlock:(returnBlock)block;

-(void)initwithWithRewardPageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize flowType:(NSString *)flowType queryTime:(NSString *)queryTime completionBlock:(returnBlock)block;

-(void)initwithHSHotAllListCompletionBlock:(returnBlock)block;

-(void)initwithHSHotDayListCompletionBlock:(returnBlock)block;

-(void)initwithHSHotPreExchangeCompletionBlock:(returnBlock)block;

-(void)initwithBankListCompletionBlock:(returnBlock)block;

-(void)initwithCityListCompletionBlock:(returnBlock)block;


-(void)initwithHSHotExchange:(NSString *)integral CompletionBlock:(returnBlock)block;


-(void)initwithHSRuleType:(NSString *)ruleType CompletionBlock:(returnBlock)block;

//第三方登录
-(void)initWithThirdLogin:(NSString *)thirdparty
                      uid:(NSString *)uid
                  unionid:(NSString *)unionid
                 nickName:(NSString *)nickName
                   avatar:(NSString *)avatar
          completionBlock:(returnBlock)block;


//第三方绑定手机号
-(void)initWithThirdBindPhone:(NSString *)phone
                      smsCode:(NSString *)smsCode
                   userYQCode:(NSString *)userYQCode
                          uid:(NSString *)uid
                      unionid:(NSString *)unionid
              completionBlock:(returnBlock)block;



-(void)initwithHSAllMoneyCompletionBlock:(returnBlock)block;


-(void)initwithHSFuliCompletionBlock:(returnBlock)block;

-(void)initwithHSWithRedPackageCompletionBlock:(returnBlock)block;


-(void)initWithHSReChargeYLZ:(NSString *)power CompletionBlock:(returnBlock)block;

-(void)initWithHSChargeYLZ:(NSString *)power CompletionBlock:(returnBlock)block;

-(void)initwithWithChargeListIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize  completionBlock:(returnBlock)block;


-(void)initwithHSDTBannerCompletionBlock:(returnBlock)block;

-(void)initwithWithDTListIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize  completionBlock:(returnBlock)block;

-(void)initWithHSbiliCharge:(NSString *)power CompletionBlock:(returnBlock)block;

-(void)initwithWithjifenListIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize  completionBlock:(returnBlock)block;

-(void)initwithHSDayShouruCompletionBlock:(returnBlock)block;

-(void)initwithHSALLShouruCompletionBlock:(returnBlock)block;

//产品分类&字分类
-(void)initWithProductTypes:(NSString *)parentId  scene:(NSString *)scene completionBlock:(returnBlock)block;



//分类推荐模块banner图模块kRecommendbanner
-(void)initWithRecommend:(NSString *)typeId completionBlock:(returnBlock)block;

//注册填写邀请码
-(void)initWithActive:(NSString *)accessToken  userYQCode:(NSString *)userYQCode completionBlock:(returnBlock)block;
////全部分类模块
- (void)initWitAllTypesCompletionBlock:(returnBlock)block;

- (void)initWitHSActiveCompletionBlock:(returnBlock)block;


-(void)initwithHSHDList:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;


-(void)initWithHSNoticeDetailId:(NSString *)noticeId CompletionBlock:(returnBlock)block;
//第三方登录
-(void)initWithThirdLogin:(NSString *)thirdparty
                      uid:(NSString *)uid
                  unionid:(NSString *)unionid
                 nickName:(NSString *)nickName
                   avatar:(NSString *)avatar
          completionBlock:(returnBlock)block;

//第三方绑定手机号
-(void)initWithThirdBindPhone:(NSString *)phone
                      smsCode:(NSString *)smsCode
                   userYQCode:(NSString *)userYQCode
                          uid:(NSString *)uid
                      unionid:(NSString *)unionid
              completionBlock:(returnBlock)block;

//活动商品详情
-( void)initwithProductId:(NSString *)productId activityId:(NSString *)activityId beginTime:(NSString *)beginTime endTime:(NSString *)endTime completionBlock:(returnBlock)block;
-( void)initwithHotSearchCompletionBlock:(returnBlock)block;


-( void)initwithUserListName:(NSString *)name pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;
//商品列表
-( void)initwithTypeIdList:(NSString *)TypeId name:(NSString *)name brandId:(NSString *)brandId minPrice:(NSString*)minPrice maxPrice:(NSString *)maxPrice order:(NSString *)order sort:(NSString *)sort pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block;
//商品品牌列表
-(void)initWithproductbrandList:(NSString *)typeId completionBlock:(returnBlock)block;

//商品评论列表
-( void)initwithCommentProductId:(NSString *)productId pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block;
//收藏/取消收藏商品
-( void)initwithCommentProductId:(NSString *)productId collected:(NSString *)collected  completionBlock:(returnBlock)block;
//上下架商品
-( void)initwithCommentProductId:(NSString *)productId updown:(NSString *)updown  completionBlock:(returnBlock)block;
//添加商品到购物车
-(void)initWithAddShopCartProductId:(NSString *)productId skuId:(NSString *)skuId amount:(NSString *)amount completionBlock:(returnBlock)block;
//购物车商品列表
-(void)initWithShopCartListcompletionBlock:(returnBlock)block;
//删除购物车商品
-(void)initWithDeleteSHopProductId:(NSString *)productIds completionBlock:(returnBlock)block;
//修改购物车商品数量
-(void)initWithShopCartListProductId:(NSMutableArray *)productId amount:(NSString *)amount completionBlock:(returnBlock)block;

//我的收藏
-(void)initWithCollectListCompletionBlock:(returnBlock)block;
//批量删除我的收藏商品
-(void)initWithDeleteCollects:(NSString *)Collects completionBlock:(returnBlock)block;



//限时抢购活动title列表
-(void)initWithLitmitBuyactivityType:(NSString *)activityType completionBlock:(returnBlock)block;
//活动商品列表
-(void)initWithLitmitBuyactivityId:(NSString *)activityId beginTime:(NSString *)beginTime endTime:(NSString *)endTime pageSize:( NSInteger )pageSize pageIndex:(NSInteger)pageIndex completionBlock:(returnBlock)block;
//奖多多商品列表
-(void)initWithPriceMorepageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block;
//狐猜商品列表
-(void)initWithHucaipageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block;

//奖多多详情
-( void)initwithDrawId:(NSString *)DrawId completionBlock:(returnBlock)block;
// 订单商品详情
-( void)initwithlistshareId:(NSString *)shareId completionBlock:(returnBlock)block;
//发起奖多多,胡猜
-( void)initwithStartPrizewithDrawId:(NSString *)DrawId morecompletionBlock:(returnBlock)block;
//奖品列表
-( void)initwithStartPrizewithdrawAllType:(NSString *)drawAllType pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex morecompletionBlock:(returnBlock)block;
//发起的奖多多,胡猜订单列表
-( void)initwithStartOrderListPrizewithdrawAllType:(NSString *)drawAllType pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex morecompletionBlock:(returnBlock)block;
//参加的订单列表
-( void)initwithtackpartInwithdrawAllType:(NSString *)drawAllType pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex morecompletionBlock:(returnBlock)block;
//添加评论
-(void)initAddComment:(NSMutableArray *)evaluateList orderId:(NSString *)orderId completionBlock:(returnBlock)block;
//订单默认评价列表
-(void)initorderCommentListorderId:(NSString *)orderId completionBlock:(returnBlock)block;
//领取奖品内容不带地址
-(void)initorderCommentListwinningId:(NSString *)winningId completionBlock:(returnBlock)block;
//领取奖品内容已填地址
-(void)initorderCommentAddressListwinningId:(NSString *)winningId completionBlock:(returnBlock)block;

//领取奖品按钮
-(void)initorderCommentListwinningId:(NSString *)winningId addressId:(NSString *)addressId completionBlock:(returnBlock)block;
//领取奖品-确认收货
-(void)initgetorderorderCommentListwinningId:(NSString *)winningId completionBlock:(returnBlock)block;
//奖多多开奖
-(void)initwithopenprizeshareId:(NSString *)shareId completionBlock:(returnBlock)block;
//版本升级
-(void)initWithOS:(NSString *)OS channel:(NSString *)channel version:(NSString *)version completionBlock:(returnBlock)block;

//未读消息数量
-(void)initWithGetMessageUnreadtypeCodeList:(NSString *)typeCodeList CompletionBlock:(returnBlock)block;
//清除未读消息
-(void)initWithCleanMessageUnreadtypeCodeList:(NSString *)typeCodeList CompletionBlock:(returnBlock)block;

-( void)initwithVipProductCompletionBlock:(returnBlock)block;

-( void)initwithUpgradeCompletionBlock:(returnBlock)block;

-( void)initwithUserStateCompletionBlock:(returnBlock)block;



-(void)initwithShopkeeperCompletionBlock:(returnBlock)block;

-(void)initwithShopTaskCompletionBlock:(returnBlock)block;



//粉丝统计
-(void)initWithFansSummary:(NSInteger )userId  relationLevel:(NSInteger )relationLevel CompletionBlock:(returnBlock)block;
//粉丝分页
-(void)initwithShopFans:(NSInteger )relationLevel  userId:(NSInteger )userId  pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;





//经营数据 kShoporderList

-(void)initwithShoporderList:(NSString  *)orderTradeStatus pageIndex:(NSInteger )pageIndex completionBlock:(returnBlock)block;

-(void)initwithHomeNewbee:(NSString  *)activityId pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;

-(void)initwithfansorder:(NSInteger )fansUserId completionBlock:(returnBlock)block;


-(void)initwithShopdingdan:(NSInteger )fansUserId pageIndex:(NSInteger )pageIndex completionBlock:(returnBlock)block;



-(void)initwithNewbeeDesc:(NSInteger)pid completionBlock:(returnBlock)block;

//我的店铺列表
-(void)initwithStoreHome:(NSString *)userId  pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;

-(void)initwithStoreInfo:(NSString *)shopId completionBlock:(returnBlock)block;

-(void)initwithHomeCommand:(NSString *)typeId recommend:(NSString *)recommend pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block;






//榜单
-(void)initwithBangdanCompletionBlock:(returnBlock)block;
//
//开屏广告
-(void)initLaunchADWithCompletionBlock:(returnBlock)block;
//
//修改店铺信息
-(void)initWithFixShop:(NSString *)shopName shopImage:(NSString *)shopImage shopDesc:(NSString *)shopDesc completionBlock:(returnBlock)block;

-(void)initwithShopManagetCompletionBlock:(returnBlock)block;

////第三方
-(void)initWithThirdPreBindPhone:(NSString *)phone smsCode:(NSString *)smsCode  uid:(NSString *)uid  unionid:(NSString *)unionid completionBlock:(returnBlock)block;



-(void)initwithHSProdList:(NSString *)productType pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize  categoryId:(NSString *)categoryId  CompletionBlock:(returnBlock)block;


//文章分类
-(void)initwithHSAriticeCategoryCompletionBlock:(returnBlock)block;
//刷新文章列表
-(void)initwithRefreshHSAriticeCategorypageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize categoryId:(NSString *)categoryId advIds:(NSString *)advIds  dateTime:(NSString *)dateTime CompletionBlock:(returnBlock)block;
//文章列表
-(void)initwithHSAriticeCategorypageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize categoryId:(NSString *)categoryId advIds:(NSString *)advIds  dateTime:(NSString *)dateTime CompletionBlock:(returnBlock)block;
//推荐文章列表
-(void)initwithHSRecommendAriticeCategorypageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize advIds:(NSString *)advIds taskIds:(NSString *)taskIds dateTime:(NSString *)dateTime CompletionBlock:(returnBlock)block;
//刷新推荐文章列表
-(void)initwithRefreshHSRecommendAriticeCategorypageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize advIds:(NSString *)advIds taskIds:(NSString *)taskIds dateTime:(NSString *)dateTime CompletionBlock:(returnBlock)block;
//文章详情
-(void)initwithHSAriticeDetailariticeId:(NSString *)ariticeId ISAd:(NSString *)isAd CompletionBlock:(returnBlock)block;
//签到信息
-(void)initwithHSQiandaoInfoCompletionBlock:(returnBlock)block;
//签到
-(void)initwithHSDoQiandaoCompletionBlock:(returnBlock)block;
//福利任务列表
-(void)initwithHSFuliTaskListCompletionBlock:(returnBlock)block;
//银勺、金勺会员任务列表
-(void)initwithHSVIPTaskListWithType:(NSString *)type CompletionBlock:(returnBlock)block;
//获取首页分类页面模块
-(void)initWithFirstPageComponent:(NSString *)scene parentTypeId:(NSString *)parentTypeId completionBlock:(returnBlock)block;
//支付列表
-(void)initwithHSPayListCompletionBlock:(returnBlock)block;
//验证文章是否需要进行倒计时
-(void)initwithHSAriticeTimerWIthID:(NSString *)taskID ISAd:(NSString *)isAd CompletionBlock:(returnBlock)block;
//文章倒计时结束后提交
-(void)initwithHSAriticeTimerOverWIthID:(NSString *)taskID ISAd:(NSString *)isAd title:(NSString *)title CompletionBlock:(returnBlock)block;
//h5活动
-(void)initwithHSWebAriticeinterfaceCode:(NSString *)interfaceCode businessParam:(NSString *)businessParam weburl:(NSString *)weburl CompletionBlock:(returnBlock)block;
//支付宝支付失败调用
-(void)initwithAliPayFailCallBackCompletionBlock:(returnBlock)block;
//推荐资讯
-(void)initwithHsRecommenFirstPageAriticeID:(NSString *)AriticeID CompletionBlock:(returnBlock)block;
//公告弹框
-(void)initwithHsAlertCompletionBlock:(returnBlock)block;
//活动模块通知公告列表
-(void)initwithHSAnnoucepageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize  CompletionBlock:(returnBlock)block;

@end
