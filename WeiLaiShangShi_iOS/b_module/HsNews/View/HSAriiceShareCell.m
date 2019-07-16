//
//  HSAriiceShareCell.m
//  HSKD
//
//  Created by yuhao on 2019/4/9.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSAriiceShareCell.h"

@implementation HSAriiceShareCell
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
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(30), kScreenWidth, kRealValue(18))];
    titlelabel.userInteractionEnabled = YES;
    titlelabel.text= @"喜欢记得分享哦！";
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    titlelabel.textColor = KColorFromRGB(0x333333);
    [self addSubview:titlelabel];
    
    UIImageView *share = [[UIImageView alloc]init];
    share.image = kGetImage(@"ariticeShare");
    share.userInteractionEnabled = YES;
    [self addSubview:share];
    [share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titlelabel.mas_bottom).offset(kRealValue(15));
        make.centerX.mas_equalTo(self.mas_centerX).offset(kRealValue(0));
    }];
    
    UITapGestureRecognizer *tapAct =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapshare)];
    [share addGestureRecognizer:tapAct];
    UITapGestureRecognizer *tapAct1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapshare1)];
   
    [titlelabel addGestureRecognizer:tapAct1];
    
   
     NSString *desc = @"《免责申明》内容由运营商提供，与未来商市无关";
    NSMutableAttributedString *textdesc = [[NSMutableAttributedString alloc] initWithString:desc];
    textdesc.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    textdesc.color = [UIColor colorWithHexString:@"858384"];
    [textdesc setTextHighlightRange:[desc rangeOfString:@"《免责申明》"]
                              color:[UIColor colorWithHexString:@"#FCD04C"]
                    backgroundColor:[UIColor colorWithHexString:@"666666"]
                          tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                              if (self.mianze) {
                                  self.mianze();
                              }
                              

                          }];
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(kRealValue(280), CGFLOAT_MAX) text:textdesc];
    YYLabel *titlelabel1 = [YYLabel new];
    titlelabel1.numberOfLines = 0;
    [self addSubview:titlelabel1];
    
    titlelabel1.text= @"";
    titlelabel1.textAlignment = NSTextAlignmentCenter;
    titlelabel1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    titlelabel1.textColor = KColorFromRGB(0x666666);
    [self addSubview:titlelabel1];
    [titlelabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(share.mas_bottom).offset(kRealValue(18));
        make.centerX.mas_equalTo(self.mas_centerX).offset(kRealValue(0));
         make.height.mas_equalTo(layout.textBoundingSize.height);
    }];
    titlelabel1.attributedText = textdesc;
    

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(143), kScreenWidth, kRealValue(10))];
    line.backgroundColor= KColorFromRGB(0xF2F2F2);
    [self addSubview:line];
    
}
-(void)tapshare1
{
    if (self.Share) {
        self.Share();
    }
}
-(void)tapshare
{
    if (self.Share) {
        self.Share();
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
