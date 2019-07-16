//
//  MUMenuModel.m
//  mohu
//
//  Created by AllenQin on 2018/9/8.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHMenuModel.h"

@implementation MHMenuModel

#pragma mark 根据字典初始化对象
-(MHMenuModel *)initWithDictionary:(NSDictionary *)dic{
    if (self==[self init]) {
        self.typeId = [dic[@"typeId"] intValue];
        self.typeName = dic[@"typeName"];
    }
    return self;
}

#pragma mark 初始化对象（静态方法）
+(MHMenuModel *)statusWithDictionary:(NSDictionary *)dic{
    MHMenuModel *categoryMeun=[[MHMenuModel alloc]initWithDictionary:dic];
    return categoryMeun;
}

@end
