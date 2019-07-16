//
//  MHTaskListModel.h
//  wgts
//
//  Created by yuhao on 2018/11/15.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHTaskListModel : MHBaseModel
@property(nonatomic, strong)NSMutableArray *list;
@property(nonatomic, strong)NSString *taskType;
@property(nonatomic, strong)NSString *count;
@property(nonatomic, strong)NSString *totalCount;
@end
