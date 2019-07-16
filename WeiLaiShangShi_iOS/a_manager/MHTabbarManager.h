//
//  MHTabbarManager.h
//  mohu
//
//  Created by AllenQin on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"

@interface MHTabbarManager : NSObject

@property (nonatomic, readonly, strong) CYLTabBarController *tabBarController;
@property (nonatomic, copy) NSString *context;

@end
