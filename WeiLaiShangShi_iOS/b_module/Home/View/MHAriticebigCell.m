

//
//  MHAriticebigCell.m
//  wgts
//
//  Created by yuhao on 2018/11/7.
//  Copyright © 2018 mhyouping. All rights reserved.
//

#import "MHAriticebigCell.h"

@implementation MHAriticebigCell
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
    titlelabel.text = @"微广资讯";
    titlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    titlelabel.textAlignment =  NSTextAlignmentLeft;
    titlelabel.textColor = KColorFromRGB(0x000000);
    [self addSubview:titlelabel];
    
    self.bigimage = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(44), kRealValue(343) , kRealValue(170))];
    self.bigimage.layer.masksToBounds = YES;
    self.bigimage.layer.cornerRadius = kRealValue(5);
    [self addSubview:self.bigimage ];
    
    self.introdeslabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(225), kScreenWidth - kRealValue(32), kRealValue(20))];
     self.introdeslabel .text = @"LELIFT香奈儿升级版修护眼部护理套装";
     self.introdeslabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
     self.introdeslabel .textAlignment =  NSTextAlignmentLeft;
     self.introdeslabel .textColor = KColorFromRGB(0x000000);
     self.introdeslabel .numberOfLines = 1;
    [self addSubview: self.introdeslabel ];
    
    
    self.lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(259), kScreenWidth - kRealValue(32), 1/kScreenScale)];
    self.lineview.backgroundColor=  KColorFromRGB(0xF0F0F0);
    [self addSubview:self.lineview];
    
}


@end
