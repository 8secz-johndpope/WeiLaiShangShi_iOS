//
//  HSAddressCell.h
//  HSKD
//
//  Created by yuhao on 2019/3/4.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHMineuserAddress;
NS_ASSUME_NONNULL_BEGIN

typedef void(^tap1)(void);
typedef void(^tap2)(void);
@interface HSAddressCell : UITableViewCell
@property(nonatomic, strong)UILabel *ReceviceName;
@property(nonatomic, strong)UILabel *defaultlabel;
@property(nonatomic, strong)UILabel *phoneLabel;
@property(nonatomic, strong)UILabel *reviceTitle;
@property(nonatomic, strong)UILabel *revicedetail;
@property(nonatomic, strong)UIImageView *rightImage;
@property(nonatomic, strong)UIView *lineview;
@property(nonatomic, strong)tap1 Tap1;
@property(nonatomic, strong)tap2 Tap2;
@property (nonatomic, strong)MHMineuserAddress *adressModel;
-(void)createCellWithModel:(MHMineuserAddress *)model;
@end

NS_ASSUME_NONNULL_END
