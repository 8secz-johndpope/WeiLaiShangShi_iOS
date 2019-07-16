//
//  HSTaskDetailViewViewController.h
//  HSKD
//
//  Created by yuhao on 2019/2/28.
//  Copyright © 2019 hf. All rights reserved.
//

#import "MHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSTaskDetailViewViewController : MHBaseViewController
@property(nonatomic, strong)NSString *taskId;
@property(nonatomic, strong)NSString *taskname;
@property(nonatomic, strong)NSString *comeform;
@property(nonatomic, strong)NSString *vipLever;
@property(nonatomic, strong)NSString *IsVaild;
@end

NS_ASSUME_NONNULL_END
