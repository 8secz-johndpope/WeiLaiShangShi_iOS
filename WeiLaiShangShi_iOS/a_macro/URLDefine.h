//
//  URLDefine.h
//  mohu
//
//  Created by AllenQin on 2018/8/14.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#ifndef URLDefine_h
#define URLDefine_h

/**开发环境*/
#define DevelopSever    1
/**生产环境*/
//http://60.174.205.143:18083
//http://60.174.205.143:8136
#define ProductSever    0


#if DevelopSever






//#define kMHHost1 @"http://192.168.88.116:8085"
//#define kMHHost2 @"http://192.168.88.116:8085"

//http://60.168.131.213:8085/
#define kMHHost1 @"http://60.168.131.213:8085"
#define kMHHost2 @"http://60.168.131.213:8085"
#define kMHHostWap1 @"https://testwap.hooshao.com"
#define kMHHostWap2 @"https://wap.langshunkeji.com"


#elif ProductSever

#define kMHHost1 @"https://api.hooshao.com"
#define kMHHost2 @"https://api.langshunkeji.com"

#define kMHHostWap1 @"https://wap.hooshao.com"
#define kMHHostWap2 @"https://wap.langshunkeji.com"


#endif



//商品分类
#define Wsproductcategory_v_1 @"/rest/product/category"
//首页商品分类home_
#define Wshome_productcategory_v_1 @"/rest/product/category/index"







//error code 定义 足够长

//accessToken不存在或过期，需要进行调用刷新令牌接口
#define kRefreshTokenCode    @"10000"
//refreshToken不存在，需重新授权登录
#define kNoneCode            @"10001"
//refreshToken失效，需重新授权登录
#define kTimeOutCode         @"10002"
//已被踢下线，需重新授权登录
#define kLoginOutCode        @"10005"
//更新
#define kUpdateCode          @"-1"

//活动模块通知公告列表
#define kAnnouceList @"/rest/app/notice-list"
//公告弹框
#define kAlert @"/rest/app/bullet-box-announcement"
//注册
#define kreigster  @"/rest/user/register"
//修改密码
#define kgetFixCode  @"/rest/user/reset-pwd"
//获取个人信息列表
#define kUserInfo @"/rest/user"
//登录接口
#define kLoginUrl  @"/rest/user/login"
//刷新token
#define krefreshUrl  @"/rest/user/token"
//修改个人信息
#define kWGChangeUserInfo  @"/rest/user/modify"
//获取短信验证码
#define kgetSendCode  @"/rest/msg/sms/send"
//验证手机号
#define kgetValidateSend  @"/rest/msg/sms/validate"
//粉丝统计
#define kShopfansSum   @"/rest/user/fans/count"
//直属粉丝统计
#define kShopfansSummary  @"/rest/user/fans/summary"
//粉丝分页
//奖品列表
#define kproductList @"/rest/draw/award"

#define kShopfans     @"/rest/user/fans"
//资产明细
#define kShopAsset   @"/rest/shopkeeper/asset"
// 商品列表
#define kProductList @"/rest/product/list"
//商品详情
#define kWGProductDetail @"/rest/product"
//文章列表
#define kArticle     @"/rest/article"

//下单
#define kMakeorder @"/rest/order"
//确认下单
#define kConfirm  @"/rest/order/confirm"
//提交订单
#define ksumbit  @"/rest/order"

//任务列表
#define KWGTaskList @"/rest/task"
//任务详情
#define KWGTaskDetail @"/rest/task"
//完成任务
#define KWGTaskComplete @"/rest/task/complete"
//提交任务
#define KWGTasksubmit @"/rest/task"
//用户任务列表
#define KWGUserTaskList @"/rest/task/user"
//用户任务详情
#define KWGUserTaskListdetail @"/rest/task/user"
// 验证任务是否可完成
#define KWGVerifyTaskIdIsCompelete @"/rest/task/verify"
//继续订单
#define kContiPay  @"/rest/order/pay"
//获取APP页面模块/导航栏
#define kWGpagecomponent   @"/rest/component/comps"
//分享类，下载类任务完成接口
#define KHSShareTaskComplete @"/rest/task/submit"


