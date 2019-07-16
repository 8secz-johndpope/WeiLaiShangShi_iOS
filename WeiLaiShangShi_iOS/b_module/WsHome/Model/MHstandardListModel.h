//
//  MHstandardListModel.h
//  mohu
//
//  Created by yuhao on 2018/9/26.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHstandardListModel : MHBaseModel
//属性名id
@property (nonatomic, strong)NSString *attributeId;
//属性名称
@property (nonatomic, strong)NSString *attributeName;
//数组
@property (nonatomic, strong)NSMutableArray *arrtriuteArr;
@end
