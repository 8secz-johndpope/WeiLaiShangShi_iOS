//
//  FontAndColorDefine.h
//  mohu
//
//  Created by AllenQin on 2018/8/14.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#ifndef FontAndColorDefine_h
#define FontAndColorDefine_h


//苹方-简 常规体
#define kPingFangRegular    (kiOS9Later ? @"PingFang-SC-Regular" : @"HelveticaNeue-Light")
//苹方-简 极细体
#define kPingFangUltralight @"PingFangSC-Ultralight"
//苹方-简 细体
#define kPingFangLight      (kiOS9Later ? @"PingFangSC-Light" : @"HelveticaNeue-Light")
//苹方-简 纤细体
#define kPingFangThin       @"PingFangSC-Thin"
//苹方-简 中黑体
#define kPingFangMedium     (kiOS9Later ? @"PingFang-SC-Medium" : @"HelveticaNeue")
//苹方-简 中粗体
#define kPingFangSemibold   @"PingFangSC-Semibold"

//主题色
#define kThemecolor 0xF6AC19
//字体颜色
#define kCustomfontcolor 0x333333
//主题渐变色开始
#define kThemecolorStart 0xFF4D5D
//主题渐变色结束
#define kThemecolorend 0xFF3344


//背景色
#define kBackGroudColor [UIColor colorWithHexString:@"#F2F2F2"]

//
#define kfailImage  @"img_bitmap_fail"

#endif /* FontAndColorDefine_h */
