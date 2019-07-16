//
//  MHMessageModel.h
//  mohu
//
//  Created by yuhao on 2018/10/23.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHMessageModel : MHBaseModel
@property (nonatomic, strong) NSString * messageType;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * messageTime;
@property (nonatomic, strong) NSString* coverPlan;
@property (nonatomic, strong) NSString * contentType;
@property (nonatomic, strong) NSString* imgList;
@property (nonatomic, strong) NSString* subTitle;
@property (nonatomic, strong) NSString* startTime;
@property (nonatomic, strong) NSString* state;
@property (nonatomic, strong) NSString* id;
@property (nonatomic, assign) BOOL canJump;
@end
