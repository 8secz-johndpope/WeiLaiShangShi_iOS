//
//  HSNewsSixCell.m
//  HSKD
//
//  Created by yuhao on 2019/3/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSNewsSixCell.h"
#import "HSNewsModel.h"
@implementation HSNewsSixCell

-(void)createviewWithModel:(HSNewsModel *)createmodel
{
    self.titlelabel.text = createmodel.title;
    self.authlabel.text = createmodel.source;
       self.timelabel.text =@"" ;
    self.typelabel.text = createmodel.tag;
    for (int i=0; i<createmodel.cover.count; i++) {
        NSString *str =[createmodel.cover objectAtIndex:0];
        NSString *Str1 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self.image sd_setImageWithURL:[NSURL URLWithString:[createmodel.cover objectAtIndex:0]] placeholderImage:kGetImage(@"emty_movie")];
        
    }
    if (createmodel.top == 1) {
        //全部都显示
        
        [self.Toplabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titlelabel.mas_left).offset(kRealValue(0));
            make.top.equalTo(self.titlelabel.mas_bottom).offset(kRealValue(229));
            make.height.mas_equalTo(kRealValue(16));
            make.width.mas_equalTo(30);
        }];
        if (klStringisEmpty(createmodel.tag)) {
            //tag 为空
            
            [self.typelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.Toplabel.mas_right).offset(kRealValue(10));
               make.centerY.equalTo(self.Toplabel.mas_centerY).offset(kRealValue(0));
                make.height.mas_equalTo(kRealValue(16));
                make.width.mas_equalTo(0);
            }];
            if (klStringisEmpty(createmodel.source)) {
                
                [self.authlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.Toplabel.mas_right).offset(kRealValue(10));
                    make.centerY.equalTo(self.typelabel.mas_centerY).offset(kRealValue(0));
                    make.width.mas_equalTo(0);
                    
                }];
                [self.timelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.authlabel.mas_right).offset(kRealValue(0));
                    make.centerY.equalTo(self.authlabel.mas_centerY).offset(kRealValue(0));
                    
                }];
            }else{
                [self.authlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.typelabel.mas_right).offset(kRealValue(10));;
                    make.centerY.equalTo(self.typelabel.mas_centerY).offset(kRealValue(0));
                    
                }];
                [self.timelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.authlabel.mas_right).offset(kRealValue(16));
                    make.centerY.equalTo(self.authlabel.mas_centerY).offset(kRealValue(0));
                    
                }];
            }
            
            
        }else{
            [self.typelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.Toplabel.mas_right).offset(kRealValue(10));
             make.centerY.equalTo(self.Toplabel.mas_centerY).offset(kRealValue(0));
                make.height.mas_equalTo(kRealValue(16));
              
            }];
            if (klStringisEmpty(createmodel.source)) {
                
                [self.authlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.typelabel.mas_right).offset(kRealValue(10));
                    make.centerY.equalTo(self.typelabel.mas_centerY).offset(kRealValue(0));
                    make.width.mas_equalTo(0);
                    
                }];
                [self.timelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.authlabel.mas_right).offset(kRealValue(0));
                    make.centerY.equalTo(self.authlabel.mas_centerY).offset(kRealValue(0));
                    
                }];
            }else{
                [self.authlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.typelabel.mas_right).offset(kRealValue(10));;
                    make.centerY.equalTo(self.typelabel.mas_centerY).offset(kRealValue(0));
                    
                }];
                [self.timelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.authlabel.mas_right).offset(kRealValue(16));
                    make.centerY.equalTo(self.authlabel.mas_centerY).offset(kRealValue(0));
                    
                }];
            }
            
            
        }
        
        
    }else{
        [self.Toplabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titlelabel.mas_left).offset(kRealValue(0));
            make.top.equalTo(self.titlelabel.mas_bottom).offset(kRealValue(229));
            make.height.mas_equalTo(kRealValue(16));
            make.width.mas_equalTo(0);
        }];
        if (klStringisEmpty(createmodel.tag)) {
            [self.typelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titlelabel.mas_left).offset(kRealValue(0));
                make.top.equalTo(self.titlelabel.mas_bottom).offset(kRealValue(229));
                make.height.mas_equalTo(kRealValue(16));
                make.width.mas_equalTo(0);
            }];
            if (klStringisEmpty(createmodel.source)) {
                [self.authlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.titlelabel.mas_left).offset(kRealValue(0));
                    make.centerY.equalTo(self.typelabel.mas_centerY).offset(kRealValue(0));
                    make.width.mas_equalTo(0);
                    
                }];
                [self.timelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.titlelabel.mas_left).offset(kRealValue(0));
                    make.centerY.equalTo(self.authlabel.mas_centerY).offset(kRealValue(0));
                    
                }];
            }else{
                [self.authlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.titlelabel.mas_left).offset(kRealValue(0));;
                    make.centerY.equalTo(self.typelabel.mas_centerY).offset(kRealValue(0));
                    
                }];
                [self.timelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.authlabel.mas_right).offset(kRealValue(16));
                    make.centerY.equalTo(self.authlabel.mas_centerY).offset(kRealValue(0));
                    
                }];
            }
            
            
        }else{
            [self.typelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titlelabel.mas_left).offset(kRealValue(0));
                make.top.equalTo(self.titlelabel.mas_bottom).offset(kRealValue(229));
                make.height.mas_equalTo(kRealValue(16));
               
            }];
            if (klStringisEmpty(createmodel.source)) {
                [self.authlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.typelabel.mas_right).offset(kRealValue(10));
                    make.centerY.equalTo(self.typelabel.mas_centerY).offset(kRealValue(0));
                    make.width.mas_equalTo(0);
                    
                }];
                [self.timelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.titlelabel.mas_left).offset(kRealValue(0));
                    make.centerY.equalTo(self.authlabel.mas_centerY).offset(kRealValue(0));
                    
                }];
            }else{
                [self.authlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.typelabel.mas_right).offset(kRealValue(10));;
                    make.centerY.equalTo(self.typelabel.mas_centerY).offset(kRealValue(0));
                    
                }];
                [self.timelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.authlabel.mas_right).offset(kRealValue(16));
                    make.centerY.equalTo(self.authlabel.mas_centerY).offset(kRealValue(0));
                    
                }];
            }
        }
    }
    
    if ([createmodel.tag isEqualToString:@"广告"]) {
        self.authlabel.hidden = YES;
        self.timelabel.hidden = YES;
        
    }else{
        self.authlabel.hidden = NO;
        self.timelabel.hidden = NO;
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
        
        make.top.equalTo(self.mas_top).with.offset(kRealValue(15));
        make.left.equalTo(self.mas_left).offset(kRealValue(12));
        make.width.mas_equalTo(kRealValue(361));
        
    }];
    NSInteger pading  = kRealValue(3);
    NSInteger LoctionX = self.titlelabel.frame.origin.x;
    NSInteger Width = kScreenWidth - kRealValue(24);
    self.image = [[UIImageView alloc]init];
