//
//  HSDTCell.m
//  HSKD
//
//  Created by AllenQin on 2019/5/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSDTCell.h"

@implementation HSDTCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.bgView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(15),kRealValue(15),kRealValue(116) , kRealValue(65))];
        self.bgView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_bgView];
        
        self.title = [[UILabel alloc] init];
        self.title.text = @"友力值是的";
        self.title.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(15)];
        self.title.textColor = [UIColor colorWithHexString:@"#222222"];
        self.title.numberOfLines = 2;
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView.mas_top).offset(0);
            make.left.equalTo(self.bgView.mas_right).offset(kRealValue(9));
            make.width.mas_equalTo(kRealValue(209));
        }];
        
        
        self.datetitle = [[UILabel alloc] init];
        self.datetitle.text = @"2019-02-01";
        self.datetitle.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(11)];
        self.datetitle.textColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview:self.datetitle];
        [self.datetitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bgView.mas_bottom).offset(0);
            make.left.equalTo(self.bgView.mas_right).offset(kRealValue(9));
        }];
        
        UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(94), kRealValue(345), 1)];
        topLine.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        [self.contentView addSubview:topLine];

    }
    return self;
}
@end
