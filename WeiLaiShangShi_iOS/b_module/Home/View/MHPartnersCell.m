//
//  MHPartnersCell.m
//  wgts
//
//  Created by yuhao on 2018/11/7.
//  Copyright © 2018 mhyouping. All rights reserved.
//

#import "MHPartnersCell.h"

@implementation MHPartnersCell
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
    titlelabel.text = @"合作伙伴";
    titlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    titlelabel.textAlignment =  NSTextAlignmentLeft;
    titlelabel.textColor = KColorFromRGB(0x000000);
    [self addSubview:titlelabel];
    
    self.bigimage = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(0), kRealValue(44), kScreenWidth , kRealValue(204))];
    self.bigimage.layer.masksToBounds = YES;
    self.bigimage.userInteractionEnabled = YES;
    self.bigimage.layer.cornerRadius = kRealValue(5);
    [self addSubview:self.bigimage];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView1)];
    [self.bigimage addGestureRecognizer:tap1];
    
}
-(void)OnTapBtnView1
{
    self.changepage(@"0", @"0");
}




@end
