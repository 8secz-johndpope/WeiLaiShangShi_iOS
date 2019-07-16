//
//  MHMineuserAddress.h
//  mohu
//
//  Created by yuhao on 2018/10/4.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHMineuserAddress : MHBaseModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString * detail;
@property (nonatomic, copy) NSString * state;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString * details;
@property (nonatomic, copy) NSString * userPhone;
@property (nonatomic, copy) NSString * addressId;

//是否是默认
@end
