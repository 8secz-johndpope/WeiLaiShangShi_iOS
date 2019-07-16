


//
//  MHGuessActivityCell.m
//  mohu
//
//  Created by 余浩 on 2018/9/13.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHGuessActivityCell.h"
#import "MHPageItemModel.h"
#define PADDING kRealValue(2.5)
@interface MHGuessActivityCell()
@property (nonatomic, strong) UIScrollView *activityScroll;
@end
@implementation MHGuessActivityCell

-(void)setMHfuliArr:(NSMutableArray *)MHfuliArr
{
    if (_MHfuliArr != MHfuliArr) {
        _MHfuliArr = MHfuliArr;
        [_activityScroll removeAllSubviews];
        _activityScroll = nil;
        [self createview];
    }
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kBackGroudColor;
    
    }
    return self;
}
-(void)createview{
//    self.title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(40))];
//    self.title.text = @"  陌狐福利";
//    self.title.backgroundColor = [UIColor whiteColor];
//    self.title.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
//    self.title.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
//    self.title.textAlignment = NSTextAlignmentLeft;
//    self.title.alpha = 1;
//    self.title.numberOfLines = 0;
//    [self addSubview:self.title];
    [self addSubview:self.activityScroll];
}
-(UIScrollView *)activityScroll
{
    if (!_activityScroll) {
        _activityScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kRealValue(105))];
        _activityScroll.backgroundColor = [UIColor whiteColor];
        _activityScroll.showsHorizontalScrollIndicator = NO;
        _activityScroll.showsVerticalScrollIndicator = NO;
        NSInteger btnoffset = 0;
        float originX  = 0;
        for (int i = 0; i < self.MHfuliArr.count; i++) {
            MHPageItemModel *model = [self.MHfuliArr objectAtIndex:i];
            if (i == 0) {
                originX = kRealValue(15);
            }else{
                originX = PADDING*2+btnoffset;
            }
            UIImageView *bgview = [[UIImageView alloc]initWithFrame:CGRectMake(originX,kRealValue(10) , kRealValue(170), kRealValue(85))];
            btnoffset = CGRectGetMaxX(bgview.frame);
            bgview.tag = 30000+i;
            [bgview sd_setImageWithURL:[NSURL URLWithString:model.sourceUrl] placeholderImage:kGetImage(@"")];
            bgview.layer.masksToBounds = YES;
            bgview.layer.cornerRadius = kRealValue(5);
            
            bgview.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapAct = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BgViewtapAction:)];
            [bgview addGestureRecognizer:tapAct];
//            bgview.backgroundColor = kRandomColor;
            [_activityScroll addSubview:bgview];
            
        }
        _activityScroll.contentSize = CGSizeMake(btnoffset+kRealValue(17), kRealValue(105));
    }
    return _activityScroll;
}
-(void)BgViewtapAction:(UITapGestureRecognizer *)sender
{
    if (self.tapactblock) {
        self.tapactblock(sender.view.tag - 30000);
    }
}

@end
