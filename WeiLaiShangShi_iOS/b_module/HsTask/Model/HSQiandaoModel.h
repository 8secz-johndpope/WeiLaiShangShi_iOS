//
//  HSQiandaoModel.h
//  HSKD
//
//  Created by yuhao on 2019/3/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSQiandaoModel : MHBaseModel
@property(nonatomic, strong)NSString *integral;
@property(nonatomic, assign)NSInteger signIn;
@property(nonatomic, assign)NSInteger days;
@end

NS_ASSUME_NONNULL_END
