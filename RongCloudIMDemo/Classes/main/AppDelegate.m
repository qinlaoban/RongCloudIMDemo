//
//  AppDelegate.m
//  RCSupport
//
//  Created by Qin on 2020/7/18.
//  Copyright (c) 2020年 Qin. All rights reserved.
//


#import "AppDelegate.h"
#import "AppDelegate+IM.h"
#import "IMLoginViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <IQKeyboardManager.h>
#import <AVFoundation/AVFoundation.h>
#import "IMRCCustomMessage.h"
@interface AppDelegate ()

@end


@implementation AppDelegate

   


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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIBarButtonItem appearance]setTintColor:[UIColor grayColor]];
   // NSLog(@"rongDocumentsDirectory；%@",[RCUtilities rongDocumentsDirectory]);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.tabbarVC = [[IMRootTabbarViewController alloc]init];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[IMLoginViewController new]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 初始化array
    self.friendsArray = [[NSMutableArray alloc]init];
    self.groupsArray = [[NSMutableArray alloc]init];
    //初始化融云相关
//    [self initRongClould];
    // 注册通知
    [self registerAPN];
    NSLog(@"machineModel:%@",[UIDevice currentDevice].machineModelName);
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = -30.0f;
   
    NSLog(@"NSHomeDirectory：%@",NSHomeDirectory());
    
    [[RCIM sharedRCIM] initWithAppKey:@"0vnjpoad0ixyz"];
       
       //  连接
       [RCIM sharedRCIM].connectionStatusDelegate = [IMDataManager shareManager];
       //  设置用户信息提供者为 [IMDataManager shareManager]
       [RCIM sharedRCIM].userInfoDataSource = [IMDataManager shareManager];
       //  设置群组信息提供者为 [IMDataManager shareManager]
       [RCIM sharedRCIM].groupInfoDataSource = [IMDataManager shareManager];
       //  是否在发送的所有消息中携带当前登录的用户信息，默认值为NO
       [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
       
       //  消息监听
       [RCIM sharedRCIM].sendMessageDelegate = [IMDataManager shareManager];
       
       //
       [RCIM sharedRCIM].receiveMessageDelegate = [IMDataManager shareManager];
       
       // 自定义消息类型
       [[RCIM sharedRCIM]registerMessageType:IMRCCustomMessage.class];
       
       // 开启已读回执功能的会话类型，默认为 单聊、群聊和讨论组
       [RCIM sharedRCIM].enabledReadReceiptConversationTypeList = @[ @(ConversationType_PRIVATE) ];
       
       [self maxPermissions];

    return YES;
}

- (long long)fileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        
    }
    return 0;
}
- (float)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil)
    {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

// 获取苹果推送权限成功。
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 设置 deviceToken。
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //
    NSInteger ToatalunreadMsgCount = (NSInteger)[[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CHATROOM)]];
    [UIApplication sharedApplication].applicationIconBadgeNumber = ToatalunreadMsgCount;
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - shareAppDelegate
+ (AppDelegate* )shareAppDelegate {
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}
- (void)registerAPN {

    if (@available(iOS 10.0, *)) { // iOS10 以上
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
        }];
    }
    
    
}
@end
