//
//  JKCityPickModel.m
//  地区选择器封装
//
//  Created by yuhao on 2017/3/6.
//  Copyright © 2017年 uhqsh. All rights reserved.
//

#import "JKCityPickModel.h"
@implementation JKCityPickModel
- (void)configWithDic:(NSDictionary *)dic {
    
}
@end

@implementation LZProvince

- (void)configWithDic:(NSDictionary *)dic {
    
    NSArray *citys = [dic allKeys];
    
    NSMutableArray *tmpCitys = [NSMutableArray arrayWithCapacity:citys.count];
    for (NSString *tmp in citys) {
        
        LZCity *city = [[LZCity alloc]init];
        city.name = tmp;
        city.province = self.name;
        NSArray *area = [dic objectForKey:tmp];
        
        [city configWithArr:area];
        [tmpCitys addObject:city];
        
    }
    
    self.cities = [tmpCitys copy];
}
@end

@implementation LZCity

- (void)configWithArr:(NSArray *)arr {
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSString *tmp in arr) {
        
        LZArea *area = [[LZArea alloc]init];
        area.name = tmp;
        area.province = self.province;
        area.city = self.name;
        [array addObject:area];
    }
    
    self.areas = [array copy];
}
@end

@implementation LZArea

@end
