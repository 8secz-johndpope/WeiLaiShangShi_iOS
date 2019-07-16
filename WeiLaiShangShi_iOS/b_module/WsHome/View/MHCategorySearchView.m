//
//  MHCategorySearchView.m
//  mohu
//
//  Created by AllenQin on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHCategorySearchView.h"

@implementation MHCategorySearchView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithHexString:@"F2F3F5"];
//        ViewBorderRadius(self, 4, 1, [UIColor colorWithHexString:@"cccccc"]);
        _titlesLabel = [[YYLabel alloc]initWithFrame:CGRectMake(kRealValue(5), 0, self.width, self.height)];
        _titlesLabel.textColor =[UIColor colorWithHexString:@"666666"];
//        _titlesLabel.frame = frame;
        _titlesLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titlesLabel];
        [self createSeachContent:@""];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBarPush)];
        [self addGestureRecognizer:tap];

    }
    return self;
}

-(void)createSeachContent:(NSString *)desc{
    
    
    NSMutableAttributedString *attachment = [NSMutableAttributedString attachmentStringWithContent:[UIImage imageNamed:@"search_left_icon"] contentMode:UIViewContentModeScaleToFill attachmentSize:CGSizeMake(20, 20) alignToFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(12)] alignment:YYTextVerticalAlignmentCenter];
    NSMutableAttributedString *fontDesc = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",desc]];
    fontDesc.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    fontDesc.color = [UIColor colorWithHexString:@"666666"];
    [attachment appendAttributedString: fontDesc];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 设置文字居中
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [paragraphStyle setLineSpacing:1];
    [attachment addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attachment length])];
    _titlesLabel.attributedText = attachment;
    
}

- (void)searchBarPush{
    if (_searchBarBlock) {
        _searchBarBlock();
    }
}

@end
