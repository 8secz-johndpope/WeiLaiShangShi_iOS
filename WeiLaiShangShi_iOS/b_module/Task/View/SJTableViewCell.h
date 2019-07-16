//
//  SJTableViewCell.h
//  SJVideoPlayer
//
//  Created by 畅三江 on 2018/9/30.
//  Copyright © 2018 畅三江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJPlayView.h"

NS_ASSUME_NONNULL_BEGIN
@class HSNewsModel;
@interface SJTableViewCell : UITableViewCell
+ (SJTableViewCell *)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)UILabel *typelabel;
@property(nonatomic,strong)UILabel *authlabel;
@property(nonatomic,strong)UILabel *timelabel;
@property(nonatomic,strong)UIView *lineview;
@property (nonatomic, strong, readonly) SJPlayView *view;
-(void)createviewWithModel:(HSNewsModel *)createmodel;
@end
NS_ASSUME_NONNULL_END
