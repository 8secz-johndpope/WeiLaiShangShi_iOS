//
//  MHHomeGoodsHeadSortTitleView.m
//  mohu
//
//  Created by 余浩 on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHHomeGoodsHeadSortTitleView.h"

@interface MHHomeGoodsHeadSortTitleView()

@property(nonatomic, strong)UIButton *btn;
@property(nonatomic, strong)UIButton *btn1;
@property(nonatomic, strong)UIButton *btn1Small;
@property(nonatomic, strong)UIButton *btn2;
@property(nonatomic, strong)UIButton *btn2Small;
@property(nonatomic, strong)UIButton *btn3;
@end

@implementation MHHomeGoodsHeadSortTitleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createview];
    }
    return self;
}
-(void)createview
{
//    self.backgroundColor = kRandomColor;
    // 分4块 各自布局
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4, 40)];
//    bgview.backgroundColor =kRandomColor;
    [self addSubview:bgview];
    
    //添加默认
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setTitle:@"默认" forState:UIControlStateNormal];
    [self.btn setTitleColor:KColorFromRGB(0x666666) forState:UIControlStateNormal];
    self.btn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:12];
    self.btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btn setTitleColor:KColorFromRGB(kThemecolor)  forState:UIControlStateSelected];
    [self.btn setSelected:YES];
    [self.btn addTarget:self action:@selector(defaultSort:) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:self.btn];
    
    
    UIView *bgview1 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/4, 0, kScreenWidth/4, 40)];
//    bgview1.backgroundColor =kRandomColor;
    [self addSubview:bgview1];
   
    //添加销量
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn1 setTitle:@"销量" forState:UIControlStateNormal];
    [self.btn1 setTitleColor:KColorFromRGB(0x666666) forState:UIControlStateNormal];
    [self.btn1 setTitleColor:KColorFromRGB(kThemecolor) forState:UIControlStateSelected];
    self.btn1.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:12];
    self.btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btn1 addTarget:self action:@selector(SaleNumsortAct:) forControlEvents:UIControlEventTouchUpInside];
    [bgview1 addSubview:self.btn1];
    
    self.btn1Small = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn1Small setImage:kGetImage(@"ic_sift_open") forState:UIControlStateNormal];
    [self.btn1Small addTarget:self action:@selector(SmallSaleNumsortAct:) forControlEvents:UIControlEventTouchUpInside];
    [bgview1 addSubview:self.btn1Small];
    
    
    
    UIView *bgview2 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/4, 40)];
//    bgview2.backgroundColor =kRandomColor;
    [self addSubview:bgview2];
    
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn2  setTitle:@"价格" forState:UIControlStateNormal];
    [self.btn2  setTitleColor:KColorFromRGB(0x666666) forState:UIControlStateNormal];
    self.btn2 .titleLabel.font = [UIFont fontWithName:kPingFangRegular size:12];
    self.btn2 .titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btn2  setTitleColor:KColorFromRGB(kThemecolor)  forState:UIControlStateSelected];
    [self.btn2 addTarget:self action:@selector(PricesortAct:) forControlEvents:UIControlEventTouchUpInside];
    [bgview2 addSubview:self.btn2 ];
    
    self.btn2Small = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn2Small setImage:kGetImage(@"ic_sift_open") forState:UIControlStateNormal];
    [self.btn2Small addTarget:self action:@selector(SmallPricesortAct:) forControlEvents:UIControlEventTouchUpInside];
    [bgview2 addSubview:self.btn2Small];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [bgview2 addSubview:line];
    
    
    UIView *bgview3 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/4*3, 0, kScreenWidth/4, 40)];
//    bgview3.backgroundColor =kRandomColor;
    [self addSubview:bgview3];
    
    self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn3 setTitle:@"筛选" forState:UIControlStateNormal];
    [self.btn3 setTitleColor:KColorFromRGB(0x666666) forState:UIControlStateNormal];
    self.btn3.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:12];
    self.btn3.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btn3 setTitleColor:KColorFromRGB(kThemecolor)  forState:UIControlStateSelected];
     [self.btn3 addTarget:self action:@selector(sortAct:) forControlEvents:UIControlEventTouchUpInside];
    [bgview3 addSubview:self.btn3];
    
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgview);
        make.centerY.mas_equalTo(bgview);
    }];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgview1);
        make.centerY.mas_equalTo(bgview1);
    }];
    [self.btn1Small mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btn1.mas_right);
        make.width.mas_equalTo(16);
        make.height.mas_offset(16);
        make.centerY.mas_equalTo(bgview1);
    }];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgview2);
        make.centerY.mas_equalTo(bgview2);
    }];
    [self.btn2Small mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btn2.mas_right);
        make.width.mas_equalTo(16);
        make.height.mas_offset(16);
        make.centerY.mas_equalTo(bgview2);
    }];
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgview3);
        make.centerY.mas_equalTo(bgview3);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btn3.mas_left).offset(-18);
         make.centerY.mas_equalTo(bgview3);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(18);
    }];
    
}
-(void)defaultSort:(UIButton *)sender
{
    if (sender.selected == YES) {
        self.btn1.selected = NO;
        self.btn1Small.selected = NO;
        [self.btn1Small setImage:kGetImage(@"ic_sift_open") forState:UIControlStateNormal];
        self.btn2.selected = NO;
         [self.btn2Small setImage:kGetImage(@"ic_sift_open") forState:UIControlStateNormal];
        self.btn3.selected = NO;
       
    }else{
        self.btn.selected = YES;
        self.btn1.selected = NO;
        self.btn1Small.selected = NO;
        [self.btn1Small setImage:kGetImage(@"ic_sift_open") forState:UIControlStateNormal];
        self.btn2.selected = NO;
        [self.btn2Small setImage:kGetImage(@"ic_sift_open") forState:UIControlStateNormal];
        self.btn3.selected = NO;
    }
   
    if (self.defaultsort) {
        self.defaultsort();
    }
}
-(void)SaleNumsortAct:(UIButton *)sender
{
    if (sender.selected == YES) {
     
        if ([self.btn1Small.currentImage isEqual:[UIImage imageNamed:@"ic_sift_main_pack"]]) {
            
             [self.btn1Small setImage:kGetImage(@"ic_sift_pack") forState:UIControlStateNormal];
            if (self.saleNumSort) {
                self.saleNumSort(0);
            }
        }else{
             [self.btn1Small setImage:kGetImage(@"ic_sift_main_pack") forState:UIControlStateNormal];
            if (self.saleNumSort) {
                self.saleNumSort(1);
            }
        }
      

    }else{
        self.btn.selected = NO;
        self.btn1.selected = YES;
        self.btn1Small.selected = YES;
        [self.btn1Small setImage:kGetImage(@"ic_sift_pack") forState:UIControlStateNormal];
        self.btn2.selected = NO;
        [self.btn2Small setImage:kGetImage(@"ic_sift_open") forState:UIControlStateNormal];
        self.btn3.selected = NO;
        if (self.saleNumSort) {
            self.saleNumSort(0);
        }
    }
    
}

