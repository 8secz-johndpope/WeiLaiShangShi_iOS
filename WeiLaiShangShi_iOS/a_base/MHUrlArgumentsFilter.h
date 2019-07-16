//
//  MHUrlArgumentsFilter.h
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKNetworkConfig.h"
#import "YTKBaseRequest.h"

@interface MHUrlArgumentsFilter : NSObject<YTKUrlFilterProtocol>

+ (MHUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

@end
