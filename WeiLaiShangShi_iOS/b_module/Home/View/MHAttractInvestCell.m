//
//  MHAttractInvestCell.m
//  wgts
//
//  Created by yuhao on 2018/11/7.
//  Copyright © 2018 mhyouping. All rights reserved.
//

#import "MHAttractInvestCell.h"

@implementation MHAttractInvestCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createview];
    }
    return self;
}
-(void)createview
{
    UIView *redline = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(12), kRealValue(3), kRealValue(16))];
    redline.backgroundColor  = KColorFromRGB(0xFF6161);
    redline.layer.cornerRadius = kRealValue(2);
    [self addSubview:redline];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(27), kRealValue(10), kRealValue(100), kRealValue(20))];
    titlelabel.text = @"产品推广";
    titlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    titlelabel.textAlignment =  NSTextAlignmentLeft;
    titlelabel.textColor = KColorFromRGB(0x000000);
    [self addSubview:titlelabel];
    
    self.bigimage = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(44), kScreenWidth - kRealValue(32), kRealValue(115))];
//    self.bigimage.backgroundColor = kRandomColor;
    self.bigimage.userInteractionEnabled = YES;
    self.bigimage.layer.masksToBounds = YES;
    self.bigimage.layer.cornerRadius = kRealValue(5);
    [self addSubview:self.bigimage];
    
    self.smallImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(164), kRealValue(169), kRealValue(95))];
//    self.smallImage1.backgroundColor = kRandomColor;
    self.smallImage1.layer.masksToBounds = YES;
    self.smallImage1.userInteractionEnabled = YES;
    self.smallImage1.layer.cornerRadius = kRealValue(5);
    [self addSubview:self.smallImage1];
    
    self.smallImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(190), kRealValue(164), kRealValue(169), kRealValue(95))];
//    self.smallImage2 .backgroundColor = kRandomColor;
    self.smallImage2 .layer.masksToBounds = YES;
    self.smallImage2.userInteractionEnabled = YES;
    self.smallImage2 .layer.cornerRadius = kRealValue(5);
    [self addSubview:self.smallImage2 ];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView1)];
    [self.bigimage addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView2)];
    [self.smallImage1 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView3)];
    [self.smallImage2 addGestureRecognizer:tap3];
}
-(void)OnTapBtnView1
{
    if (self.changepage) {
        self.changepage(@"0", @"0");
    }
}
-(void)OnTapBtnView2
{
    if (self.changepage) {
        self.changepage(@"1", @"1");
    }
}
-(void)OnTapBtnView3
{
    if (self.changepage) {
        self.changepage(@"2", @"2");
    }
}

@end
