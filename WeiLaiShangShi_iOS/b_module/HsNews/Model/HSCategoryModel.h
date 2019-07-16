//
//  HSCategoryModel.h
//  HSKD
//
//  Created by yuhao on 2019/3/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSCategoryModel : MHBaseModel
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSString * id;
@property (nonatomic, assign) NSInteger upgrade;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, strong) NSString * code;

@end

NS_ASSUME_NONNULL_END
