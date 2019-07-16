//
//  HSTaskHeadCell.h
//  HSKD
//
//  Created by yuhao on 2019/2/27.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^qiandao)(void);
@interface HSTaskHeadCell : UITableViewCell
@property(nonatomic, strong)UIImageView *headbgImg;
@property(nonatomic, strong)UIView *headbgview;
@property(nonatomic, strong)UILabel *titlelabel;
@property(nonatomic, strong)UILabel *Subtitlelabel;
@property(nonatomic, strong)UIImageView *qiandaoImg;
@property(nonatomic, strong)UILabel *qiandaoLable;
@property(nonatomic, strong)UIImageView *qiandaoImg2;
@property(nonatomic, strong)UILabel *qiandaoLable2;
@property(nonatomic, strong)UIImageView *qiandaoImg3;
@property(nonatomic, strong)UILabel *qiandaoLable3;
@property(nonatomic, strong)UIImageView *qiandaoImg4;
@property(nonatomic, strong)UILabel *qiandaoLable4;
@property(nonatomic, strong)UIImageView *qiandaoImg5;
@property(nonatomic, strong)UILabel *qiandaoLable5;
@property(nonatomic, strong)UIImageView *qiandaoImg6;
@property(nonatomic, strong)UILabel *qiandaoLable6;
@property(nonatomic, strong)UIImageView *qiandaoImg7;
@property(nonatomic, strong)UILabel *qiandaoLable7;
@property(nonatomic, strong)UILabel *qiandaomoneyLable;
@property(nonatomic, strong)UILabel *qiandaomoneyLable2;
@property(nonatomic, strong)UILabel *qiandaomoneyLable3;
@property(nonatomic, strong)UILabel *qiandaomoneyLable4;
@property(nonatomic, strong)UILabel *qiandaomoneyLable5;
@property(nonatomic, strong)UILabel *qiandaomoneyLable6;
@property(nonatomic, strong)UILabel *qiandaomoneyLable7;

@property(nonatomic, strong)UIButton *qiandaobtn;
@property(nonatomic, copy)qiandao Qiandao;
-(void)createviewWithArr:(NSMutableArray *)listArr withDic:(NSMutableDictionary *)dic;
-(void)createViewIndenglu;
@end

NS_ASSUME_NONNULL_END
