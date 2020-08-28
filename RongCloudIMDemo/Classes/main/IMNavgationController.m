//
//  WSNavgationController.m
//  RongCloudIMDemo
//
//  Created by Qin on 2020/5/18.
//  Copyright © 2020 qin. All rights reserved.
//

#import "IMNavgationController.h"

@interface IMNavgationController ()<UIGestureRecognizerDelegate>

@end

@implementation IMNavgationController

+ (void)initialize {
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithHexString:@"0x0099ff"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
}

- (UIButton *)backBarButtonItem {
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navigator_btn_back"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 50, 44);
    // 图片往左偏移
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    return backButton;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self backBarButtonItem]];
        
    }
    [super pushViewController:viewController animated:animated];
    
}
- (void)goBack {
    [self popViewControllerAnimated:YES];
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
}


@end
