//
//  CYPasswordInputView.m
//  CYPasswordViewDemo
//
//  Created by cheny on 15/10/8.
//  Copyright © 2015年 zhssit. All rights reserved.
//

#import "CYPasswordInputView.h"
#import "CYConst.h"
#import "UIView+Extension.h"
#import "NSBundle+CYPasswordView.h"
#import "RichStyleLabel.h"

#define kNumCount 6

@interface CYPasswordInputView ()

/** 保存用户输入的数字集合 */
@property (nonatomic, strong) NSMutableArray *inputNumArray;
/** 关闭按钮 */
@property (nonatomic, weak) UIButton *btnClose;
/** 忘记密码 */
@property (nonatomic, weak) UIButton *btnForgetPWD;

@property (nonatomic, strong)RichStyleLabel *currentPrice;

@property (nonatomic, strong)UILabel *feeLabel;



@end

@implementation CYPasswordInputView

#pragma mark  - 生命周期方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        /** 注册通知 */
        [self setupNotification];
        /** 添加子控件 */
        [self setupSubViews];

    }
    return self;
}


-(void)setMoneyStr:(NSString *)moneyStr{
    _moneyStr = moneyStr;
    [_currentPrice setAttributedText:self.moneyStr withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(32)]}];
}

-(void)setFeeStr:(NSString *)feeStr{
    _feeStr = feeStr;
    _feeLabel.text = feeStr;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置关闭按钮的坐标
    self.btnClose.width = CYPasswordViewCloseButtonWH;
    self.btnClose.height = CYPasswordViewCloseButtonWH;
    self.btnClose.x =   CYScreenWith - CYPasswordViewCloseButtonWH;
    self.btnClose.centerY = CYPasswordViewTitleHeight * 0.5;

    // 设置忘记密码按钮的坐标
    self.btnForgetPWD.centerX = self.centerX;
    self.btnForgetPWD.y = 232;
    
    _currentPrice.centerX = self.centerX;
    _currentPrice.y = 70;
    _currentPrice.width = self.size.width;
    _currentPrice.height = 40;
    
    _feeLabel.centerX = self.centerX;
    _feeLabel.y = 120;
    _feeLabel.width = self.size.width;
    _feeLabel.height = 20;
}

