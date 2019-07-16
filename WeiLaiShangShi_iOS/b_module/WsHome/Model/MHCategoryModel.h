//
//  MHCategoryModel.h
//  mohu
//
//  Created by 余浩 on 2018/9/18.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHCategoryModel : MHBaseModel
@property(copy,nonatomic) NSString * typeId;
@property(copy,nonatomic) NSString * typeName;
@property(copy,nonatomic) NSString * categoryName;
@property(copy,nonatomic) NSString * id;
@end
