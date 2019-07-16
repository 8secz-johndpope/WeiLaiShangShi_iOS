//
//  MHmessageTwoCell.h
//  mohu
//
//  Created by yuhao on 2018/10/23.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHMessageModel;
@interface MHmessageTwoCell : UITableViewCell
@property (nonatomic, strong)UILabel *messagetitle;
@property (nonatomic, strong)UILabel *messagetime;
@property (nonatomic, strong)UIImageView *messageimage;
@property (nonatomic, strong)UILabel *messagecontent;
@property (nonatomic, strong)MHMessageModel *messagemodel;
@property (nonatomic, strong)UIView *bgview;
@property (nonatomic, strong) UIView *lineview;
@property (nonatomic, strong)UILabel *detallabel;
@property (nonatomic, strong) UIImageView  *prizenumrightIcon;
-(void)createAnnouceWithModel:(MHMessageModel *)model;

@end
