//
//  HSRewardTableViewCell.h
//  HSKD
//
//  Created by AllenQin on 2019/3/12.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSRewardTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *textsLabel;
@property (nonatomic, strong)UILabel *RecordPresentname;
@property (nonatomic, strong)UILabel *RecordPresenttime;
@property (nonatomic, strong)UILabel *RecordPresentcardnum;
@property (nonatomic, strong)UILabel *RecordPresentstate;

@end

NS_ASSUME_NONNULL_END
