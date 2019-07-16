//
//  MHOrderDetailTableViewCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/11.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHOrderDetailTableViewCell.h"

@implementation MHOrderDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(5), kScreenWidth-kRealValue(32), kRealValue(100))];
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius =kRealValue(9);
        [bgView shadowPathWith:[UIColor colorWithHexString:@"756A4B" andAlpha:.15] shadowOpacity:1 shadowRadius:kRealValue(5) shadowSide:MHShadowPathMohu shadowPathWidth:2];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        _leftImageView = [[UIImageView alloc] init];
//        _leftImageView.backgroundColor = kRandomColor;
        [bgView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(80), kRealValue(80)));
            make.centerY.equalTo(bgView.mas_centerY).with.offset(0);
            make.left.equalTo(bgView.mas_left).with.offset(0);
        }];
        
        _titlesLabel = [[UILabel alloc]init];
        _titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _titlesLabel.textColor =[UIColor colorWithHexString:@"000000"];
        _titlesLabel.text  = @"美妆蛋beautyblender化妆海绵";
        _titlesLabel.numberOfLines = 1;
        [bgView addSubview:_titlesLabel];
        [_titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftImageView.mas_top).with.offset(-kRealValue(2));
            make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(9));
            make.width.mas_equalTo(kRealValue(233));
        }];
        
        _saleLabel = [[UILabel alloc]init];
        _saleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _saleLabel.textColor =[UIColor colorWithHexString:@"666666"];
        _saleLabel.text  = @"25ml/白色";
        [bgView addSubview:_saleLabel];
        [_saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(-kRealValue(8));
            make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(9));
        }];
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        _priceLabel.textColor =[UIColor colorWithHexString:@"000000"];
        _priceLabel.text  = @"¥171";
        [bgView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.leftImageView.mas_bottom).with.offset(0);
            make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(9));
        }];
        
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _numberLabel.textColor =[UIColor colorWithHexString:@"999999"];
        _numberLabel.text  = @"x1";
        [bgView addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.leftImageView.mas_bottom).with.offset(0);
            make.right.equalTo(bgView.mas_right).with.offset(-kRealValue(10));
        }];
        
        
    }
    
    return self;
}

-(void)setDataDict:(NSDictionary *)dataDict{
    _dataDict  = dataDict;
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:dataDict[@"productSmallImage"]] placeholderImage:kGetImage(@"zhanwei")];
    _titlesLabel.text = dataDict[@"productName"];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",dataDict[@"productPrice"]];
    _saleLabel.text = dataDict[@"productStandard"];
    _numberLabel.text  = [NSString stringWithFormat:@"x%@",dataDict[@"productCount"]];
}
@end

