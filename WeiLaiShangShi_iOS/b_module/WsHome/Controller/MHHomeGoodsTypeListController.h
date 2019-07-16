//
//  MHHomeGoodsTypeListController.h
//  mohu
//
//  Created by 余浩 on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHHomeGoodsTypeListController : MHBaseViewController

- (instancetype)initWithTypeId:(NSString *)typeId parentID:(NSString *)parentID;
@property (nonatomic, strong)NSString *typeId;
@property (nonatomic, strong)NSString *parentID;
@property (nonatomic, strong)NSString *navtitle;
@end
