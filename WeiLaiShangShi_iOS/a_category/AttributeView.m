//
//  AttributeCollectionView.m
//
//
//  Created by yuaho on 15/12/15.
//  Copyright © 2015年 JP. All rights reserved.
//

#import "AttributeView.h"
#import "UIView+Extnesion.h"



#define margin 15
// 屏幕的宽
#define JPScreenW [UIScreen mainScreen].bounds.size.width
// 屏幕的高
#define JPScreenH [UIScreen mainScreen].bounds.size.height
//RGB
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface AttributeView ()

@property (nonatomic ,weak) UIButton *btn;
@property (nonatomic ,weak) UIButton *previousBtn;
@property (nonatomic, strong)NSMutableArray *btnarr;
@end

@implementation AttributeView

/**
 *  返回一个创建好的属性视图,并且带有标题.创建好之后必须设置视图的Y值.
 *
 *  @param texts 属性数组
 *
 *  @param viewWidth 视图宽度
 *
 *  @return attributeView
 */
+ (AttributeView *)attributeViewWithTitle:(NSString *)title titleFont:(UIFont *)font attributeTexts:(NSArray *)texts viewWidth:(CGFloat)viewWidth IsSort:(BOOL)isSort{
    int count = 0;
    float btnW = 0;
    AttributeView *view = [[AttributeView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"%@ : ",title];
    label.font = font;
    label.textColor = [UIColor blackColor];
    CGSize size = [label.text sizeWithFont:font];
    label.frame = (CGRect){{10,10},size};
    [view addSubview:label];
    for (int i = 0; i<texts.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i;
        [btn addTarget:view action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        NSString *str = texts[i];
        [btn setTitle:str forState:UIControlStateNormal];
        CGSize strsize = [str sizeWithFont:[UIFont boldSystemFontOfSize:13]];
        if (isSort) {
             btn.width = strsize.width + margin*1;
        }else{
             btn.width = strsize.width + margin*3;
        }
//        btn.width = strsize.width + margin*3;
        btn.height = strsize.height+ margin;
//        btn.layer.borderColor= KColorFromRGB(0x999999).CGColor;
//        btn.layer.borderWidth= 1/kScreenScale;
        
        if (i == 0) {
            btn.x = margin;
            btnW += CGRectGetMaxX(btn.frame);
        }
        else{
            btnW += CGRectGetMaxX(btn.frame)+margin;
            if (btnW > viewWidth) {
                count++;
                btn.x = margin;
                btnW = CGRectGetMaxX(btn.frame);
            }
            else{
                
                btn.x += btnW - btn.width;
                
            }
        }
        btn.backgroundColor =[UIColor colorWithRed:250/255.0 green:251/255.0 blue:252/255.0 alpha:1];
        btn.userInteractionEnabled = YES;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        [btn setTitleColor:KColorFromRGB(0x2b2b2b) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [btn setBackgroundImage:[UIImage buttonImageFromColors:@[KColorFromRGB(0xE2E3E2),KColorFromRGB(0xE2E3E2)] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"F84F16"],[UIColor colorWithHexString:@"F84F16"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateSelected];
        btn.y += count * (btn.height + margin) + margin + label.height +8;
        
        if (isSort) {
            btn.layer.cornerRadius =  5;
        }else{
            btn.layer.cornerRadius = (strsize.height+ margin)/2;
        }
        
        
        btn.clipsToBounds = YES;
        btn.tag = i;
        [view addSubview:btn];
        if (i == texts.count - 1) {
            view.height = CGRectGetMaxY(btn.frame) + 10;
            view.x = 0;
            view.width = viewWidth;
        }
//        if ([btn.titleLabel.text isEqualToString:@"全部"]) {
//            btn.selected =YES;
//            btn.tag = 8000+view.tag;
//        }
    }
    return view;
}
+ (AttributeView *)attributeViewWithTitle:(NSString *)title titleFont:(UIFont *)font attributeTexts:(NSArray *)texts viewWidth:(CGFloat)viewWidth IsSort:(BOOL)isSort IsSelectDefault:(NSString *)IsSelectDefault tag:(NSInteger) tag{
    int count = 0;
    float btnW = 0;
    AttributeView *view = [[AttributeView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.tag = 21000+tag;
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"%@ : ",title];
    label.font = font;
    label.textColor = [UIColor blackColor];
    CGSize size = [label.text sizeWithFont:font];
    label.frame = (CGRect){{10,10},size};
    [view addSubview:label];
    for (int i = 0; i<texts.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i;
        [btn addTarget:view action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        NSString *str = texts[i];
        [btn setTitle:str forState:UIControlStateNormal];
        
        CGSize strsize = [str sizeWithFont:[UIFont boldSystemFontOfSize:13]];
        if (isSort) {
            btn.width = strsize.width + margin*1;
        }else{
            btn.width = strsize.width + margin*3;
        }
        //        btn.width = strsize.width + margin*3;
        btn.height = strsize.height+ margin;
//        btn.layer.borderColor= KColorFromRGB(0x999999).CGColor;
//        btn.layer.borderWidth= 1/kScreenScale;
        
        if (i == 0) {
            btn.x = margin;
            btnW += CGRectGetMaxX(btn.frame);
        }
        else{
            btnW += CGRectGetMaxX(btn.frame)+margin;
            if (btnW > viewWidth) {
                count++;
                btn.x = margin;
                btnW = CGRectGetMaxX(btn.frame);
            }
            else{
                
                btn.x += btnW - btn.width;
                
            }
        }
        btn.backgroundColor =[UIColor colorWithRed:250/255.0 green:251/255.0 blue:252/255.0 alpha:1];
        btn.userInteractionEnabled = YES;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        [btn setTitleColor:KColorFromRGB(0x2b2b2b) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [btn setBackgroundImage:[UIImage buttonImageFromColors:@[KColorFromRGB(0xE2E3E2),KColorFromRGB(0xE2E3E2)] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"F84F16"],[UIColor colorWithHexString:@"F84F16"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateSelected];
        btn.y += count * (btn.height + margin) + margin + label.height +8;
        
        if (isSort) {
            btn.layer.cornerRadius =  5;
        }else{
            btn.layer.cornerRadius = kRealValue(10);
        }
        
        
        btn.clipsToBounds = YES;
        btn.tag = view.tag+i;
        [view addSubview:btn];
        if (i == texts.count - 1) {
            view.height = CGRectGetMaxY(btn.frame) + 10;
            view.x = 0;
            view.width = viewWidth;
        }
        if ([btn.titleLabel.text isEqualToString:IsSelectDefault]) {
            btn.selected =YES;
            btn.tag = 8000+view.tag;
        }
        
    }
    return view;
}






- (void)btnClick1:(UIButton *)sender{
    if (![self.btn isEqual:sender]) {
        self.btn.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15f];
        self.btn.selected = NO;
        //        sender.backgroundColor = KColorFromRGB(kThemecolor);
        //                [sender setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
        sender.selected = YES;
    }else if([self.btn isEqual:sender]){
        if (sender.selected == YES) {
//            return;
//            sender.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15f];
//            sender.selected = NO;
        }else{
            //            sender.backgroundColor = KColorFromRGB(kThemecolor);
            //             [sender setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
            sender.selected = YES;
        }
    }else{
        
    }
    if ([self.Attribute_delegate respondsToSelector:@selector(Attribute_View:didClickBtn:)] ) {
        [self.Attribute_delegate Attribute_View:self didClickBtn:sender];
    }
    self.btn = sender;
    
}








- (void)btnClick:(UIButton *)sender{
    if (![self.btn isEqual:sender]) {
        self.btn.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15f];
        self.btn.selected = NO;
//        sender.backgroundColor = AppColor;
        sender.selected = YES;
    }else if([self.btn isEqual:sender]){
        if (sender.selected == YES) {
//            sender.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15f];
            sender.selected = NO;
        }else{
//            sender.backgroundColor = AppColor;
            sender.selected = YES;
        }
    }else{
        
    }
    if ([self.Attribute_delegate respondsToSelector:@selector(Attribute_View:didClickBtn:)] ) {
        [self.Attribute_delegate Attribute_View:self didClickBtn:sender];
    }
    self.btn = sender;
    
}

@end
