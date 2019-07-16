//
//  HSWithDrawMoneyCell.m
//  HSKD
//
//  Created by AllenQin on 2019/3/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWithDrawMoneyCell.h"

@implementation HSWithDrawMoneyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.btnArr = [NSMutableArray array];
       
    }
    return self;
}



-(void)clickBtn:(UIButton *)sender{
    
    [self.btnArr enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == sender.tag) {
            obj.selected = YES;
        }else{
            obj.selected = NO;
        }
    }];
    if ([self.delegate respondsToSelector:@selector(clickBtnValues:)]) {
        [self.delegate clickBtnValues:sender.tag - 6230];
    }
    
}

-(void)creatBtn:(NSDictionary *)dict{
    NSArray *dictArr = dict[@"money"];
    [self.btnArr enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeAllSubviews];
        obj = nil;
    }];
    [self.btnArr removeAllObjects];
    for (int i = 0 ; i<[dictArr count]; i++) {
        int top  = i /3;
        UIButton *btn  = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(12) + kRealValue(119) *(i%3), (top*kRealValue(54)) +kRealValue(10), kRealValue(109), kRealValue(44))];
        [btn setBackgroundImage:kGetImage(@"no_changes_money_icon") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:kGetImage(@"changes_money_icon") forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithHexString:@"#FE7E1B"] forState:UIControlStateSelected];
        btn.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
        [btn setTitleColor:[UIColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@元",dictArr[i]] forState:UIControlStateNormal];
        [self addSubview:btn];
        btn.tag = 6230 + i;
        if (i == 0) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
        [self.btnArr addObject:btn];
    }
}

@end
