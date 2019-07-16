//
//  MHProImagesCell.m
//  wgts
//
//  Created by yuhao on 2018/11/9.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHProImagesCell.h"
#import "MHProductPicModel.h"
@implementation MHProImagesCell
-(void)setPictureArr:(NSMutableArray *)PictureArr
{
    if (_PictureArr != PictureArr) {
        _PictureArr = PictureArr;
        [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self createview];
    }
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
-(void)createview
{
    UIView *linebg2 =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,  kRealValue(10))];
    linebg2.backgroundColor = KColorFromRGB(0xF1F3F4);
    //    linebg.backgroundColor = [UIColor redColor];
    [self addSubview:linebg2];
    
    UILabel *labeltitle1 = [[UILabel alloc]init];
    labeltitle1.text = @"图文详情";
    labeltitle1.textColor = KColorFromRGB(0x000000);
    labeltitle1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [self addSubview:labeltitle1];
    
    [labeltitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(16));
        make.top.equalTo(self.mas_top).offset(kRealValue(25));
        make.width.mas_equalTo(kRealValue(60));
        make.height.mas_equalTo(kRealValue(20));
    }];
  
    NSInteger btnoffset = 50;
    for (int i = 0; i < self.PictureArr.count; i++) {
        UIImageView *bgview;
        MHProductPicModel *model = [self.PictureArr objectAtIndex:i];
        if (klObjectisEmpty(model.width)) {
            bgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,btnoffset ,kScreenWidth, 2* kScreenHeight)];
            [bgview sd_setImageWithURL:[NSURL URLWithString:model.filePath] placeholderImage:kGetImage(@"img_bitmap_white")];
        }else{
            bgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,btnoffset ,kScreenWidth,([model.height integerValue] *kScreenWidth /[model.width integerValue]))];
            [bgview sd_setImageWithURL:[NSURL URLWithString:model.filePath] placeholderImage:kGetImage(@"img_bitmap_white") ];
        }
        btnoffset = btnoffset + ([model.height integerValue] *kScreenWidth /[model.width integerValue]);
        [self addSubview:bgview];
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