//产品分类
#define kproductType   @"/rest/product/types"
//获取APP页面模块/导航栏
#define kpagecomponent   @"/rest/component/comps"
//全部分类
#define kAllTypesUrl   @"/rest/user/withdraw/type"
//注册激活
#define kActive     @"/rest/user/active"
#define kThirdPartUrl  @"/rest/user/third-party/login"
#define kThirdPartBindUrl  @"/rest/user/third-party/bind"

//pre
#define kThirdPartPrebBindUrl  @"/rest/user/third-party/pre-bind"
//商品详情
#define kProductId @"/rest/product"
//活动商品详情
#define klimetproduct @"/rest/activity/product"
//热搜
#define kHotSearch @"/rest/product/hot"
//搜索
#define kUserListUrl    @"/rest/user/shop"
//展示最新会员信息
#define kGradeInfo @"/rest/msg/upgrade"

// 优品推荐
#define kgoodRecommend @"/rest/product/type/recommend"
// 商品品牌列表
#define kProductBrandList @"/rest/product/brand"
// 商品评论
#define kCommentList @"/rest/evaluate"
//添加评论
#define kAddComment @"/rest/evaluate/add"
// 收藏/取消收藏商品
#define kProductcollect @"/rest/product/collect"
// 上下架商品
#define kProductupdown @"/rest/product/updown"
//vip商品
#define kVipProd     @"/rest/product/list/vip"

//添加商品到购物车
#define kAddshopCar @"/rest/cart"
//修改购物车商品数量
#define kshopCarChange @"/rest/cart/"
//删除购物车商品
#define kshopCarDelete @"/rest/cart/del"
// 购物车商品列表
#define kshopCarList @"/rest/cart"

//修改个人信息
#define kChangeUserInfo @"/rest/user/update"
//获取用户收货地址列表
#define kGetUserInfoAdress @"/rest/user/address"
//删除收货地址
#define kdeleteUserInfoAdress @"/rest/user/address/del"
//设置某个地址为默认收货
#define kdefaultUserInfoAdress @"/rest/user/defaultaddr"
//新增&修改用户收货地址
#define kchangeUserInfoAdress @"/rest/user/address"
//分类推荐模块banner图模块
#define kRecommendbanner @"/rest/product/type/recommend/banner"
//收藏列表
#define kuserColloctList @"/rest/product/list/collect"
// 批量删除我的收藏商品
#define kuserColloctListDelete @"/rest/product/collect/del"
//获取用户提现方式列表
#define kgetUsertxWay @"/rest/user/withdraw"
//删除用户提现方式
#define kdeleteUsertxWay @"/rest/user/withdraw/del"
//添加用户提现方式
#define kAddUsertxWay @"/rest/bank"
//添加用户提现方式
#define kEditUsertxWay @"/rest/bank/edit"
//用户提现
#define kUsertx @"/rest/user/withdraw"
//活动列表
#define klimitBuyActivityType @"/rest/activity"
//活动商品列表
#define klimitBuyActivityTypeList @"/rest/activity/product"
//奖多多商品列表
#define kPriceMoreActivity @"/rest/draw/prize/product"
//奖多多商品详情
#define kPrizeMoreDetail @"/rest/draw"
//发起奖多多,胡猜订单
#define kStartHucaiOrPrizeMore @"/rest/draw/share/list"
//订单商品详情
#define koderlistdetail @"/rest/draw/share/"
//发起活动
#define kStartActHucaiOrPrizeMore @"/rest/draw/share"
//参与活动
#define kJoinActHucaiOrPrizeMore @"/rest/draw/partake"
//狐猜商品列表
#define kHucaiproductList @"/rest/draw/guess/product"
//参加的订单列表
#define kJoinedproductList @"/rest/draw/partake/list"

