//
//  MHWithDrawListModel.h
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHWithDrawListModel : MHBaseModel

@property (nonatomic, copy) NSString * bankName;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *bankSubAccount;
@property (nonatomic, copy) NSString *bankAccount;
@property (nonatomic, copy) NSString * cardCode;
@property (nonatomic, copy) NSString * username;
@property (nonatomic, assign) NSInteger cardId;
@property (nonatomic, copy) NSString * bankType;
@property (nonatomic, copy) NSString *  id;

@end

NS_ASSUME_NONNULL_END
