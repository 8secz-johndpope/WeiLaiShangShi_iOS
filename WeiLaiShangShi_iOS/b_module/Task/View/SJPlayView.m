//
//  SJPlayView.m
//  SJVideoPlayer
//
//  Created by 畅三江 on 2018/9/30.
//  Copyright © 2018 畅三江. All rights reserved.
//

#import "SJPlayView.h"
#import <Masonry/Masonry.h>

@implementation SJPlayView

@synthesize coverImageView = _coverImageView;
@synthesize playButton = _playButton;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    [self _setupViews];
    return self;
}

- (void)userClickedPlayButton {
    if ( _clickedPlayButtonExeBlock ) _clickedPlayButtonExeBlock(self);
}

- (void)_setupViews {
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.coverImageView];
    [self.coverImageView addSubview:self.playButton];
    
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.offset(0);
        make.bottom.offset(0);
    }];
    
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (UIImageView *)coverImageView {
    if ( _coverImageView ) return _coverImageView;
    _coverImageView = [[UIImageView alloc] init];
    _coverImageView.backgroundColor = KColorFromRGB(0x000000);
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    _coverImageView.clipsToBounds = YES;
    _coverImageView.userInteractionEnabled = YES;
    _coverImageView.tag = 101;
    return _coverImageView;
}

- (UIButton *)playButton {
    if ( _playButton ) return _playButton;
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton setImage:[UIImage imageNamed:@"db_play_big"] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(userClickedPlayButton) forControlEvents:UIControlEventTouchUpInside];
    return _playButton;
}


@end
