//
//  HSNewsOneCellRight.h
//  HSKD
//
//  Created by yuhao on 2019/4/17.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HSNewsModel;
@interface HSNewsOneCellRight : UITableViewCell
@property(nonatomic,strong)UILabel *Toplabel;
@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)UILabel *typelabel;
@property(nonatomic,strong)UILabel *authlabel;
@property(nonatomic,strong)UILabel *timelabel;
@property(nonatomic,strong)UIView *lineview;
@property(nonatomic,strong)UIImageView *image;
-(void)createviewWithModel:(HSNewsModel *)createmodel;
@end

NS_ASSUME_NONNULL_END