-(void)SmallSaleNumsortAct:(UIButton *)sender
{
    if (self.btn1.selected == YES) {
       
        if ([self.btn1Small.currentImage isEqual:[UIImage imageNamed:@"ic_sift_main_pack"]]) {
            
            [self.btn1Small setImage:kGetImage(@"ic_sift_pack") forState:UIControlStateNormal];
            if (self.saleNumSort) {
                self.saleNumSort(0);
            }
        }else{
            [self.btn1Small setImage:kGetImage(@"ic_sift_main_pack") forState:UIControlStateNormal];
            if (self.saleNumSort) {
                self.saleNumSort(1);
            }
        }
        
    }else{
        self.btn.selected = NO;
        self.btn1.selected = YES;
        self.btn1Small.selected = YES;
        [self.btn1Small setImage:kGetImage(@"ic_sift_pack") forState:UIControlStateNormal];
        self.btn2.selected = NO;
        [self.btn2Small setImage:kGetImage(@"ic_sift_open") forState:UIControlStateNormal];
        self.btn3.selected = NO;
        if (self.saleNumSort) {
            self.saleNumSort(0);
        }
    }
    
}

-(void)PricesortAct:(UIButton *)sender
{
    if (sender.selected == YES) {
        
        if ([self.btn2Small.currentImage isEqual:[UIImage imageNamed:@"ic_sift_main_pack"]]) {
            
            [self.btn2Small setImage:kGetImage(@"ic_sift_pack") forState:UIControlStateNormal];
            if (self.priceNumSort) {
                self.priceNumSort(0);
            }
        }else{
            [self.btn2Small setImage:kGetImage(@"ic_sift_main_pack") forState:UIControlStateNormal];
            if (self.priceNumSort) {
                self.priceNumSort(1);
            }
        }
        
        
    }else{
        self.btn.selected = NO;
        self.btn1.selected = NO;
        self.btn1Small.selected = NO;
        [self.btn1Small setImage:kGetImage(@"ic_sift_open") forState:UIControlStateNormal];
         self.btn2.selected = YES;
        [self.btn2Small setImage:kGetImage(@"ic_sift_pack") forState:UIControlStateNormal];
        self.btn3.selected = NO;
        if (self.priceNumSort) {
            self.priceNumSort(0);
        }
    }
    
    
}
-(void)SmallPricesortAct:(UIButton *)sender
{
    if (self.btn2.selected == YES) {
        
        if ([self.btn2Small.currentImage isEqual:[UIImage imageNamed:@"ic_sift_main_pack"]]) {
            
            [self.btn2Small setImage:kGetImage(@"ic_sift_pack") forState:UIControlStateNormal];
            if (self.priceNumSort) {
                self.priceNumSort(0);
            }
        }else{
            [self.btn2Small setImage:kGetImage(@"ic_sift_main_pack") forState:UIControlStateNormal];
            if (self.priceNumSort) {
                self.priceNumSort(1);
            }
        }
        
    }else{
        self.btn.selected = NO;
        self.btn1.selected = NO;
        self.btn1Small.selected = NO;
        [self.btn1Small setImage:kGetImage(@"ic_sift_open") forState:UIControlStateNormal];
        self.btn2.selected = YES;
        [self.btn2Small setImage:kGetImage(@"ic_sift_pack") forState:UIControlStateNormal];
        self.btn3.selected = NO;
        if (self.priceNumSort) {
            self.priceNumSort(0);
        }
    }
    
}
-(void)sortAct:(UIButton *)sender
{
    if (sender.selected == YES) {
        self.btn.selected = NO;
        self.btn1.selected = NO;
        self.btn1Small.selected = NO;
        [self.btn1Small setImage:kGetImage(@"ic_sift_open") forState:UIControlStateNormal];
        self.btn2.selected = NO;
        [self.btn2Small setImage:kGetImage(@"ic_sift_open") forState:UIControlStateNormal];
        
    }else{
        self.btn.selected = NO;
        self.btn1.selected = NO;
        self.btn1Small.selected = NO;
        [self.btn1Small setImage:kGetImage(@"ic_sift_open") forState:UIControlStateNormal];
        self.btn2.selected = NO;
        [self.btn2Small setImage:kGetImage(@"ic_sift_open") forState:UIControlStateNormal];
        self.btn3.selected = YES;
    }
    
    if (self.sort) {
        self.sort(1);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
