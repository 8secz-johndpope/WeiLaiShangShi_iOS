//
//  HSFriendShopCell.m
//  HSKD
//
//  Created by yuhao on 2019/3/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSFriendShopCell.h"
#import "HSShopItemModel.h"

#define PADDING kFontValue(7)
@interface HSFriendShopCell()
@property (nonatomic, strong) UIScrollView *activityScroll;
@end
@implementation HSFriendShopCell

-(void)setActivityArr:(NSMutableArray *)ActivityArr
{
   
        _ActivityArr = ActivityArr;
        [_activityScroll removeAllSubviews];
        _activityScroll = nil;
        [self createview];
    
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = kBackGroudColor;
        
    }
    return self;
}
-(void)createview{
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(32), kScreenWidth-kRealValue(20), kRealValue(16))];
    title.text = @"特惠优选";
    title.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    title.textColor = [UIColor colorWithHexString:@"#222222"];
    title.textAlignment = NSTextAlignmentLeft;
    [self addSubview:title];
    [self addSubview:self.activityScroll];
    
    self.qiandaobtn = [[UIButton alloc] init];
    [self.qiandaobtn addTarget:self action:@selector(ChongzhiAct) forControlEvents:UIControlEventTouchUpInside];
    [self.qiandaobtn setTitle:@"充值" forState:UIControlStateNormal];
    self.qiandaobtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    self.qiandaobtn.backgroundColor = [UIColor colorWithHexString:@"#F64236"];
    self.qiandaobtn.layer.masksToBounds = YES;
    self.qiandaobtn.layer.cornerRadius = kRealValue(17);
    [self addSubview:self.qiandaobtn];
    [self.qiandaobtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(40));
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(345));
        make.top.equalTo(self.activityScroll.mas_bottom).offset(kRealValue(35));
    }];
    
    
    self.yaoqing = [[UIImageView alloc]init];
    self.yaoqing.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
    [self.yaoqing addGestureRecognizer:tap];
    [self addSubview:self.yaoqing];
    [self.yaoqing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(345));
        make.height.mas_equalTo(kRealValue(70));
        make.top.equalTo(self.qiandaobtn.mas_bottom).offset(kRealValue(40));
    }];
    
    
}
-(void)ChongzhiAct
{
    if (self.chongzhi) {
        self.chongzhi();
    }
}

-(UIScrollView *)activityScroll
{
    if (!_activityScroll) {
        _activityScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kRealValue(70), kScreenWidth, kRealValue(140))];
        _activityScroll.backgroundColor = [UIColor whiteColor];
        _activityScroll.showsHorizontalScrollIndicator = NO;
        _activityScroll.showsVerticalScrollIndicator = NO;
        NSInteger btnoffset = 0;
        for (int i = 0; i < self.ActivityArr.count; i++) {
            float originX =  i? PADDING+btnoffset:kRealValue(15);
            HSShopItemModel *model = [self.ActivityArr objectAtIndex:i];
            UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(originX,kRealValue(5) ,kRealValue(110), kRealValue(130))];
            btnoffset = CGRectGetMaxX(bgview.frame);
            bgview.layer.cornerRadius = kRealValue(3);
            bgview.layer.borderWidth = 1/kScreenScale;
          
            [_activityScroll addSubview:bgview];
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(40), kRealValue(9), kRealValue(36), kRealValue(36))];
            img.centerX = kScreenWidth/10;
//            [img sd_setImageWithURL:[NSURL URLWithString:model.sourceUrl] placeholderImage:kGetImage(@"")];
            [bgview addSubview:img];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(0), kRealValue(17), kRealValue(110), kRealValue(20))];
            label.text = model.productName;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(15)];
            label.textColor = KColorFromRGB(0x222222);
            [bgview addSubview:label];
            
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(0), kRealValue(50), kRealValue(100), kRealValue(20))];
            label1.text = [NSString stringWithFormat:@"￥%@",model.retailPrice];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(24)];
            label1.textColor = KColorFromRGB(0xF6462F);
            [bgview addSubview:label1];
            
            NSString *Str= [NSString stringWithFormat:@"￥%@",model.retailPrice];
            NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:Str];
            [attstring addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0xF5452E) range:NSMakeRange(0, 1)];
            [attstring addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangMedium size:kFontValue(15)] range:NSMakeRange(0, 1)];
           label1.attributedText = attstring;
            

            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(0), kRealValue(83), kRealValue(100), kRealValue(20))];
            label2.text = [NSString stringWithFormat:@"￥%@",model.marketPrice];
            label2.textAlignment = NSTextAlignmentCenter;
            label2.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
            label2.textColor = KColorFromRGB(0x999999);
            [bgview addSubview:label2];
            
            
            NSString *txtstr =[NSString stringWithFormat:@"￥%@",model.marketPrice];
            //中划线
            
            
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:txtstr
                                                                                        attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleNone)}];
            [attrStr setAttributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                                     NSBaselineOffsetAttributeName : @0}
                             range:NSMakeRange(0, txtstr.length )];
            
            
            label2.attributedText = attrStr;

            
            
            bgview.tag = 20000+i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [bgview addGestureRecognizer:tap];
            
            if (model.select == YES) {
                bgview.backgroundColor = KColorFromRGB(0xFEEFEF);
                bgview.layer.borderColor = KColorFromRGB(0xF64236).CGColor;
              
            }else{
                bgview.backgroundColor = KColorFromRGB(0xFFFFFF);
                bgview.layer.borderColor = KColorFromRGB(0xE2E2E2).CGColor;
            }
            
        }
            _activityScroll.contentSize = CGSizeMake(btnoffset+kRealValue(5), kRealValue(140));
    }
    return _activityScroll;
}

-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    MHLog(@"tag:%ld",(long)sender.view.tag);
    
    if (self.block) {
        self.block(sender.view.tag);
    }
}


-(void)imageTap{
    if (self.imageClick) {
        self.imageClick();
    }
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
