//
//  JRBaseTabBarController.m
//  JingRuiOnlineSchool
//
//  Created by maqianli on 2018/9/13.
//  Copyright © 2018年 onesmart. All rights reserved.
//

#import "JRBaseTabBarController.h"

@interface JRBaseTabBarController ()

@end

@implementation JRBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initControllers];
}

//MARK: 初始化相关
-(void)initControllers{
    
    MQLRootViewController *vc0 = [[MQLRootViewController alloc]initWithNibName:@"MQLRootViewController" bundle:nil];
    MQLNavigationController *rootnav0 = [[MQLNavigationController alloc]initWithRootViewController:vc0];
    NSString *lessonTitle0 = @"银行";
    UIImage *image0 = [UIImage imageNamed:@"private_icon_lovemoney"];
    rootnav0.tabBarItem = [[UITabBarItem alloc]initWithTitle:lessonTitle0 image:image0 selectedImage:nil];
    
    MQLKuaiDiShangJiaViewController *vc1 = [[MQLKuaiDiShangJiaViewController alloc]initWithNibName:@"MQLKuaiDiShangJiaViewController" bundle:nil];
    MQLNavigationController *rootnav1 = [[MQLNavigationController alloc]initWithRootViewController:vc1];
    NSString *lessonTitle1 = @"快递";
    UIImage *image1 = [UIImage imageNamed:@"private_icon_cart"];
    rootnav1.tabBarItem = [[UITabBarItem alloc]initWithTitle:lessonTitle1 image:image1 selectedImage:nil];
    
    self.viewControllers = @[rootnav0, rootnav1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: 屏幕方向相关
- (BOOL)shouldAutorotate{
    if (self.selectedViewController) {
        return [self.selectedViewController shouldAutorotate];
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if (self.selectedViewController) {
        return [self.selectedViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    if (self.selectedViewController) {
        return [self.selectedViewController preferredInterfaceOrientationForPresentation];
    }
    return UIInterfaceOrientationPortrait;
}

//MARK: 状态栏相关
- (BOOL)prefersStatusBarHidden{
    if (self.selectedViewController) {
        return [self.selectedViewController prefersStatusBarHidden];
    }
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    if (self.selectedViewController) {
        return [self.selectedViewController preferredStatusBarStyle];
    }
    return UIStatusBarStyleDefault;
}






@end
