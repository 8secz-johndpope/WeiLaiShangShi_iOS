//
//  MHMineItemCell.h
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHMineitemView.h"
typedef void(^MHMineManagerCelltapact)(NSInteger tag);
@interface MHMineItemCell : UITableViewCell
@property (nonatomic, copy)MHMineManagerCelltapact tapAct;
@property(nonatomic, strong)MHMineitemView * itemview;
@property(nonatomic, strong)UIView *bgview;
@end
