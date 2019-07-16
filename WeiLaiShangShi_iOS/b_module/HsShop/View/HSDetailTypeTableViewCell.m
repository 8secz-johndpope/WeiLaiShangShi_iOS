//
//  HSDetailTypeTableViewCell.m
//  HSKD
//
//  Created by AllenQin on 2019/2/27.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSDetailTypeTableViewCell.h"

@implementation HSDetailTypeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        self.jifenLabel  = [[UILabel alloc]init];
        self.jifenLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
        self.jifenLabel.textColor =[UIColor colorWithHexString:@"#FF273F"];
        self.jifenLabel.numberOfLines = 1;
        self.jifenLabel.text =  @"  ";
        [self.contentView addSubview:self.jifenLabel];
        [self.jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(kRealValue(11));
            make.left.equalTo(self.mas_left).with.offset(kRealValue(13));
            
        }];
        
        
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        self.nameLabel .textColor =[UIColor colorWithHexString:@"#222222"];
        self.nameLabel .numberOfLines = 2;
        self.nameLabel.text =  @"象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲";
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.jifenLabel.mas_bottom).with.offset(kRealValue(10));
            make.left.equalTo(self.mas_left).with.offset(kRealValue(13));
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(13));
        }];
        
        
        self.descLabel = [[UILabel alloc]init];
        self.descLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        self.descLabel .textColor =[UIColor colorWithHexString:@"#666666"];
        self.descLabel .numberOfLines = 1;
        self.descLabel.text =  @"象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲";
        [self.contentView addSubview:self.descLabel];
        [self.descLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).with.offset(kRealValue(5));
            make.left.equalTo(self.mas_left).with.offset(kRealValue(13));
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(13));
        }];
        
        
        self.numLabel = [[UILabel alloc]init];
        self.numLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        self.numLabel .textColor =[UIColor colorWithHexString:@"#444444"];
        self.numLabel .numberOfLines = 1;
        self.numLabel.text =  @"ddddssdf";
        [self.contentView addSubview:self.numLabel];
        [self.numLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.jifenLabel.mas_bottom).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(13));
        }];
        
 
        
        
    }
    
    return self;
}


- (void)creatItemModel:(HSShopDeatilModel *)model{
    
    self.nameLabel.text = model.productName;
    self.jifenLabel.text = [NSString stringWithFormat:@"%@积分",model.retailPrice];
    self.numLabel.text = [NSString stringWithFormat:@"已兑换%ld份",model.sellCount];
    self.descLabel.text = [NSString stringWithFormat:@"%@",model.productSubtitle];
    
}
@end
