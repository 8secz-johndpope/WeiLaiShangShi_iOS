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

#import "MHNetworkErrorPlaceHolder.h"

@interface MHNetworkErrorPlaceHolder ()

@property (nonatomic, strong) UIImageView *emptyOverlayImageView;

@end

@implementation MHNetworkErrorPlaceHolder

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
    self.emptyOverlayImageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2 -100);
    self.emptyOverlayImageView.image = [UIImage imageNamed:@"WebView_LoadFail_Refresh_Icon"];
    [self addSubview:self.emptyOverlayImageView];
}

- (void)addUIemptyOverlayLabel {
    CGRect emptyOverlayViewFrame = CGRectMake(kUIemptyOverlayLabelX, kUIemptyOverlayLabelY, CGRectGetWidth(self.frame), kUIemptyOverlayLabelHeight);
    UILabel *emptyOverlayLabel = [[UILabel alloc] initWithFrame:emptyOverlayViewFrame];
    emptyOverlayLabel.textAlignment = NSTextAlignmentCenter;
    emptyOverlayLabel.numberOfLines = 0;
    emptyOverlayLabel.backgroundColor = [UIColor clearColor];
    emptyOverlayLabel.text = @"网络异常";
    emptyOverlayLabel.font = [UIFont boldSystemFontOfSize:14];
    emptyOverlayLabel.frame = ({
        CGRect frame = emptyOverlayLabel.frame;
        frame.origin.y = CGRectGetMaxY(self.emptyOverlayImageView.frame) + 30;
        frame;
    });
    emptyOverlayLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    emptyOverlayLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [self addSubview:emptyOverlayLabel];
    
    
    UILabel *emptyOverlayLabel1 = [[UILabel alloc] initWithFrame:emptyOverlayViewFrame];
    emptyOverlayLabel1.textAlignment = NSTextAlignmentCenter;
    emptyOverlayLabel1.numberOfLines = 0;
    emptyOverlayLabel1.backgroundColor = [UIColor clearColor];
    emptyOverlayLabel1.text = @"点击屏幕，重新加载";
    emptyOverlayLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    emptyOverlayLabel1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    emptyOverlayLabel1.font = [UIFont boldSystemFontOfSize:12];
    emptyOverlayLabel1.frame = ({
        CGRect frame = emptyOverlayLabel1.frame;
        frame.origin.y = CGRectGetMaxY(emptyOverlayLabel.frame) + 20;
        frame;
    });
    [self addSubview:emptyOverlayLabel1];
}

- (void)setupUIemptyOverlay {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPressUIemptyOverlay = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressUIemptyOverlay:)];
    [longPressUIemptyOverlay setMinimumPressDuration:0.001];
    [self addGestureRecognizer:longPressUIemptyOverlay];
    self.userInteractionEnabled = YES;
}

- (void)longPressUIemptyOverlay:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.emptyOverlayImageView.alpha = 0.4;
    }
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        self.emptyOverlayImageView.alpha = 1;
        if ([self.delegate respondsToSelector:@selector(emptyOverlayClicked:)]) {
            [self.delegate emptyOverlayClicked:nil];
        }
    }
}

@end
