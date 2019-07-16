//
//  HSTaskNormalCell.h
//  HSKD
//
//  Created by yuhao on 2019/2/28.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MHTaskDetailModel;
typedef void(^DoTask)(void);
@interface HSTaskNormalCell : UITableViewCell
@property(nonatomic, copy)DoTask dotask;
@property(nonatomic, strong)UILabel *titlelabel;
@property(nonatomic, strong)UILabel *Tasktitlelabel;
@property(nonatomic, strong)UILabel *moneylabel;
@property(nonatomic, strong)UILabel *limitlabel;
@property(nonatomic, strong)UILabel *statubtn;
@property(nonatomic, strong)UIView *lineview;
@property(nonatomic, strong)UIView *bgview;
-(void)createWithModel:(MHTaskDetailModel *)singerModel;
@end

NS_ASSUME_NONNULL_END
