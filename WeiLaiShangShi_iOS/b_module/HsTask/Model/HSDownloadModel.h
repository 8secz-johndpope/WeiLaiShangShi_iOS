//
//  HSDownloadModel.h
//  HSKD
//
//  Created by yuhao on 2019/4/14.
//  Copyright © 2019 hf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSDownloadModel : NSObject<NSCoding,NSCopying>
@property(nonatomic, strong)NSString *taskid;
@property(nonatomic, strong)NSString *usertaskId;
@property(nonatomic, strong)NSString *date;
@property(nonatomic, strong)NSString *user;
@end

NS_ASSUME_NONNULL_END
