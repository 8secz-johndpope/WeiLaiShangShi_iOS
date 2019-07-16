//
//  SJTableViewCell.m
//  SJVideoPlayer
//
//  Created by 畅三江 on 2018/9/30.
//  Copyright © 2018 畅三江. All rights reserved.
//

#import "SJTableViewCell.h"
#import <Masonry/Masonry.h>
#import "HSNewsModel.h"
@implementation SJTableViewCell

-(void)createviewWithModel:(HSNewsModel *)createmodel
{
//    self.titlelabel.text = createmodel.title;
//    self.authlabel.text = createmodel.author;
//    self.timelabel.text = createmodel.createTime;
//    self.typelabel.text = createmodel.tag;
    if (createmodel.cover.count > 0 ) {
        [self.view.coverImageView sd_setImageWithURL:[NSURL URLWithString:[createmodel.cover objectAtIndex:0]]];
    }
   
    
}

+ (SJTableViewCell *)cellWithTableView:(UITableView *)tableView {
    static NSString *SJTableViewCellID = @"SJTableViewCell";
    SJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SJTableViewCellID];
    if ( !cell ) cell = [[SJTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SJTableViewCellID];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( !self ) return nil;
    self.contentView.backgroundColor = KColorFromRGB(0xffffff);
    
//    [self addSubview:self.titlelabel];
//    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.mas_top).with.offset(kRealValue(15));
//        make.left.equalTo(self.mas_left).offset(kRealValue(12));
//        make.width.mas_equalTo(kRealValue(356));
//
//    }];
    
    NSInteger pading  = kRealValue(3);
    NSInteger LoctionX = self.titlelabel.frame.origin.x;
    NSInteger Width = kScreenWidth - kRealValue(0);
    _view = [SJPlayView new];
//    _view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    _view.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * 9 / 16.0 + 8);
    
    [self addSubview:_view];
    
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(0) );
        make.top.equalTo(self.mas_top).offset(kRealValue(12));
        make.width.mas_equalTo(Width);
        make.height.mas_equalTo(kRealValue(198));
    }];
    
//    [self addSubview:self.typelabel];
//    [self addSubview:self.authlabel];
//    [self addSubview:self.timelabel];
//    [self addSubview:self.lineview];
//
//    [self.typelabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.titlelabel.mas_left).offset(kRealValue(0));
//        make.top.equalTo(self.titlelabel.mas_bottom).offset(kRealValue(219));
////        make.width.mas_equalTo(kRealValue(28));
//        make.height.mas_equalTo(kRealValue(16));
//    }];
//    [self.authlabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.typelabel.mas_right).offset(kRealValue(16));
//        make.centerY.equalTo(self.typelabel.mas_centerY).offset(kRealValue(0));
//
//    }];
//    [self.timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.authlabel.mas_right).offset(kRealValue(16));
//        make.centerY.equalTo(self.authlabel.mas_centerY).offset(kRealValue(0));
//
//    }];
//    [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(kRealValue(0));
//        make.width.mas_equalTo(kScreenWidth);
//        make.height.mas_equalTo(1/kScreenScale);
//        make.top.equalTo(self.mas_top).offset(kRealValue(305));
//    }];
//
    
    
    
    return self;
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
        _typelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(11)];
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
        _authlabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
        
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
        _timelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
        
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


@end
