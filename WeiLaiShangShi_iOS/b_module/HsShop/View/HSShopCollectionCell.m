//
//  HSShopCollectionCell.m
//  HSKD
//
//  Created by AllenQin on 2019/2/26.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSShopCollectionCell.h"

@implementation HSShopCollectionCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        ViewRadius(self, kRealValue(8))
        self.backGroudImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(170), kRealValue(170))];
//        self.backGroudImageView.backgroundColor = kRandomColor;
        [self.contentView addSubview:self.backGroudImageView];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        self.nameLabel .textColor =[UIColor colorWithHexString:@"#333333"];
        self.nameLabel .numberOfLines = 2;
//        nameLabel.text =  @"象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲";
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backGroudImageView.mas_bottom).with.offset(kRealValue(10));
            make.left.equalTo(self.backGroudImageView.mas_left).with.offset(kRealValue(13));
            make.right.equalTo(self.backGroudImageView.mas_right).with.offset(-kRealValue(13));
        }];
        
        self.jifenLabel  = [[UILabel alloc]init];
        self.jifenLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        self.jifenLabel.textColor =[UIColor colorWithHexString:@"#FF273F"];
        self.jifenLabel.numberOfLines = 1;
//        self.jifenLabel.text =  @"5000积分";
        [self.contentView addSubview:self.jifenLabel];
        [self.jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).with.offset(-kRealValue(15));
            make.left.equalTo(self.backGroudImageView.mas_left).with.offset(kRealValue(13));
            make.width.mas_equalTo(kRealValue(170));
        }];
        
        
    }
    return self;
}

- (void)creatItemModel:(HSShopItemModel *)model{
    
    [self.backGroudImageView sd_setImageWithURL:[NSURL URLWithString:model.productSmallImage] placeholderImage:kGetImage(@"emty_fang")];
    self.nameLabel.text = model.productName;
    self.jifenLabel.text = [NSString stringWithFormat:@"%@积分",model.retailPrice];
}

@end
