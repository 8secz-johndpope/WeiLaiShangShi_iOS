//
//  WeChatStylePlaceHolder.m
//  CYLTableViewPlaceHolder
//
//  Created by 陈宜龙 on 15/12/23.
//  Copyright © 2015年 http://weibo.com/luohanchenyilong/ ÂæÆÂçö@iOSÁ®ãÂ∫èÁä≠Ë¢Å. All rights reserved.
//

static float const kUIemptyOverlayLabelX         = 0;
static float const kUIemptyOverlayLabelY         = 0;
static float const kUIemptyOverlayLabelHeight    = 20;

#import "MHNoDataPlaceHolder.h"

@interface MHNoDataPlaceHolder ()

@property (nonatomic, strong) UIImageView *emptyOverlayImageView;

@end

@implementation MHNoDataPlaceHolder

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)sharedInit {
    self.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    self.contentMode =   UIViewContentModeTop;
    [self addUIemptyOverlayImageView];
    [self addUIemptyOverlayLabel];
     [self setupUIemptyOverlay];
    return self;
}

- (void)addUIemptyOverlayImageView {
    self.emptyOverlayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 130)];
    self.emptyOverlayImageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2 - 50);
    self.emptyOverlayImageView.image = [UIImage imageNamed:@"img_empty"];
    [self addSubview:self.emptyOverlayImageView];
}

- (void)addUIemptyOverlayLabel {
    CGRect emptyOverlayViewFrame = CGRectMake(kUIemptyOverlayLabelX, kUIemptyOverlayLabelY, CGRectGetWidth(self.frame), kUIemptyOverlayLabelHeight);
    self.textLabel = [[UILabel alloc] initWithFrame:emptyOverlayViewFrame];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.numberOfLines = 0;
    self.textLabel.text = @"暂无数据";
    self.textLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    self.textLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    self.textLabel.userInteractionEnabled = YES;
    self.textLabel.frame = ({
        CGRect frame = self.textLabel.frame;
        frame.origin.y = CGRectGetMaxY(self.emptyOverlayImageView.frame) + 30;
        frame;
    });
    [self addSubview:self.textLabel];
}
- (void)setupUIemptyOverlay {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPressUIemptyOverlay = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressUIemptyOverlay:)];
    [longPressUIemptyOverlay setMinimumPressDuration:0.001];
    [self.emptyOverlayImageView addGestureRecognizer:longPressUIemptyOverlay];
    self.emptyOverlayImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *longPressUIemptyOverlay2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(longPressUIemptyOverlay2:)];
    [self.textLabel addGestureRecognizer:longPressUIemptyOverlay2];
    
    
}

- (void)longPressUIemptyOverlay:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.emptyOverlayImageView.alpha = 0.4;
    }
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        self.emptyOverlayImageView.alpha = 1;
        if ([self.delegate respondsToSelector:@selector(NodataemptyOverlayClicked:)]) {
            [self.delegate NodataemptyOverlayClicked:nil];
        }
    }
}
- (void)longPressUIemptyOverlay2:(UITapGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.emptyOverlayImageView.alpha = 0.4;
    }
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        self.emptyOverlayImageView.alpha = 1;
        if ([self.delegate respondsToSelector:@selector(NodataemptyOverlayClicked:)]) {
            [self.delegate NodataemptyOverlayClicked:nil];
        }
    }
      
    
    
}


@end
