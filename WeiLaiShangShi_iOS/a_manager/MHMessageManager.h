//
//  MHMessageManager.h
//  Stonedata
//
//  Created by yuhao on 2019/7/10.
//  Copyright © 2019 hf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
NS_ASSUME_NONNULL_BEGIN


typedef void(^sendMsg)(NSString *Msgdata , NSString *topic);
@interface MHMessageManager : NSObject
@property(nonatomic, copy)sendMsg getmsg;
-(instancetype)initWithTopic:(NSString *)str;


@end

NS_ASSUME_NONNULL_END
