//
//  MHLevelSrollCell.h
//  mohu
//
//  Created by AllenQin on 2018/10/17.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHLevelRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHLevelSrollCell : UITableViewCell

@property (strong, nonatomic)  UILabel *leftTitle;
@property (strong, nonatomic)  UILabel *descTitle;
@property (strong, nonatomic)  UILabel *rightTitle;


-(void)creatModel:(MHLevelRecordModel *)model;

@end

NS_ASSUME_NONNULL_END
