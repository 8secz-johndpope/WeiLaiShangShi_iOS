//
//  JKCityPickViewController.h
//  地区选择器封装
//
//  Created by yuhao on 2017/3/6.
//  Copyright © 2017年 uhqsh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^__actionBlock)(NSString *address, NSString *province,NSString *city,NSString *area);
@interface JKCityPickViewController : UIViewController

+ (instancetype)showPickerInViewController:(UIViewController *)vc
                               selectBlock:(__actionBlock)block ;
@end
