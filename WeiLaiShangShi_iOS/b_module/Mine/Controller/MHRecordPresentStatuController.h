//
//  MHRecordPresentStatuController.h
//  mohu
//
//  Created by yuhao on 2018/10/10.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"
#import "MHWithDrawRecordModel.h"

@interface MHRecordPresentStatuController : MHBaseViewController

@property (nonatomic, strong)UILabel *applytitle;
@property (nonatomic, strong)UILabel *applySubtitle;
@property (nonatomic, strong)UILabel *applySubtime;
@property (nonatomic, strong)UILabel *noticetitle;
@property (nonatomic, strong)UILabel *noticeSubtitle;
@property (nonatomic, strong)UILabel *noticeSubtime;
@property (nonatomic, strong)MHWithDrawRecordModel *model;
@property (nonatomic, copy)NSString  *rootStr;

@end
