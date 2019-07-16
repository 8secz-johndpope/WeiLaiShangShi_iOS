//
//  HSChargeTableCell.h
//  HSKD
//
//  Created by AllenQin on 2019/3/14.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSHotAllModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSChargeTableCell : UITableViewCell

@property(nonatomic, strong)NSArray *hotAllList;
@property(nonatomic, strong)NSArray *hotDayList;
@property (nonatomic, strong) UISegmentedControl *segment;
@property(nonatomic, assign)NSInteger segmentIndex;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hotAllList:(NSArray *)hotAllList hotDayList:(NSArray *)hotDayList;

@end

NS_ASSUME_NONNULL_END
