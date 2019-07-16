//
//  MHPageItemModel.h
//  mohu
//
//  Created by 余浩 on 2018/9/18.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHPageItemModel : MHBaseModel
@property(copy,nonatomic) NSString * name;
@property(copy,nonatomic) NSString * sourceUrl;
@property(copy,nonatomic) NSString * actionUrl;
@property(copy,nonatomic) NSString * typeId;
@property(copy,nonatomic) NSString * typeName;
@property(copy,nonatomic) NSString * typeImage;
@property(copy,nonatomic) NSString * id;
@property(assign,nonatomic) NSInteger  sort;
@property(assign,nonatomic) Boolean  visible;
@property(assign,nonatomic) NSInteger  actionUrlType;
@property(nonatomic, strong) NSString *link;
@property(nonatomic, strong) NSString *bannerUrl;
@property(assign,nonatomic) NSInteger  linkType;
@end
