//
//  MHMineLoginoutCell.h
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^loginout)(void);
@interface MHMineLoginoutCell : UITableViewCell
@property (nonatomic, strong)loginout LoginoutAct;
@property (nonatomic, strong) UIButton *loginout;
@end
