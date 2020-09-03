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


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showInfoWithStatus:@"聊天室1小时内无人聊天会自动销毁"];

    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"禁言" style:UIBarButtonItemStylePlain target:self action:@selector(quitRoom)];
    self.navigationItem.rightBarButtonItem = item;
    
    
    [self.chatSessionInputBarControl setInputBarType:RCChatSessionInputBarControlDefaultType style:RC_CHAT_INPUT_BAR_STYLE_SWITCH_CONTAINER_EXTENTION];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatus:) name:@"banned" object:nil];
    
}
- (void)quitRoom {
    
    RCSettingViewController *setting = [[RCSettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
     
}

- (void)changeStatus:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    if ([userInfo[@"targetId"] isEqualToString:self.targetId]) {
        dispatch_async(dispatch_get_main_queue(), ^{
               self.defaultInputType = RCChatSessionInputBarInputVoice;
                    self.chatSessionInputBarControl.backgroundColor = [UIColor redColor];
                    self.chatSessionInputBarControl.userInteractionEnabled = NO;
           });
    }
   
   
}



@end
