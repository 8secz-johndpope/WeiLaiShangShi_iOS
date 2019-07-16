//
//  MHTaskDetailModel.h
//  wgts
//
//  Created by yuhao on 2018/11/15.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHTaskDetailModel : MHBaseModel
//商品规格id
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *produceName;
@property (nonatomic, strong)NSString *produceCode;
@property (nonatomic, strong)NSString *taskCode;
@property (nonatomic, strong)NSString *integral;
//任务属性  REVIEW("REVIEW", "审核任务"),
//READ("READ", "阅读任务"),
//APPOINT("APPOINT", "阅读指定任务"),
//APPOINT_ADV("APPOINT_ADV", "阅读指定广告任务"),
//READ_ADV("READ_ADV", "阅读广告任务"),
//SHARE("SHARE", "分享任务"),
//DOWNLOAD("DOWNLOAD","下载类任务"),
@property (nonatomic, strong)NSString *property;
@property (nonatomic, strong)NSString *taskName;
@property (nonatomic, strong)NSString *money;
//任务标题，当任务为置顶任务时，返回置顶任务图片
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *detail;
//任务类型，ORD：福利任务，VIP：银勺任务，SVIP：金勺任务
@property (nonatomic, strong)NSString *taskType;
@property (nonatomic, strong)NSString *taskCount;
@property (nonatomic, strong)NSString *remainCount;
@property (nonatomic, strong)NSString *power;
//是否为置顶任务，1：是，0：否
@property (nonatomic, assign)long top;
@property (nonatomic, strong)NSString *detailType;
//任务状态 PENDING：未开始，ACTIVE：进行中，AUDIT：审核中，DONE：已完成，FAILED：未达标，INVALID：已失效
@property (nonatomic, strong)NSString *status;
@property (nonatomic, strong)NSString *userTaskId;
@property (nonatomic, strong)NSString *beginTime;
@property (nonatomic, strong)NSString *endTime;
@property (nonatomic, strong)NSMutableArray *url;
//任务属性为指定任务时，存储文章id
@property (nonatomic, strong)NSString *remark;
//当任务属性为阅读时，存储的是用户阅读的文章id用逗号拼接的字符串
@property (nonatomic, strong)NSString *userTaskRemark;
//taskUrl 下载类、分享类任务跳转链接
@property (nonatomic, strong)NSString *taskUrl;
//
@property (nonatomic, strong) NSMutableArray *cover;
//
@property (nonatomic, strong)NSString *coverPos;
@end
