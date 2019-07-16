//
//  HSNewTwoCell.h
//  HSKD
//
//  Created by yuhao on 2019/2/25.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HSNewsModel;
@interface HSNewTwoCell : UITableViewCell
@property(nonatomic,strong)UILabel *Toplabel;
@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)UILabel *typelabel;
@property(nonatomic,strong)UILabel *authlabel;
@property(nonatomic,strong)UILabel *timelabel;
@property(nonatomic,strong)UIView *lineview;
@property(nonatomic,strong)UIImageView *image1;
@property(nonatomic,strong)UIImageView *image2;
@property(nonatomic,strong)UIImageView *image3;
-(void)createviewWithModel:(HSNewsModel *)createmodel;
@end

NS_ASSUME_NONNULL_END