//领取奖品 地址
#define kgetprizewithAress @"/rest/draw/award-info"
//领取奖品 按钮
#define kgetprizehucaiOrPrizeMore @"/rest/draw/draw-award"
//领取奖品 内容
#define kgetprizehucaiOrPrizeMoresure @"/rest/draw/pre-draw"
//领取奖品 确认收货
#define kgetPrizemakesureget @"/rest/draw/confirm-receipt"
//订单默认评价列表
#define kcommentorderList @"/rest/order/comment"
//参加的订单列表
#define kjoinedhucaiorprizemoreList @"/rest/partake/list"
//首页最新购买店主信息
#define kUpgrade  @"/rest/msg/upgrade"
//奖多多开奖
#define kprizeMoreopen  @"/rest/draw/prize"
//App 版本升级
#define KupdateVersion @"/rest/app/version"
//获取消息
#define kGetmessage @"/rest/message/list"
//未读消息数量
#define kGetmessageunread @"/rest/message/unread"
//清除未读消息
#define kcleanmessageunread @"/rest/message/clear-unread"
//回调服务器支付结果
#define kWGCallbackHostPayResult @"/rest/trade/notify"

#define kUserState  @"/rest/user/info"

#define kShopkeeper  @"/rest/shopkeeper"

//任务列表
#define kShoptask    @"/rest/shopkeeper/task"

//注册领取红包
#define kHtakered  @"/rest/user/award"

//推荐资讯
#define kHSRecomfristPage  @"/rest/article/recommend-list"



#define kShopWithdrawList  @"/rest/user/withdraw/money"

//经营数据
#define kShoporderList  @"/rest/shopkeeper/fans/order"


//新手专享
#define kHomeNewpeople  @"/rest/activity/index/product"

//新手专享
#define kfansOrderSum  @"/rest/shopkeeper/fans/order/summary"



//新人专享上部分
#define kNewDesc  @"/rest/component/index/activity"

//新人专享上部分
#define kstoreHome  @"/rest/product/list/shop"


#define kStoreInfo  @"/rest/user/shop/info"

#define kServiceInfo    @"/rest/order/customer-service/reason"

//售后
#define kServiceList    @"/rest/order/customer-service"


#define kwithdrawData    @"/rest/user/withdraw"

#define kyaoqingrecord @"/rest/shopkeeper/record/spread"

#define kbangdan       @"/rest/shopkeeper/record/summary"

//开屏广告
#define kLauchImage       @"/rest/component/advertising"

//修改店铺信息
#define kfixShop         @"/rest/user/usershop"

#define kshopmanage      @"/rest/shopkeeper/parent"


#define khsProdList      @"/rest/product"


#define khsRecommendList     @"/rest/product/recommend"

#define khsCategroyList     @"/rest/product/category"

#define khsbank              @"/rest/bank"
//文章分类
#define khsAriticetcategory    @"/rest/article/category"
//刷新文章列表
#define khsAriticetRefreshList         @"/rest/article/refresh"
//文章列表
#define khsAriticetList         @"/rest/article"
//推荐文章列表
#define khsAriticetRecomend        @"/rest/article/recommend"
//刷新推荐文章列表
#define khsAriticetRefreshRecomend        @"/rest/article/recommend/refresh"
//文章详情
#define khsAriticetDetail    @"/rest/article"
//签到信息
#define khsqiandao    @"/rest/integral/sign-in"
//签到
#define khsDoqiandao    @"/rest/integral/sign-in"
//福利任务列表
#define khsOrdinary    @"/rest/task/ordinary"
//银勺、金勺会员任务列表
#define khsVIPSVIPOrdinary    @"/rest/task"

//签到
#define khsPayList    @"/rest/order/pay-type"

//支付回调
#define khsPayReslut    @"/rest/trade/notify"

#define khsaward    @"/rest/user/award"

//验证文章是否需要进行倒计时
#define khsverifyAriticeTime    @"/rest/article/verify"
//文章倒计时结束后提交
#define khsverifyAriticeTimeOK   @"/rest/article/read"


//活动页面
#define khsWebh5 @"rest/wap/inter-router"
//支付宝支付失败调用
#define hsalipayfail   @"/rest/trade/alipay-fail"




#define khsReward     @"/rest/integral"

#define khshotAll     @"/rest/user/integral/list"

#define khshotDay     @"/rest/user/integral/day/list"

#define khshotprechange    @"/rest/user/integral/pre-exchange"


#define khshotchange    @"/rest/user/integral/exchange"

#define khsrule         @"/rest/user/rule"


#define hsAllMoney       @"/rest/user/money"



#define hsfuli        @"/rest/activity/list"


#endif /* URLDeficeine_h */
