//
//  MHProductPicModel.h
//  mohu
//
//  Created by yuhao on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHProductPicModel : MHBaseModel
//图片地址
@property (nonatomic, strong)NSString *filePath;
//宽度
@property (nonatomic, strong)NSString *width;
//高度
@property (nonatomic, strong)NSString *height;
@end
