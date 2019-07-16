//
//  MHPartnersCell.h
//  wgts
//
//  Created by yuhao on 2018/11/7.
//  Copyright © 2018 mhyouping. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChangePage)(NSString *code, NSString *parm);
@interface MHPartnersCell : UITableViewCell
@property (nonatomic, copy)ChangePage changepage;
@property(strong,nonatomic) UIImageView *bigimage;

@end
