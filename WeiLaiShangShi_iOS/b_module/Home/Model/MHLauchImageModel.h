//
//  MHLauchImageModel.h
//  mohu
//
//  Created by AllenQin on 2018/10/18.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHLauchImageModel : MHBaseModel

@property (nonatomic, strong) NSString * actionUrl;
@property (nonatomic, assign) NSInteger actionUrlType;
@property (nonatomic, strong) NSString * bigImg;
@property (nonatomic, strong) NSString * normalImg;

@end

NS_ASSUME_NONNULL_END
