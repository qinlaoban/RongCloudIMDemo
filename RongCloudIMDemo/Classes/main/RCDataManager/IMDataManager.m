



//
//  IMDataManager.m
//  RCSupport
//
//  Created by Qin on 2020/7/22.
//  Copyright © 2020年 Qin. All rights reserved.
//

#import "IMDataManager.h"
#import "RCUserInfo+Addition.h"
#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface IMDataManager ()

@end

@implementation IMDataManager{
        NSMutableArray *dataSoure;
}


+ (IMDataManager *)shareManager{
    static IMDataManager* manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
        [RCIM sharedRCIM].userInfoDataSource = self;
    });
    return manager;
}



///  从服务器同步好友列表
- (void)syncFriendList:(void (^)(NSMutableArray* friends,BOOL isSuccess))completion
{
    dataSoure = [[NSMutableArray alloc]init];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"contacts" ofType:@"plist"];
    NSArray *contacts = [[NSArray alloc]initWithContentsOfFile:path];

    for (NSInteger i = 0; i<contacts.count; i++) {
        NSDictionary *userDict = contacts[i];
        RCUserInfo *aUserInfo = [RCUserInfo modelWithDictionary:userDict];
        [dataSoure addObject:aUserInfo];
    }
  
    
   [AppDelegate shareAppDelegate].friendsArray = dataSoure;
    completion(dataSoure,YES);

}

/// 从服务器同步群组列表
-(void)syncGroupList:(void (^)(NSMutableArray * groups))completion{
    if ([AppDelegate shareAppDelegate].groupsArray.count) {
        [[AppDelegate shareAppDelegate].groupsArray removeAllObjects];
    }
   
    NSString *path = [[NSBundle mainBundle]pathForResource:@"group" ofType:@"plist"];
    NSArray *groups = [[NSArray alloc]initWithContentsOfFile:path];
    
    for (NSInteger i = 0; i<groups.count; i++) {
        
        NSDictionary *groupDict = groups[i];
         RCGroup *aGroup = [[RCGroup alloc]initWithGroupId:groupDict[@"groupId"] groupName:groupDict[@"groupName"] portraitUri:groupDict[@"portraitUri"]];
        
        [[AppDelegate shareAppDelegate].groupsArray addObject:aGroup];

    }
    
   
            
    completion([AppDelegate shareAppDelegate].groupsArray);

}


#pragma mark - RCSupportGroupInfoDataSource

- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion {
    for (RCGroup *g in [AppDelegate shareAppDelegate].groupsArray) {
        completion(g);
    }
}





///准备发送消息的监听器
//- (RCMessageContent *)willSendIMMessage:(RCMessageContent *)messageContent {
//    return messageContent;
//}


/// 发送消息完成的监听器
//- (void)didSendIMMessage:(RCMessageContent *)messageContent status:(NSInteger)status {
//    NSLog(@"didSendIMMessage :%@",[messageContent modelToJSONString]);
//}


#pragma mark - RCIMConnectionStatusDelegate
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        [SVProgressHUD showErrorWithStatus:@"您已经被踢下线"];
        // 可能需要做退出程序等逻辑
        
    }
}
- (BOOL)onRCIMCustomLocalNotification:(RCMessage *)message withSenderName:(NSString *)senderName{
    return NO;
    // 创建一个通知内容
     UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
//     content.badge = @1;
     NSInteger unreadMsgCount = (NSInteger)[[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE)]];
    content.badge = @(unreadMsgCount);
     content.title = senderName;
    NSString *clssName = message.content.className;
    
    if ([clssName isEqualToString:@"RCTextMessage"]) {
        RCTextMessage *textMessage = (RCTextMessage *)message.content;
        content.subtitle = textMessage.content;
    }else {
        content.subtitle = @"其他消息";
    }
     
//     content.body = @"body";
//     content.sound = [UNNotificationSound defaultSound];
//     content.categoryIdentifier = @"category";
//     
     
     // 通知触发器
     UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:false];
     // 通知请求
     UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"noti" content:content trigger:trigger];
     //添加通知
     [UNUserNotificationCenter.currentNotificationCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
         
         NSLog(@"error:%@",error);
     }];
     
     
     // 添加通知的一些操作
     UNNotificationAction *openAction = [UNNotificationAction actionWithIdentifier:@"open" title:@"打开" options:UNNotificationActionOptionForeground];
     UNNotificationAction *closeAction = [UNNotificationAction actionWithIdentifier:@"close" title:@"关闭" options:UNNotificationActionOptionDestructive];
     UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"category" actions:@[openAction, closeAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
      
     NSSet *sets = [NSSet setWithObject:category];
     [UNUserNotificationCenter.currentNotificationCenter setNotificationCategories:sets];
    
    
    
}
/// 接收消息的回调方法
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
   // NSLog(@"message.content:%@",[message.content modelToJSONString]);
    // 伪需求，禁言，不能打字
    if (message.conversationType == ConversationType_CHATROOM) {
        RCTextMessage *textMessage = (RCTextMessage *)message.content;
        if ([textMessage.extra isEqualToString:@"banned"]) {
            NSDictionary *object = @{@"targetId":message.targetId};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"banned" object:object userInfo:object];
        }
        
    }
    
    
    
}
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    NSLog(@"getUserInfoWithUserId:%@",userId);
    for (RCUserInfo *user in [AppDelegate shareAppDelegate].friendsArray) {
        if ([user.userId isEqualToString:userId]) {
            completion(user);
        }
    }
}

#pragma mark - IMFUNC

///   根据userid 获取用户用户信息
- (RCUserInfo *)getUserInfoFromUserId:(NSString *)userId{
    for (NSInteger i = 0; i<[AppDelegate shareAppDelegate].friendsArray.count; i++) {
        RCUserInfo *aUser = [AppDelegate shareAppDelegate].friendsArray[i];
        if ([userId isEqualToString:aUser.userId]) {
//            NSLog(@"current ＝ %@",aUser.name);
            return aUser;
        }
    }
    return nil;
}

/// 登录融云服务器（connect，用token去连接）
- (void)loginRongCloudWithUserInfo:(RCUserInfo *)userInfo complete:(nullable void (^)(void))complete{
    

//     连接
    [[RCIM sharedRCIM]connectWithToken:userInfo.token dbOpened:^(RCDBErrorCode code) {

    } success:^(NSString *userId) {

        // 登录成功后设置userInfo
        [RCIM sharedRCIM].currentUserInfo = userInfo;
    
        //同步好友列表
        [self syncFriendList:^(NSMutableArray *friends, BOOL isSuccess) {


        }];
        // 同步群组
        [self syncGroupList:^(NSMutableArray *groups) {

        }];


        [[IMDataManager shareManager] refreshBadgeValue];
        complete();

    } error:^(RCConnectErrorCode errorCode) {

        NSLog(@"RCConnectErrorCode %zd",errorCode);
    }];

    
}

///  刷新tabbar的角标
-(void)refreshBadgeValue{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSInteger unreadMsgCount = (NSInteger)[[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE),@(ConversationType_GROUP),]];

        // 会话列表
        UINavigationController  *chatNav = [AppDelegate shareAppDelegate].tabbarVC.viewControllers[0];
        
        if (unreadMsgCount == 0) {
            chatNav.tabBarItem.badgeValue = nil;
        }else{
            chatNav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%li",(long)unreadMsgCount];
        }
    });
}

@end

