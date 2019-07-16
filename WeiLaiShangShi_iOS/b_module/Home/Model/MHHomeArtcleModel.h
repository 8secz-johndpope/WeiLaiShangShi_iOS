//
//  MHHomeArtcleModel.h
//  wgts
//
//  Created by AllenQin on 2018/11/12.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHHomeArtcleModel : MHBaseModel

@property (nonatomic, strong) NSString * bigCover;
@property (nonatomic, strong) NSString * cover;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * author;
@property (nonatomic, strong) NSString * publishTime;
@end

NS_ASSUME_NONNULL_END
