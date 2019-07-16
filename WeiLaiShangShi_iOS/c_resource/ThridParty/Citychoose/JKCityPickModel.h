//
//  JKCityPickModel.h
//  地区选择器封装
//
//  Created by yuhao on 2017/3/6.
//  Copyright © 2017年 uhqsh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKCityPickModel : NSObject


@property (nonatomic, copy) NSString* name;
@end

@interface LZProvince : JKCityPickModel

@property (nonatomic, strong) NSArray *cities;
- (void)configWithDic:(NSDictionary *)dic;
@end

@interface LZCity : JKCityPickModel

@property (nonatomic, copy) NSString *province;
@property (nonatomic, strong) NSArray *areas;
- (void)configWithArr:(NSArray *)arr;
@end

@interface LZArea : JKCityPickModel

//@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;

@end
