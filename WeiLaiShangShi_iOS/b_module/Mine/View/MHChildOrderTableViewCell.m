//
//  MHChildOrderTableViewCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/11.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHChildOrderTableViewCell.h"
#import "MHCustomerServiceVC.h"
//#import "MHMineProductCommentController.h"
#import "MHContinuePayVC.h"

#define PADDING 0

@implementation MHChildOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            
            self.backgroundColor = [UIColor clearColor];
            _bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(12), kRealValue(10), kScreenWidth - kRealValue(24), kRealValue(174))];
            _bgView.backgroundColor = [UIColor whiteColor];
            ViewRadius(_bgView, kRealValue(5));
            [self addSubview:_bgView];
            
            UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(20), kRealValue(43), kRealValue(311), 1/kScreenScale)];
            lineView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
            [_bgView addSubview:lineView];
            
            
            _leftImageView = [[UIImageView alloc] init];
//            _leftImageView.backgroundColor = kRandomColor;
            [_bgView addSubview:_leftImageView];
            [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kRealValue(60), kRealValue(60)));
                make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(56));
                make.left.equalTo(_bgView.mas_left).with.offset(kRealValue(22));
            }];
            
            _titlesLabel = [[UILabel alloc]init];
            _titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
            _titlesLabel.textColor =[UIColor colorWithHexString:@"#222222"];
            _titlesLabel.text  = @"美妆蛋beautyblender化妆海绵";
            _titlesLabel.numberOfLines = 2;
            [_bgView addSubview:_titlesLabel];
            [_titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.leftImageView.mas_top).with.offset(0);
                make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(12));
                make.width.mas_equalTo(kRealValue(231));
                
            }];


            
            
            _dingdanLabel = [[UILabel alloc]init];
            _dingdanLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
            _dingdanLabel.textColor =[UIColor colorWithHexString:@"#333333"];
           
            _dingdanLabel.numberOfLines = 1;
            [_bgView addSubview:_dingdanLabel];
            [_dingdanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_bgView.mas_top).with.offset(0);
                make.left.equalTo(_bgView.mas_left).with.offset(kRealValue(10));
                make.width.mas_equalTo(kRealValue(210));
                 make.height.mas_equalTo(kRealValue(38));
            }];
            
            _stateLabel = [[UILabel alloc]init];
            _stateLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
            _stateLabel.textColor =[UIColor colorWithHexString:@"#E82C2C"];
//            _stateLabel.text  = @"待发货";
            _stateLabel.textAlignment = NSTextAlignmentRight;
            [_bgView addSubview:_stateLabel];
            [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_bgView.mas_top).with.offset(0);
                make.right.equalTo(_bgView.mas_right).with.offset(-kRealValue(10));
                make.width.mas_equalTo(kRealValue(100));
                make.height.mas_equalTo(kRealValue(38));
            }];
            
            
//            _priceLabel = [[RichStyleLabel alloc]init];
//            _priceLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
//            _priceLabel.textColor =[UIColor colorWithHexString:@"#6E6E6E"];
////            _priceLabel.text  = @"¥171";
//            _priceLabel.textAlignment = NSTextAlignmentRight;
//            [_bgView addSubview:_priceLabel];
//            [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(114));
//                make.right.equalTo(_bgView.mas_right).with.offset(-kRealValue(10));
//            }];
//
//            _numberLabel = [[UILabel  alloc]init];
//            _numberLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//            _numberLabel.text = @"x1";
//            _numberLabel.textColor =[UIColor colorWithHexString:@"#666666"];
//            [_bgView addSubview:_numberLabel];
//            [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(self.leftImageView.mas_bottom).with.offset(0);
//                make.right.equalTo(_bgView.mas_right).with.offset(-kRealValue(15));
//            }];
//
            

