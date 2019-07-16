//
//  HSShopTableViewCell.m
//  HSKD
//
//  Created by AllenQin on 2019/2/26.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSShopTableViewCell.h"

@implementation HSShopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        self.nameLabel .textColor =[UIColor colorWithHexString:@"#666666"];
        self.nameLabel .numberOfLines = 1;
        self.nameLabel.text =  @"象印电饭煲";
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(kRealValue(13));
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
        }];
        
        
        self.descLabel = [[UILabel alloc]init];
        self.descLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        self.descLabel .textColor =[UIColor colorWithHexString:@"#222222"];
        self.descLabel .numberOfLines = 1;
        self.descLabel.text =  @"象印电饭煲象";
        [self.contentView addSubview:self.descLabel];
        [self.descLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(kRealValue(86));
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
        }];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(11), kRealValue(44) - 1/kScreenScale, kScreenWidth - kRealValue(11), 1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        [self.contentView addSubview:lineView];
        
        
    }
    
    return self;
}


@end
