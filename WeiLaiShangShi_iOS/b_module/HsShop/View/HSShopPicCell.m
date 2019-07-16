//
//  HSShopPicCell.m
//  HSKD
//
//  Created by AllenQin on 2019/2/28.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSShopPicCell.h"
#import "MHProductPicModel.h"

@implementation HSShopPicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier picArr:(NSArray *)picArr{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *picModelArr = [MHProductPicModel baseModelWithArr:picArr];
        NSInteger btnoffset = 0;
        for (int i = 0; i < picModelArr.count; i++) {
            UIImageView *bgview;
            MHProductPicModel *model = [picModelArr objectAtIndex:i];
            if (klObjectisEmpty(model.width)) {
                bgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,btnoffset ,kScreenWidth, 2* kScreenHeight)];
                [bgview sd_setImageWithURL:[NSURL URLWithString:model.filePath] placeholderImage:kGetImage(@"emty_fang")];
            }else{
                bgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,btnoffset ,kScreenWidth,([model.height integerValue] *kScreenWidth /[model.width integerValue]))];
                [bgview sd_setImageWithURL:[NSURL URLWithString:model.filePath] placeholderImage:kGetImage(@"emty_fang") ];
            }
            btnoffset = btnoffset + ([model.height integerValue] *kScreenWidth /[model.width integerValue]);
            [self.contentView addSubview:bgview];
        }
        
        
    }
    
    return self;
}

@end
