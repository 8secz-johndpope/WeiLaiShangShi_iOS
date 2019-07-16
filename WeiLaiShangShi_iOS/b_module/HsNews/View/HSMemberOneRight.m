//
//  HSMemberOneRight.m
//  HSKD
//
//  Created by yuhao on 2019/4/9.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSMemberOneRight.h"
#import "MHTaskDetailModel.h"
@implementation HSMemberOneRight
-(void)createviewWithModel:(MHTaskDetailModel *)createmodel
{
    self.titlelabel.text = createmodel.title;
    for (int i=0; i<createmodel.cover.count; i++) {
        if (i == 0) {
            
            [self.image sd_setImageWithURL:[NSURL URLWithString:[createmodel.cover objectAtIndex:0]] placeholderImage:kGetImage(@"emty_movie")];
            
        }
      
        
    }
    // 置顶是否显示
    if (createmodel.top  == 1 ) {
        [self.firstlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titlelabel.mas_left).offset(kRealValue(0));
            make.top.equalTo(self.image.mas_bottom).offset(kRealValue(15));
            make.height.mas_equalTo(kRealValue(16));
            make.width.mas_equalTo(30);
        }];
        [self.Toplabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.firstlabel.mas_right).offset(kRealValue(10));
            make.centerY.equalTo(self.firstlabel.mas_centerY).offset(kRealValue(0));
            make.height.mas_equalTo(kRealValue(16));
            make.width.mas_equalTo(52);
            
        }];
    }else{
        [self.firstlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titlelabel.mas_left).offset(kRealValue(0));
            make.top.equalTo(self.image.mas_bottom).offset(kRealValue(15));
            make.height.mas_equalTo(kRealValue(16));
            make.width.mas_equalTo(0);
        }];
        [self.Toplabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titlelabel.mas_left).offset(kRealValue(0));
            make.centerY.equalTo(self.firstlabel.mas_centerY).offset(kRealValue(0));
            make.height.mas_equalTo(kRealValue(16));
            make.width.mas_equalTo(52);
            
        }];
    }
    // 福利任务 还金银勺任务
    if ([createmodel.taskType isEqualToString:@"ORD"]) {
        //福利
        self.Toplabel.text =@"福利任务";
        self.Toplabel.backgroundColor = KColorFromRGB(0xFFDCDC);
        self.Toplabel.textColor = KColorFromRGB(0xFE0503);
        self.Toplabel.layer.borderWidth =1/kScreenScale;
        self.Toplabel.layer.borderColor = KColorFromRGB(0xFF6F6F).CGColor;
        
        
    }else if ([createmodel.taskType isEqualToString:@"VIP"]){
        
        self.Toplabel.text =@"银勺任务";
        _Toplabel.backgroundColor = KColorFromRGB(0xE3F8FF);
        _Toplabel.textColor = KColorFromRGB(0x05A9DE);
        self.Toplabel.layer.borderWidth =1/kScreenScale;
        self.Toplabel.layer.borderColor = KColorFromRGB(0x05A9DE).CGColor;
        
    }else if ([createmodel.taskType isEqualToString:@"SVIP"]){
        
        self.Toplabel.text =@"金勺任务";
        _Toplabel.backgroundColor = KColorFromRGB(0xFFF3E3);
        _Toplabel.textColor = KColorFromRGB(0xFE9F1B);
        self.Toplabel.layer.borderWidth =1/kScreenScale;
        self.Toplabel.layer.borderColor = KColorFromRGB(0xFE9F1B).CGColor;
    }
    // 金币
    self.typelabel.text = [NSString stringWithFormat:@"+%@火币≈%@元",createmodel.integral,createmodel.money];
    if ([createmodel.status isEqualToString:@"PENDING"]) {
        
        self.statuimage3.hidden = YES;
        
        
    }
    if ([createmodel.status isEqualToString:@"ACTIVE"]) {
        
        self.statuimage3.hidden = NO;
        self.statuimage3.image = kGetImage(@"taskActive");
        
    }
    if ([createmodel.status isEqualToString:@"DONE"]) {
        
        self.statuimage3.hidden = NO;
        self.statuimage3.image = kGetImage(@"taskOver");
        
    }
    if ([createmodel.status isEqualToString:@"FAILED"]) {
        
        self.statuimage3.hidden = NO;
        self.statuimage3.image = kGetImage(@"taskInvaild");
    }
    if ([createmodel.status isEqualToString:@"INVALID"]) {
        self.statuimage3.hidden = NO;
        self.statuimage3.image = kGetImage(@"taskFail");
        
    }
    if ([createmodel.status isEqualToString:@"AUDIT"]) {
        
        self.statuimage3.hidden = NO;
        self.statuimage3.image = kGetImage(@"taskReview");
    }
    
    
}
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
    [self addSubview:self.titlelabel];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(kRealValue(10));
        make.left.equalTo(self.mas_left).offset(kRealValue(12));
        make.width.mas_equalTo(kRealValue(225));
        
    }];
    NSInteger pading  = kRealValue(3);
    NSInteger LoctionX = self.titlelabel.frame.origin.x;
    NSInteger Width = kScreenWidth - kRealValue(24);
    self.image = [[UIImageView alloc]init];
    self.image.backgroundColor = kRandomColor;
    
    [self addSubview:self.image];
    self.image.clipsToBounds = YES;
    self.image.contentMode =  UIViewContentModeScaleAspectFill;
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titlelabel.mas_right).offset(kRealValue(10));
        make.top.equalTo(self.mas_top).with.offset(kRealValue(12));
        make.right.equalTo(self.mas_right).offset(kRealValue(-12));
        make.height.mas_equalTo(kRealValue(65));
    }];
    
    [self addSubview:self.firstlabel];
    [self.firstlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titlelabel.mas_left).offset(kRealValue(0));
        make.top.equalTo(self.image.mas_bottom).offset(kRealValue(15));
        make.height.mas_equalTo(kRealValue(16));
        make.width.mas_equalTo(30);
    }];
    
    
   
    [self addSubview:self.Toplabel];
    [self.Toplabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstlabel.mas_right).offset(kRealValue(10));
        make.centerY.equalTo(self.firstlabel.mas_centerY).offset(kRealValue(0));
        make.height.mas_equalTo(kRealValue(16));
        make.width.mas_equalTo(52);
        
    }];
    
    [self addSubview:self.imagemoney];
    [self.imagemoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.Toplabel.mas_right).offset(kRealValue(16));
        make.centerY.equalTo(self.Toplabel.mas_centerY).offset(kRealValue(0));
        make.height.mas_equalTo(kRealValue(16));
        make.width.mas_equalTo(kRealValue(16));
    }];
    
    
    [self addSubview:self.typelabel];
    
    [self.typelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagemoney.mas_right).offset(kRealValue(5));
        make.centerY.equalTo(self.Toplabel.mas_centerY).offset(kRealValue(0));
        make.height.mas_equalTo(kRealValue(16));
    }];
    
    [self addSubview:self.lineview];
    
    [self addSubview:self.statuimage3];
    [self.statuimage3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-kRealValue(12));
        make.centerY.equalTo(self.Toplabel.mas_centerY).offset(kRealValue(0));
        make.height.mas_equalTo(kRealValue(42));
        make.width.mas_equalTo(kRealValue(42));
    }];
    
    [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(0));
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(1/kScreenScale);
        make.top.equalTo(self.typelabel.mas_bottom).offset(kRealValue(15));
    }];
    
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
}
-(UIImageView *)statuimage3
{
    if (!_statuimage3) {
        _statuimage3 = [[UIImageView alloc]init];
        _statuimage3.image = kGetImage(@"taskActive");
        _statuimage3.hidden = YES;
    }
    return _statuimage3;
}
-(UILabel *)firstlabel
{
    if (!_firstlabel) {
        _firstlabel = [[UILabel alloc]init];
        _firstlabel.textAlignment = NSTextAlignmentCenter;
        _firstlabel.textColor = KColorFromRGB(0xe91111);
        _firstlabel.text = @"置顶";
        _firstlabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(11)];
        _firstlabel.layer.cornerRadius = kRealValue(3);
        _firstlabel.layer.borderColor = KColorFromRGB(0xe91111).CGColor;
        _firstlabel.layer.borderWidth = 1/kScreenScale;
    }
    return  _firstlabel;
}
-(UILabel *)titlelabel
{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.textAlignment = NSTextAlignmentLeft;
        _titlelabel.textColor = KColorFromRGB(0x222222);
        _titlelabel.numberOfLines = 2;
        _titlelabel.text = @"中国诗词大会第四季冠军诞生北大工科博士生陈更";
        _titlelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
        
    }
    return  _titlelabel;
}
-(UILabel *)Toplabel
{
    if (!_Toplabel) {
        _Toplabel = [[UILabel alloc]init];
        _Toplabel.textAlignment = NSTextAlignmentCenter;
        _Toplabel.textColor = KColorFromRGB(0xF8A012);
        _Toplabel.text = @"银勺会员";
        _Toplabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(11)];
        _Toplabel.backgroundColor = KColorFromRGB(0xFFF2DD);
        _Toplabel.layer.masksToBounds = YES;
        _Toplabel.layer.cornerRadius = 3;
    }
    return  _Toplabel;
}
-(UILabel *)typelabel
{
    if (!_typelabel) {
        _typelabel = [[UILabel alloc]init];
        _typelabel.textAlignment = NSTextAlignmentCenter;
        _typelabel.textColor = KColorFromRGB(0xFBC00B);
        _typelabel.text = @"+50火币≈0.5元";
        _typelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
    }
    return  _typelabel;
}
-(UIImageView *)imagemoney
{
    if (!_imagemoney) {
        _imagemoney = [[UIImageView alloc]init];
        _imagemoney.image= kGetImage(@"rw_icon");
        
    }
    return _imagemoney;
}
-(UIView *)lineview
{
    if (!_lineview) {
        _lineview = [[UIView alloc]init];
        _lineview.backgroundColor = KColorFromRGB(0xf3f3f3);
    }
    return _lineview;
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