//
//            _moneyLabel = [[UILabel alloc]init];
//            _moneyLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//            _moneyLabel.textColor =[UIColor colorWithHexString:@"#666666"];
////            _moneyLabel.text  = @"995元";
//            [_bgView addSubview:_moneyLabel];
//            [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(self.leftImageView.mas_centerY).with.offset(0);
//                make.right.equalTo(_bgView.mas_right).with.offset(-kRealValue(20));
//            }];
////

            
            UILabel *lineView2 = [[UILabel alloc] init];
            lineView2.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
            [_bgView addSubview:lineView2];
            [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(140));
                make.left.equalTo(_bgView.mas_left).with.offset(0);
                make.right.equalTo(_bgView.mas_right).with.offset(0);
                make.height.mas_equalTo(1/kScreenScale);
            }];
            
            
            _dataLabel = [[UILabel alloc]init];
            _dataLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
            _dataLabel.textColor =[UIColor colorWithHexString:@"#999999"];
            [_bgView addSubview:_dataLabel];
            [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_bgView.mas_bottom).with.offset(-kRealValue(5));
                 make.left.equalTo(_bgView.mas_left).with.offset(kRealValue(22));
            }];
            
    
            _alllabel = [[UILabel alloc]init];
            _alllabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
            _alllabel.textColor =[UIColor colorWithHexString:@"#222222"];
            [_bgView addSubview:_alllabel];
            [_alllabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_dataLabel.mas_centerY).with.offset(0);
                make.right.equalTo(_bgView.mas_right).with.offset(-kRealValue(20));
            }];

        
    }
    
    return self;
}





-(void)createModel:(MHMyOrderListModel *)model{
    self.model = model;
    self.ActivityArr = model.shops[0][@"products"];
    _dingdanLabel.text  = [NSString stringWithFormat:@"订单号:%@",model.orderCode];
//    _numberLabel.text = [NSString stringWithFormat:@"x%ld",(long)model.productCount];
//    if ([model.orderType isEqualToString:@"INTEGRAL"]) {
//        _moneyLabel.text = [NSString stringWithFormat:@"%@火币",model.orderTruePrice];
//    }else{
//        _moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.orderTruePrice];
//    }

    _dataLabel.text = [NSString stringWithFormat:@"%@",model.createTime];
    if ([model.orderType isEqualToString:@"INTEGRAL"]) {
        _alllabel.text =[NSString stringWithFormat:@"合计：%@积分", model.orderTruePrice];
    }else{
        _alllabel.text =[NSString stringWithFormat:@"合计：¥%@", model.orderTruePrice];
    }
 

    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:self.ActivityArr[0][@"productSmallImage"]] placeholderImage:kGetImage(@"zhanwei")];
    _titlesLabel.text = self.ActivityArr[0][@"productName"];
    if ([model.orderTradeState isEqualToString:@"CLOSED"]) {
          _stateLabel.text = @"已失效";
    }else{
        if ([model.orderState isEqualToString:@"UNPAID"]) {
            _stateLabel.text = @"待付款";
        }else if ([model.orderState isEqualToString:@"UNDELIVER"]){
            _stateLabel.text = @"待发货";
        }else if ([model.orderState isEqualToString:@"UNRECEIPT"]){
            _stateLabel.text = @"已发货";
        }else if ([model.orderState isEqualToString:@"UNEVALUATED"]){
            
            if ([model.orderType isEqualToString:@"NORMAL"]) {
                _stateLabel.text = @"待评价";
            }else{
                _stateLabel.text = @"已完成";
            }

        }else if ([model.orderState isEqualToString:@"COMPLETED"]){
            
            _stateLabel.text = @"已完成";
            if ([model.orderTradeState isEqualToString:@"COMPLETED"]) {
                _stateLabel.text = @"已完成";
            }else{
                if ([model.orderType isEqualToString:@"NORMAL"]) {
                    _stateLabel.text = @"已完成";
                }else{
                    _stateLabel.text = @"已完成";
                }


            }

        }else if ([model.orderState isEqualToString:@"RETURN_GOOD"]){
            _stateLabel.text = @"退换货";
        }else{
            _stateLabel.text = @"已失效";
        }
    }
}

    
    
@end