//    self.image.backgroundColor = kRandomColor;
    self.image.clipsToBounds = YES;
    self.image .contentMode =  UIViewContentModeScaleAspectFill;
    
    
    [self addSubview:self.image];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(12));
        make.top.equalTo(self.titlelabel.mas_bottom).offset(kRealValue(12));
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
    
    [self addSubview:self.Toplabel];
    [self.Toplabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titlelabel.mas_left).offset(kRealValue(0));
        make.top.equalTo(self.image.mas_bottom).offset(kRealValue(229));
        make.height.mas_equalTo(kRealValue(16));
        make.width.mas_equalTo(30);
        
    }];
    
    
    
    [self addSubview:self.typelabel];
    [self addSubview:self.authlabel];
    [self addSubview:self.timelabel];
    [self addSubview:self.lineview];
    
    [self.typelabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.Toplabel.mas_right).offset(kRealValue(10));
        make.top.equalTo(self.image.mas_bottom).offset(kRealValue(15));
        make.height.mas_equalTo(kRealValue(16));
    }];
    [self.authlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typelabel.mas_right).offset(kRealValue(16));
        make.centerY.equalTo(self.typelabel.mas_centerY).offset(kRealValue(0));
        
    }];
    [self.timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authlabel.mas_right).offset(kRealValue(16));
        make.centerY.equalTo(self.authlabel.mas_centerY).offset(kRealValue(0));
        
    }];
    [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(0));
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(1/kScreenScale);
        make.top.equalTo(self.typelabel.mas_bottom).offset(kRealValue(10));
    }];
    
    
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
}
-(UILabel *)Toplabel
{
    if (!_Toplabel) {
        _Toplabel = [[UILabel alloc]init];
        _Toplabel.textAlignment = NSTextAlignmentCenter;
        _Toplabel.textColor = KColorFromRGB(0xe91111);
        _Toplabel.text = @"置顶";
        _Toplabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(11)];
        _Toplabel.layer.cornerRadius = kRealValue(3);
        _Toplabel.layer.borderColor = KColorFromRGB(0xe91111).CGColor;
        _Toplabel.layer.borderWidth = 1/kScreenScale;
    }
    return  _Toplabel;
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
