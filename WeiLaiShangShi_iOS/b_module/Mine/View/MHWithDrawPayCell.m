//
//  MHWithDrawPayCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHWithDrawPayCell.h"

@implementation MHWithDrawPayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        _selectBtn = [[UIButton alloc] init];
        _selectBtn.userInteractionEnabled = NO;
        [_selectBtn setBackgroundImage:kGetImage(@"ic_public_choice_unselect") forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:kGetImage(@"ic_choice_select") forState:UIControlStateSelected];
        _selectBtn.selected = NO;
        [self.contentView addSubview:_selectBtn];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(25), kRealValue(25)));
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(12));
        }];
        
        
        
        _leftImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(23), kRealValue(23)));
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(55));
        }];
        
        
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = kGetImage(@"leve_desc_arrow");
        _rightImageView.hidden = YES;
        [self.contentView addSubview:_rightImageView];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(23), kRealValue(23)));
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(16));
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"优惠券";
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(87));
        }];
        
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.text = @"绑定后可提现";
        _rightLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _rightLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:_rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-kRealValue(48));
        }];
        

        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(12), kRealValue(44) - 1/kScreenScale, kScreenWidth - kRealValue(24), 1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#E2E2E2"];
        [self.contentView addSubview:lineView];
        
        _editBtn = [[UIButton alloc]init];
        [_editBtn setTitle:@"修改" forState:0];
        _editBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        [_editBtn setTitleColor:[UIColor colorWithHexString:@"#FB6A0F"] forState:0];
        [self.contentView addSubview:_editBtn];
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(kRealValue(30), kRealValue(30)));
            make.right.equalTo(self.contentView.mas_right).with.offset(-kRealValue(12));
        }];
    }
    return self;
}

-(void)createModel:(MHWithDrawListModel *)model{
    
//    if (model.withdrawType == 1) {
//         _titleLabel.text = model.username;
//        _leftImageView.image = kGetImage(@"ic_play_play");
//    }else{
//        _titleLabel.text = [NSString stringWithFormat:@"【%@】%@",model.bankName,model.username];
//        _leftImageView.image = kGetImage(@"ic_play_unionPay");
//    }
}

@end
