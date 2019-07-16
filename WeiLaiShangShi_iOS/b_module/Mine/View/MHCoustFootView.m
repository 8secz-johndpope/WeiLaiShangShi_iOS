//
//  MHCoustFootView.m
//  mohu
//
//  Created by AllenQin on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHCoustFootView.h"
#import "UIControl+BlocksKit.h"

@implementation MHCoustFootView

- (instancetype)initWithFrame:(CGRect)frame withArr:(NSArray *)desc{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _isSelect = 1;
        _desc = desc;

        
        UILabel *line= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(10))];
        line.backgroundColor = kBackGroudColor;
        [self addSubview:line];

        //选择原因
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kRealValue(10), kScreenWidth, kRealValue(49))];

        _selectBtn.backgroundColor = [UIColor whiteColor];
        [self addSubview:_selectBtn];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(16),0,kRealValue(100),kRealValue(49))];
        label1.text = @"售后原因";
        label1.font = [UIFont fontWithName:kPingFangRegular size:14];
        label1.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        label1.textAlignment = NSTextAlignmentLeft;
        [_selectBtn addSubview:label1];
        

        
         _dianpuLabel = [[YYLabel alloc] init];
        _dianpuLabel.userInteractionEnabled = NO;
         _dianpuLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
         [_selectBtn addSubview:_dianpuLabel];
         [_dianpuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(_selectBtn.mas_top).with.offset(0);
             make.bottom.equalTo(_selectBtn.mas_bottom).with.offset(0);
             make.right.equalTo(_selectBtn.mas_right).with.offset(-kRealValue(26));
          }];
        _dianpuLabel.text = @"请选择";
        
        UIImageView *rightView = [[UIImageView alloc] initWithImage:kGetImage(@"leve_desc_arrow")];
        [_selectBtn addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
            make.centerY.equalTo(_selectBtn.mas_centerY).with.offset(0);
            make.right.equalTo(_selectBtn.mas_right).with.offset(-kRealValue(10));
        }];
        
        
//        _dianpu = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kRealValue(85), 0, kRealValue(80), kRealValue(49))];
//        _dianpu.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//        _dianpu.userInteractionEnabled = NO;
//        [_dianpu setImage:[UIImage imageNamed:@"leve_desc_arrow"] forState:UIControlStateNormal];
//        [_dianpu setTitle:@"请选择" forState:UIControlStateNormal];
//        [_dianpu  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_dianpu setTitleEdgeInsets:UIEdgeInsetsMake(0, - dianpu.imageView.image.size.width +kRealValue(10), 0, _dianpu.imageView.image.size.width)];
//        [_dianpu setImageEdgeInsets:UIEdgeInsetsMake(0, dianpu.titleLabel.bounds.size.width-kRealValue(10), 0, -_dianpu.titleLabel.bounds.size.width+kRealValue(0))];
//        [_selectBtn addSubview:_dianpu];
        
        
        [_selectBtn bk_addEventHandler:^(id sender) {
            UIActionSheet *actionsheet1 = [[UIActionSheet alloc] initWithTitle:@"请选售后原因" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
            [desc enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [actionsheet1 addButtonWithTitle:obj];
            }];
       
            
            [actionsheet1 showInView:kWindow];
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        UIView *sectionView1 = [[UIView alloc] initWithFrame:CGRectMake(0, kRealValue(59), kScreenWidth, kRealValue(42))];
        sectionView1.backgroundColor = kBackGroudColor;
        [self addSubview:sectionView1];
        
        
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(16),0,kRealValue(100),kRealValue(42))];
        label2.text = @"选择服务类型";
        label2.font = [UIFont fontWithName:kPingFangRegular size:14];
        label2.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        label2.textAlignment = NSTextAlignmentLeft;
        [sectionView1 addSubview:label2];
        
        
      
        
        UIButton *result1 = [[UIButton alloc] initWithFrame:CGRectMake(0, kRealValue(101), kScreenWidth, kRealValue(49))];
        result1.tag = 1300;
        [result1 addTarget: self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
        result1.backgroundColor = [UIColor whiteColor];
        [self addSubview:result1];
        
        _select1 = [[UIImageView alloc]initWithImage:kGetImage(@"choice_select_black")];
        _select1.frame = CGRectMake(kRealValue(338), kRealValue(14), kRealValue(22), kRealValue(22));
        [result1 addSubview:_select1];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(16),0,kRealValue(100),kRealValue(49))];
        label3.text = @"换货";
        label3.font = [UIFont fontWithName:kPingFangRegular size:14];
        label3.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        label3.textAlignment = NSTextAlignmentLeft;
        [result1 addSubview:label3];
        
        
        
        UIButton *result2 = [[UIButton alloc] initWithFrame:CGRectMake(0, kRealValue(150), kScreenWidth, kRealValue(49))];
        result2.tag = 1301;
        result2.backgroundColor = [UIColor whiteColor];
        [result2 addTarget: self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:result2];
        
        
        _select2 = [[UIImageView alloc]initWithImage:kGetImage(@"choice_select_black")];
        _select2.frame = CGRectMake(kRealValue(338), kRealValue(14), kRealValue(22), kRealValue(22));
        _select2.hidden = YES;
        [result2 addSubview:_select2];
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(16),0,kRealValue(100),kRealValue(49))];
        label4.text = @"退货退款";
        label4.font = [UIFont fontWithName:kPingFangRegular size:14];
        label4.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        label4.textAlignment = NSTextAlignmentLeft;
        [result2 addSubview:label4];
        
        
        UIView *sectionView2 = [[UIView alloc] initWithFrame:CGRectMake(0, kRealValue(199), kScreenWidth, kRealValue(42))];
        sectionView2.backgroundColor = kBackGroudColor;
        [self addSubview:sectionView2];
        
        
        
        UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(16),0,kRealValue(100),kRealValue(42))];
        label5.text = @"退货留言";
        label5.font = [UIFont fontWithName:kPingFangRegular size:14];
        label5.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        label5.textAlignment = NSTextAlignmentLeft;
        [sectionView2 addSubview:label5];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kRealValue(241), kScreenWidth, kRealValue(207))];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        _textView = [YYTextView new];
        _textView.frame = CGRectMake(kRealValue(16), kRealValue(16), kRealValue(343), kRealValue(173));
        _textView.layer.masksToBounds = YES;
        _textView.layer.cornerRadius = 5;
        _textView.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _textView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        _textView.textColor = [UIColor blackColor];
        _textView.placeholderText = @"输入留言信息";
        _textView.placeholderTextColor = [UIColor  colorWithHexString:@"999999"];
        [bgView addSubview:_textView];
        
        
        
    }
    return self;
}


-(void)changeState:(UIButton *)sender{
    if (sender.tag == 1300) {
        _select1.hidden = NO;
        _select2.hidden = YES;
    }else{
        _select1.hidden = YES;
        _select2.hidden = NO;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        return;
    }
    _dianpuLabel.text = _desc[buttonIndex-1];
}

@end
