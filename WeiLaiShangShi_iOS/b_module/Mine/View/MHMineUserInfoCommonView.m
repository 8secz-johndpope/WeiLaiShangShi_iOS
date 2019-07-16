
//
//  MHMineUserInfoCommonView.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineUserInfoCommonView.h"

@implementation MHMineUserInfoCommonView
-(id)initWithFrame:(CGRect)frame righttitle:(NSString *)righttitle lefttitle:(NSString *)lefttitle istopLine:(BOOL)isTopline isBottonLine:(BOOL)isbottomLine
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.title];
        [self addSubview:self.rightIcon];
        [self addSubview:self.righttitle];
        self.righttitle.text = righttitle;
        self.title.text = lefttitle;
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(kRealValue(15));
            make.width.mas_equalTo(kRealValue(100));
            make.height.mas_equalTo(kRealValue(20));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(kRealValue(-16));
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(kRealValue(25));
            make.height.mas_equalTo(kRealValue(25));
        }];
        [self.righttitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightIcon.mas_left).offset(kRealValue(10));
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(kRealValue(20));
        }];
        UIView *linetop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1/kScreenScale)];
        linetop.backgroundColor = KColorFromRGB(0xe0e0e0);
        [self addSubview:linetop];
        
        UIView *linebottom = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(10), self.frame.size.height-1/kScreenScale, kScreenWidth-kRealValue(20), 1/kScreenScale)];
        linebottom.backgroundColor = KColorFromRGB(0xE1E1E1);
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
        _title.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _title.textColor = KColorFromRGB(0x999999);
        _title.textAlignment = NSTextAlignmentLeft;
    }
    return _title;
}
-(UILabel *)righttitle
{
    if (!_righttitle) {
        _righttitle = [[UILabel alloc]init];
        _righttitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _righttitle.textColor = KColorFromRGB(0x222222);
        _righttitle.userInteractionEnabled =YES;
        _righttitle.textAlignment = NSTextAlignmentRight;
    }
    return _righttitle;
}
-(UIImageView *)rightIcon
{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc]init];
        _rightIcon.image= kGetImage(@"ic_public_more");
    }
    return _rightIcon;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
