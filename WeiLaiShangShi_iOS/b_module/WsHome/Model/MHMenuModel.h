//
//  MUMenuModel.h
//  mohu
//
//  Created by AllenQin on 2018/9/8.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHMenuModel : NSObject

#pragma mark - 属性

@property(assign,nonatomic) NSInteger typeId;//菜单ID
@property(copy,nonatomic) NSString * typeName;//菜单名
@property(copy,nonatomic) NSString * typeImage;//菜单图片名
/**
 *  下一级菜单
 */
@property(strong,nonatomic) NSArray * nextArray;

/**
 *  菜单层数
 */
@property(assign,nonatomic) NSInteger meunNumber;
@property(assign,nonatomic) float offsetScorller;
#pragma mark - 方法
#pragma mark 根据字典初始化对象
-(MHMenuModel *)initWithDictionary:(NSDictionary *)dic;

#pragma mark 初始化对象（静态方法）
+(MHMenuModel *)statusWithDictionary:(NSDictionary *)dic;

@end
