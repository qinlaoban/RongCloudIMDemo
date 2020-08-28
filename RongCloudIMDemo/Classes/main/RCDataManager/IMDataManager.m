



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




/*!
 准备发送消息的监听器

 */
- (RCMessageContent *)willSendIMMessage:(RCMessageContent *)messageContent {
    return messageContent;
}

///*!
// 发送消息完成的监听器
// */
//- (void)didSendIMMessage:(RCMessageContent *)messageContent status:(NSInteger)status {
//    
//    NSLog(@"didSendIMMessage :%@",[messageContent modelToJSONString]);
//}

/*!
 接收消息的回调方法
 */
//- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
////
//    RCTextMessage *text =(RCTextMessage *) message.content;
//    text.content = @"哈哈哈";
//}



#pragma mark - RCIMConnectionStatusDelegate
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        [SVProgressHUD showErrorWithStatus:@"您已经被踢下线"];
        // 可能需要做退出程序等逻辑
        
    }
}
- (BOOL)onRCIMCustomLocalNotification:(RCMessage *)message withSenderName:(NSString *)senderName{
    
    NSLog(@"onRCIMCustomLocalNotification:%@",[message modelToJSONString]);
    return NO;
}

- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    NSLog(@"message.content:%@",[message.content modelToJSONString]);
}
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
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
            NSLog(@"current ＝ %@",aUser.name);
            return aUser;
        }
    }
    return nil;
}

/// 登录融云服务器（connect，用token去连接）
- (void)loginRongCloudWithUserInfo:(RCUserInfo *)userInfo complete:(nullable void (^)(void))complete{
    
//    [[RCIM sharedRCIM] connectWithToken:userInfo.token dbOpened:^(RCDBErrorCode code) {
//
//    } success:^(NSString *userId) {
//                    // 登录成功后设置userInfo
//                    [RCIM sharedRCIM].currentUserInfo = userInfo;
//
//                    //同步好友列表
//                    [self syncFriendList:^(NSMutableArray *friends, BOOL isSuccess) {
//
//
//                    }];
//                    // 同步群组
//                    [self syncGroupList:^(NSMutableArray *groups) {
//
//                    }];
//
//
//                    [[IMDataManager shareManager] refreshBadgeValue];
//                    complete();
//
//
//    } error:^(RCConnectErrorCode status) {
//
//    } tokenIncorrect:^{
//
//    }];
    
    
//     连接
    [[RCIM sharedRCIM]connectWithToken:userInfo.token dbOpened:^(RCDBErrorCode code) {

    } success:^(NSString *userId) {

        // 登录成功后设置userInfo
        [RCIM sharedRCIM].currentUserInfo = userInfo;
        self.currentUserInfoID = userInfo.userId;

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
        
        NSInteger unreadMsgCount = (NSInteger)[[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CHATROOM)]];

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

