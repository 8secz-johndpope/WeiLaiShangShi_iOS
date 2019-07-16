
//
//  MHTaskDetailImagesCell.m
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTaskDetailImagesCell.h"
#import "MHProductPicModel.h"
@implementation MHTaskDetailImagesCell
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
        [self createview];
    }
    return self;
}
-(void)createview
{
    NSInteger btnoffset = 10;
    NSInteger pading = kRealValue(0);
   
    for (int i = 0; i < self.PictureArr.count; i++) {
       
       
        MHProductPicModel *model = [self.PictureArr objectAtIndex:i];
        if (klObjectisEmpty(model.width)) {
             self.bgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,btnoffset ,kScreenWidth, 2* kScreenHeight)];
            self.bgview.tag = 20190+i;
            [ self.bgview sd_setImageWithURL:[NSURL URLWithString:model.filePath] placeholderImage:kGetImage(@"emty_movie")];
        }else{
             self.bgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,btnoffset ,kScreenWidth,([model.height integerValue] *kScreenWidth /[model.width integerValue]))];
            self.bgview.tag = 20190+i;
            [ self.bgview sd_setImageWithURL:[NSURL URLWithString:model.filePath] placeholderImage:kGetImage(@"emty_movie") ];
        }
        btnoffset = btnoffset + ([model.height integerValue] *kScreenWidth /[model.width integerValue]+pading);
        [self addSubview: self.bgview];
        
    }
}

@end
