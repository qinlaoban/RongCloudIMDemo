//
//  AppDelegate+IM.m
//  RongCloudIMDemo
//
//  Created by Qin on 2020/7/28.
//  Copyright © 2020 qin. All rights reserved.
//

#import "AppDelegate+IM.h"
#import <UserNotifications/UserNotifications.h>
#import "IMRCCustomMessage.h"

@interface AppDelegate()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate (IM)

#define IMAPPKEY @"0vnjpoad0ixyz"

- (void)initRongClould {
//    [RCIMClient sharedRCIMClient].logLevel = RC_Log_Level_Warn;
    
    NSLog(@"getVersion:%@",[RCIMClient sharedRCIMClient].getSDKVersion);
    
    [[RCIM sharedRCIM] initWithAppKey:@"0vnjpoad0ixyz"];
    
    
    
    //  连接
    [RCIM sharedRCIM].connectionStatusDelegate = [IMDataManager shareManager];
    //  设置用户信息提供者为 [IMDataManager shareManager]
    [RCIM sharedRCIM].userInfoDataSource = [IMDataManager shareManager];
    //  设置群组信息提供者为 [IMDataManager shareManager]
    [RCIM sharedRCIM].groupInfoDataSource = [IMDataManager shareManager];
    //  是否在发送的所有消息中携带当前登录的用户信息，默认值为NO
//    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    
    //  消息监听
    [RCIM sharedRCIM].sendMessageDelegate = [IMDataManager shareManager];
    
    //
    [RCIM sharedRCIM].receiveMessageDelegate = [IMDataManager shareManager];
    
    // 自定义消息类型
    [[RCIM sharedRCIM]registerMessageType:IMRCCustomMessage.class];
    
    // 开启已读回执功能的会话类型，默认为 单聊、群聊和讨论组
    [RCIM sharedRCIM].enabledReadReceiptConversationTypeList = @[ @(ConversationType_PRIVATE) ];
    
    [self maxPermissions];
}

/// 设置各种视频，音频，撤回时间
- (void)maxPermissions {
    [RCIM sharedRCIM].maxVoiceDuration = 10;
    //    [RCIM sharedRCIM].sightRecordMaxDuration = 10;
    [RCIM sharedRCIM].maxRecallDuration = 120;
    [[RCIM sharedRCIM] setGlobalNavigationBarTintColor:[UIColor grayColor]];//  SDK中全局的导航按钮字体颜色
    [RCIM sharedRCIM].isMediaSelectorContainVideo = YES;  // 选择媒体资源时，是否包含视频文件，默认值是NO
    //    是否开启消息撤回功能
    [RCIM sharedRCIM].enableMessageRecall = YES;
    [RCIM sharedRCIM].enableSendCombineMessage = YES;

}
- (void)registerNotification {
    UNAuthorizationOptions options = UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge;
    UNUserNotificationCenter.currentNotificationCenter.delegate = self;
    [UNUserNotificationCenter.currentNotificationCenter requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // 允许授权
            NSLog(@"允许授权");
        } else {
            // 不允许授权
            NSLog(@"不允许授权");
        }
    }];
    
    
    // 获取用户对通知的设置
    // 通过settings.authorizationStatus 来处理用户没有打开通知授权的情况
    [UNUserNotificationCenter.currentNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        NSLog(@"%@",settings);
    }];
}
// 在前台时 收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge);
    
    NSLog(@"notification:%@",[notification modelToJSONString]);
}




// 点击通知，从后台进入前台
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSString *identifier =  response.actionIdentifier;
    
    if ([identifier isEqualToString:@"open"]) {
        NSLog(@"打开操作");
    } else if ([identifier isEqualToString:@"close"]) {
        NSLog(@"关闭操作");
    }
    completionHandler();
}



@end
