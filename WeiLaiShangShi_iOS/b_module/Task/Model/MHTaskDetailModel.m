//
//  MHTaskDetailModel.m
//  wgts
//
//  Created by yuhao on 2018/11/15.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTaskDetailModel.h"

@implementation MHTaskDetailModel
-(void)setCover:(NSMutableArray *)cover
{
    if ([cover isKindOfClass:[NSString class]]) {
        return;
    }else{
        MHLog(@"1");
        _cover = cover;
    }
}
@end
