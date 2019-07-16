

//
//  MHtaskDesCell.m
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHtaskDesCell.h"

@implementation MHtaskDesCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createview];
    }
    return self;
}
-(void)createview
{
    self.deslabel = [[UILabel alloc]init];
    self.deslabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    self.deslabel.textColor = KColorFromRGB(0x000000);
    self.deslabel.numberOfLines = 0;
    self.deslabel.textAlignment=NSTextAlignmentLeft;
//    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    // 行间距设置为30
//    [paragraphStyle  setLineSpacing:kRealValue(7)];

//    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:testString];
//    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [testString length])];
//    [self.deslabel setAttributedText:setString];
    NSString *Str = @"1、购买任意一款会员商品即可成为金牌推手；购买任意一款高级会员商品成为钻石会员；\n2、金牌推手每天可领取2条金牌推手任务；钻石推手每天可领取2条金牌推手任务之外，还可领取2条钻石推手任务；\n3、做任务时，复制任务文案，保存任务图片/视频，去朋友圈发布广告，注意：朋友圈广告格式必须为：【任务文案+任务图片/视频】；不得屏蔽微信好友查看您的朋友圈；\n4、朋友圈广告发布完毕，回到APP内，点击领取任务按钮，领取任务；2小时候，去朋友圈截图保存，回到APP内，点击提交任务按钮，提交截图。\n5、提交的截图必须是朋友圈全屏截图；\n6、请严格按照以上任务规范完成任务，若后台审核时检查到用户上传虚假任务截图，该用户可能会被冻结账号；\n7、任务当天有效，每日24点清零重置，届时，未完成任务默认过期。";
    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:Str];
    [attstring addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0xFE3344) range:NSMakeRange(312, Str.length -312)];
    [attstring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(312, Str.length -312)];
    self.deslabel.attributedText = attstring;
    [self addSubview:self.deslabel];
   
    
    

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.deslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(16));
        make.right.equalTo(self.mas_right).offset(-kRealValue(16));
        make.top.equalTo(self.mas_top).offset(kRealValue(10));
    }];
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
