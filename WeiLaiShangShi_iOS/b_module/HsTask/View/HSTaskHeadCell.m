//
//  HSTaskHeadCell.m
//  HSKD
//
//  Created by yuhao on 2019/2/27.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSTaskHeadCell.h"
#import "HSQiandaoModel.h"
@implementation HSTaskHeadCell

-(void)createViewIndenglu
{
    for (int i = 0; i < 7; i++) {
        UILabel *qiandaomoneyLable = (UILabel *)[self viewWithTag:10000301+i];
        qiandaomoneyLable.text = [NSString stringWithFormat:@"%@",@""];
        qiandaomoneyLable.textColor = KColorFromRGB(0xCB850C);
        UILabel *qiandaomoneyLable1 = (UILabel *)[self viewWithTag:10000201+i];
        qiandaomoneyLable1.text = [NSString stringWithFormat:@"%d天",i+1];
        qiandaomoneyLable1.textColor = KColorFromRGB(kThemecolor);
        UIImageView *img = (UIImageView *)[self viewWithTag:10000101+i];
        img.image = kGetImage(@"task_gold_icon1");
    }
    [self.qiandaobtn setTitle:@"签到" forState:UIControlStateNormal];
    self.qiandaobtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    self.qiandaobtn.backgroundColor = KColorFromRGB(kThemecolor);
    
}

