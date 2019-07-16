//
//  HSNewsFourCell.m
//  HSKD
//
//  Created by yuhao on 2019/2/25.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSNewsFourCell.h"
#import "HSNewsModel.h"
@implementation HSNewsFourCell

-(void)createviewWithModel:(HSNewsModel *)createmodel
{
    self.titlelabel.text = createmodel.title;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:[createmodel.cover objectAtIndex:0] ] placeholderImage:kGetImage(@"emty_movie")];
        
    
   
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
    
   
    NSInteger Width = kScreenWidth - kRealValue(24);
    self.image = [[UIImageView alloc]init];
//    self.image.contentMode = UIViewContentModeScaleAspectFit;
   
    self.image.clipsToBounds = YES;
     self.image .contentMode =  UIViewContentModeScaleAspectFill;
    

//    self.image.backgroundColor = kRandomColor;
    
    [self addSubview:self.image];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(12));
        
         make.top.equalTo(self.mas_top).with.offset(kRealValue(15));
        make.width.mas_equalTo(Width);
        make.height.mas_equalTo(kRealValue(198));
    }];
    
    UIImageView *playimg = [[UIImageView alloc]init];
    playimg.image = kGetImage(@"play");
    [self.image addSubview:playimg];
    [playimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.image.mas_centerX).offset(kRealValue(0));
         make.centerY.equalTo(self.image.mas_centerY).offset(kRealValue(0));
    }];
    
    
    [self addSubview:self.titlelabel];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
       make.top.equalTo(self.image.mas_bottom).offset(kRealValue(12));
        make.left.equalTo(self.mas_left).offset(kRealValue(12));
        make.width.mas_equalTo(kRealValue(356));
        
    }];
    
  
    
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
}
-(UILabel *)titlelabel
{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.textAlignment = NSTextAlignmentLeft;
        _titlelabel.textColor = KColorFromRGB(0x222222);
        _titlelabel.numberOfLines = 2;
        _titlelabel.text = @"中国诗词大会第四季冠军诞生：北大工科博士生陈更";
        _titlelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
        
    }
    return  _titlelabel;
}
-(UILabel *)typelabel
{
    if (!_typelabel) {
        _typelabel = [[UILabel alloc]init];
        _typelabel.textAlignment = NSTextAlignmentCenter;
        _typelabel.textColor = KColorFromRGB(0x999999);
        _typelabel.text = @"资讯";
        _typelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        //        _typelabel.layer.cornerRadius = kRealValue(3);
        //        _typelabel.layer.borderColor = KColorFromRGB(0xe91111).CGColor;
        //        _typelabel.layer.borderWidth = 1/kScreenScale;
    }
    return  _typelabel;
}
-(UILabel *)authlabel
{
    if (!_authlabel) {
        _authlabel = [[UILabel alloc]init];
        _authlabel.textAlignment = NSTextAlignmentCenter;
        _authlabel.textColor = KColorFromRGB(0x999999);
        _authlabel.text = @"网易新闻";
        _authlabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        
    }
    return  _authlabel;
}
-(UILabel *)timelabel
{
    if (!_timelabel) {
        _timelabel = [[UILabel alloc]init];
        _timelabel.textAlignment = NSTextAlignmentCenter;
        _timelabel.textColor = KColorFromRGB(0x999999);
        _timelabel.text = @"15分钟前";
        _timelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        
    }
    return  _timelabel;
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
