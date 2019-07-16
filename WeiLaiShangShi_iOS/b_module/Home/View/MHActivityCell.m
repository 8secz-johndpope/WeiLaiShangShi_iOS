
//
//  MHActivityCell.m
//  mohu
//
//  Created by 余浩 on 2018/9/13.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHActivityCell.h"
#import "MHPageItemModel.h"
#define PADDING 0
@interface MHActivityCell()
@property (nonatomic, strong) UIScrollView *activityScroll;
@end
@implementation MHActivityCell


-(void)setActivityArr:(NSArray *)ActivityArr
{
    if (_ActivityArr != ActivityArr) {
        _ActivityArr = ActivityArr;
        [_activityScroll removeAllSubviews];
        _activityScroll = nil;
         [self createview];
    }
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createview];
    }
    return self;
}
-(void)createview{
   
    [self addSubview:self.activityScroll];
}
-(UIScrollView *)activityScroll
{
    if (!_activityScroll) {
        _activityScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(99))];
        _activityScroll.backgroundColor = [UIColor whiteColor];
        _activityScroll.showsHorizontalScrollIndicator = NO;
        _activityScroll.showsVerticalScrollIndicator = NO;
        NSInteger btnoffset = 0;
        
        for (int i = 1; i < self.ActivityArr.count+1; i++) {
            float originX =  i? PADDING*2+btnoffset:PADDING;
            MHPageItemModel *model = [self.ActivityArr objectAtIndex:i-1];
            UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(originX,0 ,kScreenWidth/5, kRealValue(83))];
            btnoffset = CGRectGetMaxX(bgview.frame);
            [_activityScroll addSubview:bgview];
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(40), kRealValue(15), kRealValue(44), kRealValue(44))];
            img.centerX = kScreenWidth/10;
            [img sd_setImageWithURL:[NSURL URLWithString:model.sourceUrl] placeholderImage:kGetImage(@"")];
            [bgview addSubview:img];

            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(40), kRealValue(66), kRealValue(84), kRealValue(17))];
            label.text = model.name;
            label.centerX = kScreenWidth/10;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
            label.textColor = [UIColor blackColor];
            [bgview addSubview:label];
             bgview.tag = 20000+i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [bgview addGestureRecognizer:tap];
            
            
        }
    }
    return _activityScroll;
}

-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    MHLog(@"tag:%ld",(long)sender.view.tag);
    
    if (self.block) {
        self.block(sender.view.tag);
    }
}
@end
