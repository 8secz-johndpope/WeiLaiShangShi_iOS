//
//  JKCityPickViewController.m
//  地区选择器封装
//
//  Created by yuhao on 2017/3/6.
//  Copyright © 2017年 uhqsh. All rights reserved.
//

#import "JKCityPickViewController.h"
#import "JKCityPickView.h"
@interface JKCityPickViewController ()
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, strong) JKCityPickView *cityPicker;
@property (nonatomic, copy) __actionBlock backBlock;
@end

@implementation JKCityPickViewController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CALayer *)maskLayer {
    if (_maskLayer == nil) {
        _maskLayer = [CALayer layer];
        _maskLayer.backgroundColor = [UIColor blackColor].CGColor;
        _maskLayer.opacity = 0.7;
    }
    
    return _maskLayer;
}
- (void)dealloc {
    NSLog(@"LZCityPickerController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.maskLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.maskLayer];
    
    __weak typeof(self)ws = self;
    _cityPicker = [JKCityPickView showInView:self.view didSelectWithBlock:^(NSString *address, NSString *province, NSString *city, NSString *area) {
        
        if (ws.backBlock) {
            ws.backBlock(address, province, city, area);
        }
    } cancelBlock:^{
        
        [ws.view removeFromSuperview];
        [ws removeFromParentViewController];
    }];
    
    // picker的一些属性可以在这里配置
    //        _cityPicker.autoChange = YES;
//    _cityPicker.backgroundImage = [UIImage imageNamed:@"40fe711f9b754b596159f3a6.jpg"];
    //
//    _cityPicker.backgroundColor = [UIColor blackColor];
    _cityPicker.textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]};
    _cityPicker.titleAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]};
}

+ (instancetype)showPickerInViewController:(UIViewController *)vc selectBlock:(__actionBlock)block {
    
    JKCityPickViewController *picker = [[JKCityPickViewController alloc]init];
    
    picker.backBlock = block;
    [vc addChildViewController:picker];
    [vc.view addSubview:picker.view];
    return picker;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    __weak typeof(self)ws = self;
    [_cityPicker dismissWithBlock:^{
        
        [ws.view removeFromSuperview];
        [ws removeFromParentViewController];
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
