//
//  IMRCSettingViewController.m
//  RongCloudIMDemo
//
//  Created by Qin on 2020/8/12.
//  Copyright © 2020 qin. All rights reserved.
//

#import "IMRCSettingViewController.h"

@interface IMRCSettingViewController ()

@end

@implementation IMRCSettingViewController
- (void)setNavigationItems {
    
        UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
        barButton.adjustsImageWhenHighlighted = NO;
        [barButton addTarget:self action:@selector(leftItemDoAction) forControlEvents:UIControlEventTouchUpInside];
        [barButton setImage:[UIImage imageNamed:@
                             "navigator_btn_back"] forState:UIControlStateNormal];
        [barButton setFrame:CGRectMake(0, 0, 40, 40)];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:barButton];
        
        self.navigationItem.leftBarButtonItem = rightItem;
       
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setNavigationItems];
}
- (void)leftItemDoAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}



@end
