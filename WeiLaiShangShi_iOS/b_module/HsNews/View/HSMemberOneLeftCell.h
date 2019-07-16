//
//  HSMemberOneLeftCell.h
//  HSKD
//
//  Created by yuhao on 2019/4/10.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MHTaskDetailModel;
@interface HSMemberOneLeftCell : UITableViewCell
@property(nonatomic,strong)UILabel *Toplabel;
@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)UILabel *typelabel;
@property(nonatomic,strong)UILabel *authlabel;
@property(nonatomic,strong)UILabel *timelabel;
@property(nonatomic,strong)UIView *lineview;
@property(nonatomic,strong)UIImageView *image;
@property(nonatomic,strong)UIImageView *imagemoney;
@property(nonatomic,strong)UILabel *firstlabel;
@property(nonatomic,strong)UIImageView *statuimage3;
-(void)createviewWithModel:(MHTaskDetailModel *)createmodel;
@end

NS_ASSUME_NONNULL_END
