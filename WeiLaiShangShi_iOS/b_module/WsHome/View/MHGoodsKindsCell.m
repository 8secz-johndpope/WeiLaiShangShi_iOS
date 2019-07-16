//
//  MHGoodsKindsCell.m
//  mohu
//
//  Created by 余浩 on 2018/9/15.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHGoodsKindsCell.h"
#import "MHGoodsKindsBtnView.h"
#import "MHPageItemModel.h"
#import "MHSrollView.h"
@interface MHGoodsKindsCell()<UIScrollViewDelegate>
{
    UIView *_backView1;
    UIView *_backView2;
    UIPageControl *_pageControl;
}
@end
@implementation MHGoodsKindsCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)menuArray ImageArray:(NSMutableArray *)ImageArray{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSInteger page=0;
        if (menuArray.count%8==0) {
            page=menuArray.count/8;
        }
        else{
            page=menuArray.count/8+1;
        }
        self.Arr =menuArray;
        NSInteger widthW = 60;
        NSInteger locateX= 28;
        NSInteger pading =( kScreenWidth-2*locateX - widthW *4)/3;
        
        MHSrollView *scrollView = [[MHSrollView alloc]initWithFrame:CGRectMake(0, kRealValue(20), kScreenWidth, kRealValue(180))];
         scrollView.bounces = NO;
        
//        scrollView.backgroundColor = [UIColor redColor];
        scrollView.contentSize = CGSizeMake(page*(kScreenWidth), kRealValue(180));
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        for (int i=0; i<page; i++) {
            _backView1 = [[UIView alloc] initWithFrame:CGRectMake(i*(kScreenWidth), 0, (kScreenWidth), kRealValue(160))];
            [scrollView addSubview:_backView1];
            NSInteger pageNumber=0;
            if (menuArray.count>8) {
                if (i==menuArray.count/8) {
                    pageNumber=menuArray.count%8;
                }
                else{
                    pageNumber=8;
                }
            }
            else{
                pageNumber=menuArray.count;
            }
   
            for (int j = 0; j < pageNumber; j++) {
                if (j < 4) {
                    CGRect frame = CGRectMake(widthW *j+ pading*j +locateX, 0, kRealValue(60), kRealValue(90));
                    MHPageItemModel *model = [menuArray objectAtIndex:(i*8+j)];
                    MHGoodsKindsBtnView *btnView = [[MHGoodsKindsBtnView alloc] initWithFrame:frame title:model.name imageStr:model.sourceUrl];
//                    btnView.backgroundColor = kRandomColor;
                    btnView.tag = 10000+[model.id integerValue];
                    [_backView1 addSubview:btnView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                    [btnView addGestureRecognizer:tap];
                    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
                    //设置长按时间
                   
                    longPressGesture.minimumPressDuration = 0.5;
                    [btnView addGestureRecognizer:longPressGesture];
                    
                }else if(j< 8){
                    CGRect frame = CGRectMake(widthW *(j-4)+ pading*(j-4)+locateX, kRealValue(90), kRealValue(60), kRealValue(90));
                    
                    MHPageItemModel *model = [menuArray objectAtIndex:(i*8+j)];
                    MHGoodsKindsBtnView *btnView = [[MHGoodsKindsBtnView alloc] initWithFrame:frame title:model.name imageStr:model.sourceUrl];
//                     btnView.backgroundColor = kRandomColor;
                    btnView.tag = 10000+[model.id integerValue];
                    [_backView1 addSubview:btnView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                    [btnView addGestureRecognizer:tap];
                    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
                    //设置长按时间
                    longPressGesture.minimumPressDuration = 0.5;
                    [btnView addGestureRecognizer:longPressGesture];
                }
            }
        }
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
        [self addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
            make.height.equalTo(@20);
            make.bottom.equalTo(self.mas_bottom).offset(-2);
        }];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = page;
        _pageControl.hidden = page>1?NO:YES;
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
        [_pageControl setPageIndicatorTintColor:KColorFromRGB(0xe4e4e4)];
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    MHLog(@"tag:%ld",(long)sender.view.tag);
    for (int i = 0; i < self.Arr.count; i++) {
        MHPageItemModel *model   = self.Arr[i];
        if ([[NSString stringWithFormat:@"%@",model.id] isEqualToString:[NSString stringWithFormat:@"%ld",sender.view.tag -10000]]) {
            if (self.block) {
                self.block(sender.view.tag-10000,[NSString stringWithFormat:@"%@",model.name] );
            }
            break;
        }
    }

}

-(void)longPressGesture:(UILongPressGestureRecognizer *)sender
{
    UILongPressGestureRecognizer *longPress = sender;
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        sender.view.backgroundColor=KColorFromRGB(0xdddddd);
    }
    else if (longPress.state == UIGestureRecognizerStateEnded){
        sender.view.backgroundColor=KColorFromRGB(0xffffff);
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    _pageControl.currentPage = page;
}



@end
