//
//  MHbannerCell.h
//  mohu
//
//  Created by 余浩 on 2018/9/13.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ChangePage)(NSString *code, NSString *parm);
@interface MHbannerCell : UITableViewCell
@property(nonatomic, copy)ChangePage changepage;
@property(nonatomic, strong)NSArray *bannerArr;
@property(nonatomic, strong)NSString *comeform;
@end
