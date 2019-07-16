//
//  MHTaskTwoCell.h
//  wgts
//
//  Created by yuhao on 2018/11/9.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHTaskListSingerModel;

typedef void(^DoTask)(void);
@interface MHTaskTwoCell : UITableViewCell
@property(nonatomic, copy)DoTask dotask;
@property(nonatomic, strong)UILabel *titlelabel;
@property(nonatomic, strong)UILabel *Tasktitlelabel;
@property(nonatomic, strong)UILabel *moneylabel;
@property(nonatomic, strong)UIButton *statubtn;
@property(nonatomic, strong)UIView *lineview;
@property(nonatomic, strong)MHTaskListSingerModel *singerModel;
-(void)createWithModel:(MHTaskListSingerModel *)model;
@end
