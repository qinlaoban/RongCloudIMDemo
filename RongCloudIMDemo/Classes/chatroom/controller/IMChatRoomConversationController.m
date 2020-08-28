//
//  IMChatRoomConversationController.m
//  RongCloudIMDemo
//
//  Created by Qin on 2020/7/30.
//  Copyright © 2020 qin. All rights reserved.
//

#import "IMChatRoomConversationController.h"

@interface IMChatRoomConversationController ()

@end

@implementation IMChatRoomConversationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"tuichu" style:UIBarButtonItemStylePlain target:self action:@selector(quitRoom)];
    self.navigationItem.rightBarButtonItem = item;
    
    
}
- (void)quitRoom {
    
    
    RCSettingViewController *setting = [[RCSettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
     
}




@end
