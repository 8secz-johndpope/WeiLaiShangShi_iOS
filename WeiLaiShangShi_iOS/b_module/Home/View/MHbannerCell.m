//
//  MHbannerCell.m
//  mohu
//
//  Created by 余浩 on 2018/9/13.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHbannerCell.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "MHBannerItem.h"
#import "MHPageItemModel.h"
@interface MHbannerCell()<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>
//轮播图
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@end
@implementation MHbannerCell

-(void)setBannerArr:(NSArray *)bannerArr
{
    if (_bannerArr != bannerArr) {
        _bannerArr = bannerArr;
        _pageControl.numberOfPages = self.bannerArr.count;
        [self.pagerView reloadData];
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
    [self addSubview:self.pagerView];
    [_pagerView reloadData];
}
-(TYCyclePagerView *)pagerView
{
    if (!_pagerView) {
        _pagerView = [[TYCyclePagerView alloc]init];
        _pagerView.frame =CGRectMake(0, 0, kScreenWidth,  kRealValue(188));
        _pagerView.isInfiniteLoop = YES;
        _pagerView.autoScrollInterval = 5;
        _pagerView.dataSource = self;
        _pagerView.delegate = self;
        [_pagerView registerClass:[MHBannerItem class] forCellWithReuseIdentifier:@"cellId"];
        TYPageControl *pageControl = [[TYPageControl alloc]init];
        pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
        //pageControl.numberOfPages = _datas.count;
        pageControl.currentPageIndicatorSize = CGSizeMake(12, 3);
        pageControl.pageIndicatorSize = CGSizeMake(8, 3);
        pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"000000" andAlpha:.4];
        //    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
        //    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
        //    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
        //    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
        [_pagerView addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pagerView;
}
#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.bannerArr.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    MHBannerItem *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    MHPageItemModel *model = self.bannerArr[index];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.sourceUrl]  placeholderImage:kGetImage(@"")];
   

    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake( kScreenWidth , kRealValue(188));
    layout.layoutType=TYCyclePagerTransformLayoutNormal;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    MHLog(@"%ld ->  %ld",fromIndex,toIndex);
}
- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index
{
    if (self.bannerArr.count > 0) {
        MHPageItemModel *model = [self.bannerArr objectAtIndex:index];
        if ([[NSString stringWithFormat:@"%ld",model.actionUrlType] isEqualToString:@"0"] ) {
            
            if (self.changepage) {
                self.changepage(@"0",model.actionUrl );
                
            }
        }
        if ([[NSString stringWithFormat:@"%ld",model.actionUrlType] isEqualToString:@"1"] ) {
            NSData *jsonData = [model.actionUrl dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
            if (err) {
                NSLog(@"json解析失败：%@",err);
            }else{
                if ([[NSString stringWithFormat:@"%@",[dic valueForKey:@"code"]] isEqualToString:@"5"]) {
                    //产品详情
                    if (self.changepage) {
                        self.changepage(@"5",[dic valueForKey:@"param"] );
                        
                    }
                }
                
            }
            
            
        }
    }
    
}



@end
