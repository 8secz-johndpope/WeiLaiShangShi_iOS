//
//  MHMineUserAddressCell.h
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHMineuserAddress;


typedef void(^deleteAddress)(NSInteger index);
typedef void(^editAddress)(NSInteger index);
typedef void(^setdefaultAddress)(NSInteger index);

@interface MHMineUserAddressCell : UITableViewCell
@property (nonatomic, copy)deleteAddress deleteAct;
@property (nonatomic, copy)editAddress editAct;
@property (nonatomic, copy)setdefaultAddress setdefaultAct;
@property (nonatomic, strong)UILabel *namelabel;
@property (nonatomic, strong)UILabel *userphone;
@property (nonatomic, strong)UILabel *userAddress;
@property (nonatomic, strong)UIButton *selelctBtn;
@property (nonatomic, strong)UIButton *editBtn;
@property (nonatomic, strong)UIButton *deleteBtn;
@property (nonatomic, strong)MHMineuserAddress *adressModel;
@end
