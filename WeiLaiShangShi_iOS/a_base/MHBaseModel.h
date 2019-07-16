//
//  MHBaseModel.h
//  mohu
//
//  Created by 余浩 on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHBaseModel : NSObject

- (instancetype)initWithDic:(NSMutableDictionary *)dic;
+ (instancetype)baseModelWithDic:(NSMutableDictionary *)dic;
+ (NSMutableArray *)baseModelWithArr:(NSMutableArray *)arr;
@property (nonatomic,copy)NSString *mId;
@end
