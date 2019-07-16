//
//  HSTaskSectionCell.m
//  HSKD
//
//  Created by yuhao on 2019/3/11.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSTaskSectionCell.h"
#import "SGPagingView.h"
@interface HSTaskSectionCell ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) NSMutableArray *titleArr;

@end
@implementation HSTaskSectionCell

-(void)setselecttab:(NSInteger)index
{
    if (index == 1) {
        [self.pageTitleView setSelectedIndex:0];
    }else{
        [self.pageTitleView setSelectedIndex:1];
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
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(12), kRealValue(0), kScreenWidth - kRealValue(24), kRealValue(50))];
    bgview.backgroundColor = KColorFromRGB(0xffffff);
    [self addSubview:bgview];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: bgview.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6,6)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bgview.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    bgview.layer.mask = maskLayer;
    
     self.titleArr = [NSMutableArray arrayWithObjects:@"银勺任务",@"金勺任务", nil];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleFixed;
    configure.needBounces = NO;
    configure.titleAdditionalWidth = kRealValue(5);
    configure.showBottomSeparator = NO;
//    configure.indicatorDynamicWidth = (kScreenWidth - kRealValue(66))/2;
    configure.indicatorToBottomDistance = -10;
    configure.indicatorCornerRadius = 2.5;
    configure.titleColor = [UIColor colorWithHexString:@"777777"];
    configure.titleSelectedColor = KColorFromRGB(kThemecolor);
    configure.indicatorColor = KColorFromRGB(kThemecolor);
    configure.indicatorHeight = 2.5;
    configure.titleFont = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
    configure.titleSelectedFont =[UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
    configure.titleFont = [UIFont fontWithName:kPingFangMedium size:18];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(kRealValue(5), kRealValue(0), kScreenWidth - kRealValue(34), kRealValue(50)) delegate:self  titleNames:self.titleArr configure:configure];
    [bgview addSubview:self.pageTitleView];
   
}
-(void)setSelectTab:(NSInteger)index
{
    [self.pageTitleView setSelectedIndex:index];
}
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex
{
    if (self.ChangeTab) {
        if (selectedIndex ==0) {
            self.ChangeTab(1);
        }
        if (selectedIndex ==1) {
            self.ChangeTab(2);
        }
        
    }
    MHLog(@"%ld",selectedIndex);
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
