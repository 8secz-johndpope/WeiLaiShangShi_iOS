//
//  HSNewsModel.h
//  HSKD
//
//  Created by yuhao on 2019/3/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import "MHBaseModel.h"
#import "HSNewsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HSNewsModel : MHBaseModel

@property (nonatomic, assign) NSString * id;
@property (nonatomic, assign) NSInteger readTime;
@property (nonatomic, strong) NSString * author;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSMutableArray *cover;
@property (nonatomic, strong) NSString * bigCover;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * source;
@property (nonatomic, strong) NSString * articleType;
@property (nonatomic, strong) NSString * tag;
@property (nonatomic, assign) NSInteger top;
@property (nonatomic, strong) NSMutableDictionary *extra;
@property (nonatomic, strong) NSString * coverPos;
@property (nonatomic, assign) NSInteger advIndex;
@end

NS_ASSUME_NONNULL_END
