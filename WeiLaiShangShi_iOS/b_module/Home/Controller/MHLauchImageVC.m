//
//  MHLauchImageVC.m
//  wgts
//
//  Created by AllenQin on 2018/11/23.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHLauchImageVC.h"

@interface MHLauchImageVC ()

@end

@implementation MHLauchImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView  *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageView.image = [self imageFromLaunchImage];
    [self.view addSubview:imageView];
    
    
    
}


-(UIImage *)imageFromLaunchImage{
    UIImage *imageP = [self launchImageWithType:@"Portrait"];
    if(imageP) return imageP;
    UIImage *imageL = [self launchImageWithType:@"Landscape"];
    if(imageL)  return imageL;
    return nil;
}

-(UIImage *)launchImageWithType:(NSString *)type{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = type;
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict){
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if([viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]){
            if([dict[@"UILaunchImageOrientation"] isEqualToString:@"Landscape"]){
                imageSize = CGSizeMake(imageSize.height, imageSize.width);
            }
            if(CGSizeEqualToSize(imageSize, viewSize)){
                launchImageName = dict[@"UILaunchImageName"];
                UIImage *image = [UIImage imageNamed:launchImageName];
                return image;
            }
        }
    }
    return nil;
}
@end