-(void)createviewWithArr:(NSMutableArray *)listArr withDic:(NSMutableDictionary *)dic
{
    self.Subtitlelabel.text =[NSString stringWithFormat:@"明天签到可领%@金币",[dic valueForKey:@"integral"]];
    self.Subtitlelabel.hidden = YES;
    
    for (int i = 0; i < listArr.count; i++) {
        UILabel *qiandaomoneyLable = (UILabel *)[self viewWithTag:10000301+i];
        qiandaomoneyLable.text = [NSString stringWithFormat:@"%@",[listArr objectAtIndex:i]];
        qiandaomoneyLable.textColor = KColorFromRGB(0xCB850C);
        UILabel *qiandaomoneyLable1 = (UILabel *)[self viewWithTag:10000201+i];
        qiandaomoneyLable1.text = [NSString stringWithFormat:@"%d天",i+1];
        qiandaomoneyLable1.textColor = KColorFromRGB(kThemecolor);
        UIImageView *img = (UIImageView *)[self viewWithTag:10000101+i];
        img.image = kGetImage(@"task_gold_icon1");
    }
  
     NSString *str1 = [NSString stringWithFormat:@"%@",[dic valueForKey:@"days"]];
    if ([str1 integerValue] > 0 ) {
        for (int i = 0; i <[str1 integerValue]; i++) {
            UILabel *qiandaomoneyLable = (UILabel *)[self viewWithTag:10000301+i];
            qiandaomoneyLable.text = [NSString stringWithFormat:@"%@",[listArr objectAtIndex:i]];
            qiandaomoneyLable.textColor = KColorFromRGB(0xCB850C);
            UILabel *qiandaomoneyLable1 = (UILabel *)[self viewWithTag:10000201+i];
            qiandaomoneyLable1.text = [NSString stringWithFormat:@"已签到"];
            qiandaomoneyLable1.textColor = KColorFromRGB(0x999999);
            UIImageView *img = (UIImageView *)[self viewWithTag:10000101+i];
            img.image = kGetImage(@"task_gold_icon");
                    }
    }
    NSString *str = [NSString stringWithFormat:@"%@",[dic valueForKey:@"signIn"]];
    if ([str isEqualToString:@"0"]) {
        [self.qiandaobtn setTitle:@"签到" forState:UIControlStateNormal];
        self.qiandaobtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
        self.qiandaobtn.backgroundColor = KColorFromRGB(kThemecolor);
        

    }else{
        [self.qiandaobtn setTitle:@"已签到" forState:UIControlStateNormal];
        self.qiandaobtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
        self.qiandaobtn.backgroundColor = [UIColor colorWithHexString:@"#C2C2C2"];
       
    }

   
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = KColorFromRGB(0xF1F2F1);
        [self createview];
    }
    return self;
}
-(void)createview
{
      self.headbgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(96)+kStatusBarHeight)];
    MHLog(@"%f",kRealValue(96)+kStatusBarHeight);
    self.headbgImg.image = kGetImage(@"task_icon_bg");
    [self addSubview:self.headbgImg];
    
    
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.textColor = KColorFromRGB(0xffffff);
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.text = @"任务中心";
    titlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
    [self.headbgImg addSubview:titlelabel];
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headbgImg.mas_centerX).offset(0);
        make.top.equalTo(self.headbgImg.mas_top).offset(kRealValue(5)+kStatusBarHeight);
        
    }];
    
    
    self.headbgview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(12), kRealValue(35)+kStatusBarHeight, kScreenWidth- kRealValue(24), kRealValue(208))];
    self.headbgview.layer.cornerRadius = kRealValue(8);
    self.headbgview.backgroundColor = KColorFromRGB(0xFEFFFE);
    [self addSubview:self.headbgview];
    
    self.titlelabel = [[UILabel alloc]init];
    self.titlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    self.titlelabel.textColor = KColorFromRGB(0x222222);
    self.titlelabel.textAlignment = NSTextAlignmentCenter;
    self.titlelabel.text = @"签到领火币";
    [self.headbgview addSubview:self.titlelabel];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headbgview.mas_centerX).offset(kRealValue(0));
        make.top.equalTo(self.headbgview.mas_top).offset(kRealValue(12));
    }];
    
    self.Subtitlelabel = [[UILabel alloc]init];
    self.Subtitlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    self.Subtitlelabel.textColor = KColorFromRGB(0x999999);
    self.Subtitlelabel.textAlignment = NSTextAlignmentCenter;
    self.Subtitlelabel.text = @"";
    [self.headbgview addSubview:self.Subtitlelabel];
    [self.Subtitlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headbgview.mas_centerX).offset(kRealValue(0));
        make.top.equalTo(self.titlelabel.mas_bottom).offset(kRealValue(0));
    }];
    
    self.qiandaoImg = [[UIImageView alloc]init];
    self.qiandaoImg.image = kGetImage(@"task_gold_icon");
    [self.headbgview addSubview:self.qiandaoImg];
    [self.qiandaoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headbgview.mas_left).offset(kRealValue(12));
        make.top.equalTo(self.headbgview.mas_top).offset(kRealValue(68));
        make.width.height.mas_equalTo(kRealValue(40));
    }];
    
    self.qiandaomoneyLable = [[UILabel alloc]init];
    self.qiandaomoneyLable.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.qiandaomoneyLable.textColor = KColorFromRGB(0xCB850C);
    self.qiandaomoneyLable.textAlignment = NSTextAlignmentCenter;
   
    self.qiandaomoneyLable.text = @"200";
    [self.qiandaoImg addSubview:self.qiandaomoneyLable];
    [self.qiandaomoneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qiandaoImg.mas_centerX).offset(kRealValue(0));
        make.centerY.equalTo(self.qiandaoImg.mas_centerY).offset(kRealValue(0));
    }];
    
    self.qiandaoLable = [[UILabel alloc]init];
    self.qiandaoLable.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.qiandaoLable.textColor = KColorFromRGB(0xF19D2B);
    self.qiandaoLable.textAlignment = NSTextAlignmentCenter;
    self.qiandaoLable.text = @"1天";
    [self.headbgview addSubview:self.qiandaoLable];
    [self.qiandaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qiandaoImg.mas_centerX).offset(kRealValue(0));
        make.top.equalTo(self.qiandaoImg.mas_bottom).offset(kRealValue(5));
    }];
   
    self.qiandaoImg2 = [[UIImageView alloc]init];
    self.qiandaoImg2.image = kGetImage(@"task_gold_icon");
    [self.headbgview addSubview:self.qiandaoImg2];
    [self.qiandaoImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.qiandaoImg.mas_right).offset(kRealValue(9));
        make.top.equalTo(self.headbgview.mas_top).offset(kRealValue(68));
        make.width.height.mas_equalTo(kRealValue(40));
    }];
    
    self.qiandaomoneyLable2 = [[UILabel alloc]init];
    self.qiandaomoneyLable2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.qiandaomoneyLable2.textColor = KColorFromRGB(0xCB850C);
    self.qiandaomoneyLable2.textAlignment = NSTextAlignmentCenter;
    self.qiandaomoneyLable2.text = @"200";
    [self.qiandaoImg2 addSubview:self.qiandaomoneyLable2];
    [self.qiandaomoneyLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qiandaoImg2.mas_centerX).offset(kRealValue(0));
        make.centerY.equalTo(self.qiandaoImg2.mas_centerY).offset(kRealValue(0));
    }];
    
    self.qiandaoLable2 = [[UILabel alloc]init];
    self.qiandaoLable2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.qiandaoLable2.textColor = KColorFromRGB(0xF19D2B);
    self.qiandaoLable2.textAlignment = NSTextAlignmentCenter;
    self.qiandaoLable2.text = @"2天";
    [self.headbgview addSubview:self.qiandaoLable2];
    [self.qiandaoLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qiandaoImg2.mas_centerX).offset(kRealValue(0));
        make.top.equalTo(self.qiandaoImg2.mas_bottom).offset(kRealValue(5));
    }];
    
    
    self.qiandaoImg3 = [[UIImageView alloc]init];
    self.qiandaoImg3.image = kGetImage(@"task_gold_icon");
    [self.headbgview addSubview:self.qiandaoImg3];
    [self.qiandaoImg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.qiandaoImg2.mas_right).offset(kRealValue(9));
        make.top.equalTo(self.headbgview.mas_top).offset(kRealValue(68));
        make.width.height.mas_equalTo(kRealValue(40));
    }];
    
    self.qiandaomoneyLable3 = [[UILabel alloc]init];
    self.qiandaomoneyLable3.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.qiandaomoneyLable3.textColor = KColorFromRGB(0xCB850C);
    self.qiandaomoneyLable3.textAlignment = NSTextAlignmentCenter;
    self.qiandaomoneyLable3.text = @"200";
    [self.qiandaoImg3 addSubview:self.qiandaomoneyLable3];
    [self.qiandaomoneyLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qiandaoImg3.mas_centerX).offset(kRealValue(0));
        make.centerY.equalTo(self.qiandaoImg3.mas_centerY).offset(kRealValue(0));
    }];
    
    self.qiandaoLable3 = [[UILabel alloc]init];
    self.qiandaoLable3.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.qiandaoLable3.textColor = KColorFromRGB(0xF19D2B);
    self.qiandaoLable3.textAlignment = NSTextAlignmentCenter;
    self.qiandaoLable3.text = @"3天";
    [self.headbgview addSubview:self.qiandaoLable3];
    [self.qiandaoLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qiandaoImg3.mas_centerX).offset(kRealValue(0));
        make.top.equalTo(self.qiandaoImg3.mas_bottom).offset(kRealValue(5));
    }];
    
    
    self.qiandaoImg4 = [[UIImageView alloc]init];
    self.qiandaoImg4.image = kGetImage(@"task_gold_icon");
    [self.headbgview addSubview:self.qiandaoImg4];
    [self.qiandaoImg4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.qiandaoImg3.mas_right).offset(kRealValue(9));
        make.top.equalTo(self.headbgview.mas_top).offset(kRealValue(68));
        make.width.height.mas_equalTo(kRealValue(40));
    }];
    
    self.qiandaomoneyLable4 = [[UILabel alloc]init];
    self.qiandaomoneyLable4.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.qiandaomoneyLable4.textColor = KColorFromRGB(0xCB850C);
    self.qiandaomoneyLable4.textAlignment = NSTextAlignmentCenter;
    self.qiandaomoneyLable4.text = @"200";
    [self.qiandaoImg4 addSubview:self.qiandaomoneyLable4];
    [self.qiandaomoneyLable4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qiandaoImg4.mas_centerX).offset(kRealValue(0));
        make.centerY.equalTo(self.qiandaoImg4.mas_centerY).offset(kRealValue(0));
    }];
    
    self.qiandaoLable4 = [[UILabel alloc]init];
    self.qiandaoLable4.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.qiandaoLable4.textColor = KColorFromRGB(0xF19D2B);
    self.qiandaoLable4.textAlignment = NSTextAlignmentCenter;
    self.qiandaoLable4.text = @"4天";
    [self.headbgview addSubview:self.qiandaoLable4];
    [self.qiandaoLable4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qiandaoImg4.mas_centerX).offset(kRealValue(0));
        make.top.equalTo(self.qiandaoImg4.mas_bottom).offset(kRealValue(5));
    }];
    
    self.qiandaoImg5 = [[UIImageView alloc]init];
    self.qiandaoImg5.image = kGetImage(@"task_gold_icon");
    [self.headbgview addSubview:self.qiandaoImg5];
    [self.qiandaoImg5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.qiandaoImg4.mas_right).offset(kRealValue(9));
        make.top.equalTo(self.headbgview.mas_top).offset(kRealValue(68));
        make.width.height.mas_equalTo(kRealValue(40));
    }];
    
    self.qiandaomoneyLable5 = [[UILabel alloc]init];
    self.qiandaomoneyLable5.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.qiandaomoneyLable5.textColor = KColorFromRGB(0xCB850C);
    self.qiandaomoneyLable5.textAlignment = NSTextAlignmentCenter;
    self.qiandaomoneyLable5.text = @"200";
    [self.qiandaoImg5 addSubview:self.qiandaomoneyLable5];
    [self.qiandaomoneyLable5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qiandaoImg5.mas_centerX).offset(kRealValue(0));
        make.centerY.equalTo(self.qiandaoImg5.mas_centerY).offset(kRealValue(0));
    }];
    
    self.qiandaoLable5 = [[UILabel alloc]init];
    self.qiandaoLable5.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.qiandaoLable5.textColor = KColorFromRGB(0xF19D2B);
    self.qiandaoLable5.textAlignment = NSTextAlignmentCenter;
    self.qiandaoLable5.text = @"5天";
    [self.headbgview addSubview:self.qiandaoLable5];
    [self.qiandaoLable5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qiandaoImg5.mas_centerX).offset(kRealValue(0));
        make.top.equalTo(self.qiandaoImg5.mas_bottom).offset(kRealValue(5));
    }];
    
    self.qiandaoImg6 = [[UIImageView alloc]init];
    self.qiandaoImg6.image = kGetImage(@"task_gold_icon");
    [self.headbgview addSubview:self.qiandaoImg6];
    [self.qiandaoImg6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.qiandaoImg5.mas_right).offset(kRealValue(9));
        make.top.equalTo(self.headbgview.mas_top).offset(kRealValue(68));
        make.width.height.mas_equalTo(kRealValue(40));
    }];
    
    self.qiandaomoneyLable6 = [[UILabel alloc]init];
    self.qiandaomoneyLable6.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.qiandaomoneyLable6.textColor = KColorFromRGB(0xCB850C);
    self.qiandaomoneyLable6.textAlignment = NSTextAlignmentCenter;
    self.qiandaomoneyLable6.text = @"200";
    [self.qiandaoImg6 addSubview:self.qiandaomoneyLable6];
    [self.qiandaomoneyLable6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qiandaoImg6.mas_centerX).offset(kRealValue(0));
        make.centerY.equalTo(self.qiandaoImg6.mas_centerY).offset(kRealValue(0));
    }];
    
    self.qiandaoLable6 = [[UILabel alloc]init];
    self.qiandaoLable6.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.qiandaoLable6.textColor = KColorFromRGB(0xF19D2B);
    self.qiandaoLable6.textAlignment = NSTextAlignmentCenter;
    self.qiandaoLable6.text = @"6天";
    [self.headbgview addSubview:self.qiandaoLable6];
    [self.qiandaoLable6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qiandaoImg6.mas_centerX).offset(kRealValue(0));
        make.top.equalTo(self.qiandaoImg6.mas_bottom).offset(kRealValue(5));
    }];
    
    self.qiandaoImg7 = [[UIImageView alloc]init];
    self.qiandaoImg7.image = kGetImage(@"task_gold_icon");
    [self.headbgview addSubview:self.qiandaoImg7];
    [self.qiandaoImg7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.qiandaoImg6.mas_right).offset(kRealValue(9));
        make.top.equalTo(self.headbgview.mas_top).offset(kRealValue(68));
        make.width.height.mas_equalTo(kRealValue(40));
    }];
    
    self.qiandaomoneyLable7 = [[UILabel alloc]init];
    self.qiandaomoneyLable7.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.qiandaomoneyLable7.textColor = KColorFromRGB(0xCB850C);
    self.qiandaomoneyLable7.textAlignment = NSTextAlignmentCenter;
    self.qiandaomoneyLable7.text = @"200";
    [self.qiandaoImg7 addSubview:self.qiandaomoneyLable7];
    [self.qiandaomoneyLable7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qiandaoImg7.mas_centerX).offset(kRealValue(0));
        make.centerY.equalTo(self.qiandaoImg7.mas_centerY).offset(kRealValue(0));
    }];
