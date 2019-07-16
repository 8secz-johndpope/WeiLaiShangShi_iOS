//
//  ASScrollViewController.m
//  haochedai
//
//  Created by AllenQin on 16/5/9.
//  Copyright © 2016年 AllenQin. All rights reserved.
//

#import "MHScrollViewController.h"
#define kPageCount 5

@interface MHScrollViewController ()<UIScrollViewDelegate>
@property(strong,nonatomic)UIPageControl *pageControl;

@end

@implementation MHScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view .backgroundColor = [UIColor whiteColor];
    [self setupScrollView];
//    [self createUIPageControl];
}

- (void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:scrollView];
    
    CGFloat imageW = kScreenWidth;
    CGFloat imageH = kScreenHeight;
    for (int page = 0; page < kPageCount; page++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name;
        if (isiPhoneX) {
            name = [NSString stringWithFormat:@"mh_x_gulid_%d",page+1];
        }else{
            name = [NSString stringWithFormat:@"mh_gulid_%d",page+1];
        }
        imageView.image = [UIImage imageNamed:name];
        CGFloat imageX = page * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview:imageView];
        if (page == kPageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    scrollView.contentSize = CGSizeMake(kScreenWidth * kPageCount, kScreenHeight);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
}

#pragma mark UIPageControl一般和滑动视图联用
- (void)createUIPageControl
{
    _pageControl = [[UIPageControl alloc] init];
//    _pageControl.bounds = CGRectMake(0, 0, WIDTH_SCALE(200.f), HEIGHT_SCALE(40.f));
//    _pageControl.center = CGPointMake(WIDTH_SCALE(160.f), kScreenHeight-HEIGHT_SCALE(20.f));
    [self.view addSubview:_pageControl];
    _pageControl.numberOfPages = kPageCount;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"0xeeeeee"];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"0xfce55e"];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(kRealValue(200), kRealValue(40.f)));
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-kRealValue(20.f));
        
    }];
}

- (void)setupLastImageView:(UIImageView *)imageView
{
  
    imageView.userInteractionEnabled = YES;
    _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startBtn addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:_startBtn];
    
    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kRealValue(200)+ kBottomHeight));
        make.top.equalTo(self.view.mas_top).with.offset(kScreenHeight-kRealValue(200) - kBottomHeight);
        make.right.equalTo(self.view.mas_right).with.offset(0);

    }];
    
}

- (void)goHome
{
    if (_goHomeBlock) {
        self.goHomeBlock();
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.x/kScreenWidth >= kPageCount-1 ) {
        
        if (_goHomeBlock) {
            self.goHomeBlock();
        }

    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x / kScreenWidth;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
