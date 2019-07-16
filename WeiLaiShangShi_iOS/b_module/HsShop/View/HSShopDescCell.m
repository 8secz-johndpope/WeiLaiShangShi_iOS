//
//  HSShopDescCell.m
//  HSKD
//
//  Created by AllenQin on 2019/2/27.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSShopDescCell.h"

@implementation HSShopDescCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        self.descLabel = [[UILabel alloc]init];
        self.descLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        self.descLabel .textColor =[UIColor colorWithHexString:@"#666666"];
        self.descLabel .numberOfLines = 0;
//        self.descLabel.text =  @"象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲";
        [self.contentView addSubview:self.descLabel];
        [self.descLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(kRealValue(10));
            make.left.equalTo(self.mas_left).with.offset(kRealValue(13));
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(13));
        }];
        
        
        
    }
    
    return self;
}

- (void)creatItemModel:(HSShopDeatilModel *)model{;
    self.descLabel.text = [NSString stringWithFormat:@"%@",model.parameter];
    
}

@end
