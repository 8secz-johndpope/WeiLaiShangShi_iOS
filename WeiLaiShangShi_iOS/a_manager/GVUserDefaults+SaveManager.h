//
//  GVUserDefaults+SaveManager.h
//  mohu
//
//  Created by AllenQin on 2018/8/15.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "GVUserDefaults.h"

@interface GVUserDefaults (SaveManager)

@property (nonatomic, weak) NSString *accessToken;
@property (nonatomic, weak) NSString *refreshToken;
@property (nonatomic, weak) NSString *userRole;
@property (nonatomic, weak) NSString *phone;
@property (nonatomic, weak) NSString *hostName;
@property (nonatomic, weak) NSString *hostWapName;
@property (nonatomic, weak) NSString *isPrivacy;
@property (nonatomic, weak) NSString *shenghe;
@property (nonatomic, weak) NSString *ShowAppUpdateAlert;
@property (nonatomic, weak) NSString *ShowRedMoney;
@property (nonatomic, weak) NSString *firstPageSelect;
@property (nonatomic, weak) NSString *ShowYaoqingalert;
@property (nonatomic, weak) NSString *Showshenjialert;
@property (nonatomic, weak) NSString *ShowAppUpdateWithCode;
@property (nonatomic, strong) NSMutableArray *downloadArr;
@property (nonatomic, strong) NSArray *areaList;
@property (nonatomic, strong) NSArray *bankCode;
@property (nonatomic, weak) NSString *ShowBreakStatuWithCode;
@end
