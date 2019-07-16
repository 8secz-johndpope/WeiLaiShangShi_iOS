//
//  MHTaskListSingerModel.h
//  wgts
//
//  Created by yuhao on 2018/11/15.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHTaskListSingerModel : MHBaseModel
@property(nonatomic, strong)NSString *id;
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *money;
@property(nonatomic, strong)NSString *produceName;
@property(nonatomic, strong)NSString *taskName;
@property(nonatomic, strong)NSString *userTaskId;
@end
