//
//  HSBannerModel.h
//  HSKD
//
//  Created by yuhao on 2019/4/12.
//  Copyright © 2019 hf. All rights reserved.
//

#import "MHBaseModel.h"
#import "HSBannerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HSBannerModel : MHBaseModel<NSCoding,NSCopying>
@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * sourceUrl;
@property (nonatomic, strong) NSString * actionUrl;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * actionUrlType;
@property (nonatomic, strong) NSString * visible;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * contentType;
@property (nonatomic, strong) NSString * action_url;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * uerphone;
@property (nonatomic, strong) NSString * bulletBoxFilling;
@property (nonatomic, strong) NSString * bulletBoxType;
@property (nonatomic, strong) NSString * statu;
@property (nonatomic, strong) NSString * onlyPopUpOnce;
@end

NS_ASSUME_NONNULL_END