//
    self.qiandaoLable7 = [[UILabel alloc]init];
    self.qiandaoLable7.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.qiandaoLable7.textColor = KColorFromRGB(0xF19D2B);
    self.qiandaoLable7.textAlignment = NSTextAlignmentCenter;
    self.qiandaoLable7.text = @"7天";
    [self.headbgview addSubview:self.qiandaoLable7];
    [self.qiandaoLable7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qiandaoImg7.mas_centerX).offset(kRealValue(0));
        make.top.equalTo(self.qiandaoImg7.mas_bottom).offset(kRealValue(5));
    }];

    self.qiandaobtn = [[UIButton alloc] init];
    [self.qiandaobtn addTarget:self action:@selector(qiandaoAct) forControlEvents:UIControlEventTouchUpInside];
    [self.qiandaobtn setTitle:@"签到" forState:UIControlStateNormal];
    self.qiandaobtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    self.qiandaobtn.backgroundColor = KColorFromRGB(kThemecolor);
    self.qiandaobtn.layer.masksToBounds = YES;
    self.qiandaobtn.layer.cornerRadius = kRealValue(17);
    [self.headbgview addSubview:self.qiandaobtn];
    [self.qiandaobtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(34));
        make.centerX.equalTo(self.headbgview.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(310));
        make.top.equalTo(self.qiandaoLable7.mas_bottom).offset(kRealValue(21));
    }];
    
    
    self.qiandaomoneyLable.tag = 10000301;
    self.qiandaomoneyLable2.tag = 10000302;
    self.qiandaomoneyLable3.tag = 10000303;
    self.qiandaomoneyLable4.tag = 10000304;
    self.qiandaomoneyLable5.tag = 10000305;
    self.qiandaomoneyLable6.tag = 10000306;
    self.qiandaomoneyLable7.tag = 10000307;
    
    self.qiandaoLable.tag =10000201;
    self.qiandaoLable2.tag =10000202;
    self.qiandaoLable3.tag =10000203;
    self.qiandaoLable4.tag =10000204;
    self.qiandaoLable5.tag =10000205;
    self.qiandaoLable6.tag =10000206;
    self.qiandaoLable7.tag =10000207;
    
     self.qiandaoImg.tag = 10000101;
     self.qiandaoImg2.tag = 10000102;
     self.qiandaoImg3.tag = 10000103;
     self.qiandaoImg4.tag = 10000104;
     self.qiandaoImg5.tag = 10000105;
     self.qiandaoImg6.tag = 10000106;
     self.qiandaoImg7.tag = 10000107;
    
    
}
-(void)qiandaoAct
{
    if (self.Qiandao) {
        self.Qiandao();
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
