//
//  MHNewerActCell.h
//  mohu
//
//  Created by 余浩 on 2018/9/13.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChangePage)(NSString *code, NSString *parm);
@interface MHNewerActCell : UITableViewCell
@property (nonatomic, copy)ChangePage changepage;
@property (nonatomic, strong) UILabel *title;
@property(nonatomic, strong) NSMutableArray *NewActArr;
@end
