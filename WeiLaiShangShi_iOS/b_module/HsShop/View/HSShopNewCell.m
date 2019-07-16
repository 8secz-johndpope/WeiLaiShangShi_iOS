//
//  HSShopNewCell.m
//  HSKD
//
//  Created by AllenQin on 2019/2/26.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSShopNewCell.h"
#import "HSShopItemModel.h"
#import "HSShopDetailVC.h"
#import "MHLoginViewController.h"

@implementation HSShopNewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *titlesLabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(12), 0, kRealValue(351), kRealValue(20))];
        titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        titlesLabel.textColor =[UIColor colorWithHexString:@"#222222"];
        titlesLabel.text  = @"人气单品";
        titlesLabel.numberOfLines = 1;
        [self.contentView addSubview:titlesLabel];
        
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(12), kRealValue(27), kRealValue(351), kRealValue(179))];
        ViewRadius(bgView, kRealValue(8));
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        for (int i = 0; i<3; i++) {
            
            UIButton *itemView = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(17)+(kRealValue(110) * i) , 0, kRealValue(105), kRealValue(179))];
            [itemView addTarget:self action:@selector(imageBtn:) forControlEvents:UIControlEventTouchUpInside];
            itemView.tag = 1203 + i;
            itemView.backgroundColor = [UIColor clearColor];
            [bgView addSubview:itemView];
            
            
            
            
           UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kRealValue(15), kRealValue(96), kRealValue(96))];
           leftImageView.tag = 3725 + i;
//           leftImageView.backgroundColor = kRandomColor;
           [itemView addSubview:leftImageView];
            
            UILabel *nameLabel = [[UILabel alloc]init];
            nameLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
            nameLabel.textColor =[UIColor colorWithHexString:@"#333333"];
            nameLabel.numberOfLines = 1;
            nameLabel.tag = 3825 + i;
//            nameLabel.text =  @"象印电饭煲";
            [itemView addSubview:nameLabel];
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(leftImageView.mas_bottom).with.offset(kRealValue(10));
                make.left.equalTo(leftImageView.mas_left).with.offset(0);
                make.width.mas_equalTo(kRealValue(96));
            }];
            
            UILabel *jifenLabel = [[UILabel alloc]init];
            jifenLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
            jifenLabel.textColor =[UIColor colorWithHexString:@"#FF273F"];
            jifenLabel.numberOfLines = 1;
            jifenLabel.tag = 3925 + i;
//            jifenLabel.text =  @"5000积分";
            [itemView addSubview:jifenLabel];
            [jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(leftImageView.mas_bottom).with.offset(kRealValue(39));
                make.left.equalTo(leftImageView.mas_left).with.offset(0);
                make.width.mas_equalTo(kRealValue(96));
            }];
            
        
        }
        
        
    }
    
    return self;
}

-(void)creatItemArr:(NSArray *)arr{
    _itemArr  = arr;
    if ([arr count] == 0) {
        return;
    }
    
    for (int i =0; i<3; i++) {
        HSShopItemModel *model = arr[i];
        UILabel *nameTag=[self viewWithTag:3825 + i];
        nameTag.text = model.productName;
        UILabel *jifen=[self viewWithTag:3925 + i];
        if (model) {
                jifen.text = [NSString stringWithFormat:@"%@积分",model.retailPrice];
        }
        UIImageView *leftImageView=[self viewWithTag:3725 + i];
        [leftImageView sd_setImageWithURL:[NSURL URLWithString:model.productSmallImage] placeholderImage:kGetImage(@"emty_fang")];
        
    }
}


-(void)imageBtn:(UIButton *)sender{

    NSInteger senderTag =  sender.tag  - 1203;
    HSShopItemModel *model = self.itemArr[senderTag];
    
    HSShopDetailVC *VC = [[HSShopDetailVC alloc] initWithProdId:[NSString stringWithFormat:@"%ld",model.productId]];
    [self.shopNav pushViewController:VC animated:YES];
    
}
@end
