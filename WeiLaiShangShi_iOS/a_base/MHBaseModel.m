//
//  MHBaseModel.m
//  mohu
//
//  Created by 余浩 on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@implementation MHBaseModel
- (instancetype)initWithDic:(NSMutableDictionary *)dic
{
    self = [super init];
    if(self) {
        [self setValuesForKeysWithDictionary:dic];
        
        
    }
    return self;
}

+ (instancetype)baseModelWithDic:(NSMutableDictionary *)dic
{
    
    id obj = [[[self class] alloc] initWithDic:dic];
    return obj ;
    
}
-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSNull class]]||[value isEqual:[NSNull null]] || value == nil) {
        
        [self setValue:@"" forKey:key];
        return;
    }
    
    [super setValue:value forKey:key];
    
}
+ (NSMutableArray *)baseModelWithArr:(NSMutableArray *)arr
{
    
    NSMutableArray *modelArr = [NSMutableArray array];
    for (NSMutableDictionary *dic in arr) {
        //       @autoreleasepool {
        
        id model = [[self class] baseModelWithDic:dic];
        
        [modelArr addObject:model];
        //       }
    }
    return modelArr;
    
}

/**
 *  kvc 容错
 *
 *  @param value value
 *  @param key   key
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.mId = value;
        
    }
    
}
@end