- (void)dealloc
{
    CYLog(@"cy =========== %@：我走了", [self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 添加子控件 */
- (void)setupSubViews
{
    /** 关闭按钮 */
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btnCancel];
    [btnCancel setImage:[UIImage imageNamed:@"ic_cloos_dark"] forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.btnClose = btnCancel;
    [self.btnClose addTarget:self action:@selector(btnClose_Click:) forControlEvents:UIControlEventTouchUpInside];

    /** 忘记密码按钮 */
    UIButton *btnForgetPWD = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btnForgetPWD];
    [btnForgetPWD setTitle:@"忘记密码" forState:UIControlStateNormal];
    [btnForgetPWD setTitleColor:[UIColor colorWithRed:104/255.0 green:157/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    btnForgetPWD.titleLabel.font =  [UIFont fontWithName:@"PingFang-SC-Regular" size:kFontValue(12)];
    [btnForgetPWD sizeToFit];
    self.btnForgetPWD = btnForgetPWD;
    [self.btnForgetPWD addTarget:self action:@selector(btnForgetPWD_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    _currentPrice = [[RichStyleLabel alloc]init];
    _currentPrice.textColor = [UIColor blackColor];
    _currentPrice.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:kFontValue(14)];
    _currentPrice.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_currentPrice];
    
    _feeLabel = [[UILabel alloc] init];
    _feeLabel.textColor = [UIColor blackColor];
    _feeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:kFontValue(14)];
    _feeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_feeLabel];
    
//    NSString *money = self.moneyStr ? self.moneyStr : @"¥999";
//    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:money];
//    [attstring addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:kFontValue(14)] range:NSMakeRange(0, 1)];
//    _currentPrice.attributedText = attstring;
    
    
}

/** 注册通知 */
- (void)setupNotification {
    // 用户按下删除键通知
    [CYNotificationCenter addObserver:self selector:@selector(delete) name:CYPasswordViewDeleteButtonClickNotification object:nil];
    // 用户按下数字键通知
    [CYNotificationCenter addObserver:self selector:@selector(number:) name:CYPasswordViewNumberButtonClickNotification object:nil];
    [CYNotificationCenter addObserver:self selector:@selector(disEnalbeCloseButton:) name:CYPasswordViewDisEnabledUserInteractionNotification object:nil];
    [CYNotificationCenter addObserver:self selector:@selector(disEnalbeCloseButton:) name:CYPasswordViewEnabledUserInteractionNotification object:nil];
}

// 按钮点击
- (void)btnClose_Click:(UIButton *)sender {
    [CYNotificationCenter postNotificationName:CYPasswordViewCancleButtonClickNotification object:self];
    [self.inputNumArray removeAllObjects];
}

- (void)btnForgetPWD_Click:(UIButton *)sender {
    [CYNotificationCenter postNotificationName:CYPasswordViewForgetPWDButtonClickNotification object:self];
}

- (void) disEnalbeCloseButton:(NSNotification *)notification{
    BOOL flag = [[notification.object valueForKeyPath:@"enable"] boolValue];
    self.btnClose.userInteractionEnabled = flag;
    self.btnForgetPWD.userInteractionEnabled = flag;
}

- (void)drawRect:(CGRect)rect {

    UIImage *imgTextfield = [UIImage imageNamed:@"input"];

    CGFloat textfieldY = 177;
    CGFloat textfieldW = CYScreenWith;
    CGFloat textfieldX = 0;
    //等比例适配一波
    CGFloat textfieldH = kRealValue(44);
    [imgTextfield drawInRect:CGRectMake(textfieldX, textfieldY, textfieldW, textfieldH)];

    // 画标题
    NSString *title = self.title ? self.title : @"余额支付";

    NSDictionary *arrts = @{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:kFontValue(12)]};
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arrts context:nil].size;
    CGFloat titleW = size.width;
    CGFloat titleH = size.height;
    CGFloat titleX = (self.width - titleW) * 0.5;
    CGFloat titleY = 40;
    CGRect titleRect = CGRectMake(titleX, titleY, titleW, titleH);

    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont fontWithName:@"PingFang-SC-Regular" size:kFontValue(12)];;
    attr[NSForegroundColorAttributeName] = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [title drawInRect:titleRect withAttributes:attr];

    // 画点
    UIImage *pointImage = [NSBundle cy_pointImage];
    CGFloat pointW = CYPasswordViewPointnWH;
    CGFloat pointH = CYPasswordViewPointnWH;
    CGFloat pointY =  textfieldY + (textfieldH - pointH) * 0.5;
    __block CGFloat pointX;

    // 一个格子的宽度
    
    CGFloat cellW = (textfieldW - kRealValue(112))/ kNumCount;
    CGFloat padding = (cellW - pointW) * 0.5;
    [self.inputNumArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        pointX = kRealValue(31) + (padding *(idx+1))+ idx*(kRealValue(10)+padding+CYPasswordViewPointnWH);
        [pointImage drawInRect:CGRectMake(pointX, pointY, pointW, pointH)];
    }];
}

#pragma mark  - 懒加载
- (NSMutableArray *)inputNumArray {
    if (_inputNumArray == nil) {
        _inputNumArray = [NSMutableArray array];
    }
    return _inputNumArray;
}

#pragma mark  - 私有方法
// 响应用户按下删除键事件
- (void)delete {
    [self.inputNumArray removeLastObject];
    [self setNeedsDisplay];
}

// 响应用户按下数字键事件
- (void)number:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    NSString *numObj = userInfo[CYPasswordViewKeyboardNumberKey];
    if (numObj.length >= kNumCount) return;
    [self.inputNumArray addObject:numObj];
    [self setNeedsDisplay];
}

@end
