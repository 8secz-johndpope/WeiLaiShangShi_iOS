//
//  MHMineUserInfoCommonViewThrid.m
//  mohu
//
//  Created by yuhao on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineUserInfoCommonViewThrid.h"

@implementation MHMineUserInfoCommonViewThrid
-(id)initWithFrame:(CGRect)frame lefttitle:(NSString *)lefttitle textfield:(NSString *)textfield  istopLine:(BOOL)isTopline isBottonLine:(BOOL)isbottomLine
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.title];
        [self addSubview:self.textfield];
        
        self.title.text = lefttitle;
        self.textfield.placeholder  = textfield;
       
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(kRealValue(15));
            make.height.mas_equalTo(kRealValue(20));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.title.mas_right).offset(kRealValue(0));
             make.left.equalTo(self.mas_left).offset(kRealValue(15));
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(kRealValue(-24));
            make.height.mas_equalTo(kRealValue(25));
        }];
       
        UIView *linetop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1/kScreenScale)];
        linetop.backgroundColor = KColorFromRGB(0xe0e0e0);
        [self addSubview:linetop];
        
        UIView *linebottom = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1/kScreenScale, kScreenWidth, 1/kScreenScale)];
        linebottom.backgroundColor = KColorFromRGB(0xe0e0e0);
        [self addSubview:linebottom];
        
        
        if (isTopline == NO ) {
            linetop.hidden =YES;
        }
        if (isbottomLine == NO) {
            linebottom.hidden = YES;
        }
        
    }
    return self;
}
-(UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
        _title.textColor = KColorFromRGB(0xB9BABF);
        _title.textAlignment = NSTextAlignmentLeft;
    }
    return _title;
}
-(UITextField *)textfield
{
    if (!_textfield) {
        _textfield = [[UITextField alloc]init];
        _textfield.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _textfield.textColor = KColorFromRGB(0x000000);
        _textfield.textAlignment = NSTextAlignmentLeft;
       
    }
    return _textfield;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
