//
//  MHAttractInvestCell.h
//  wgts
//
//  Created by yuhao on 2018/11/7.
//  Copyright © 2018 mhyouping. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChangePage)(NSString *code, NSString *parm);
@interface MHAttractInvestCell : UITableViewCell

@property(strong,nonatomic) UIImageView *bigimage;
@property (nonatomic, copy)ChangePage changepage;
@property(strong,nonatomic) UIImageView *smallImage1;

@property(strong,nonatomic) UIImageView *smallImage2;

@end
