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
#ifdef DEBUG
#import <DoraemonKit/DoraemonManager.h>
#endif

@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIBarButtonItem appearance]setTintColor:[UIColor grayColor]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.tabbarVC = [[IMRootTabbarViewController alloc]init];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[IMLoginViewController new]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 初始化array
    self.friendsArray = [[NSMutableArray alloc]init];
    self.groupsArray = [[NSMutableArray alloc]init];
    //初始化融云相关
    [self initRongClould];
    // 注册通知
    [self registerNotification];
    
    [self configDoraemon];
    
    //重定向 log 到本地问题

    //在 info.plist 中打开 Application supports iTunes file sharing

        if (![[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"]) {

            [self redirectNSlogToDocumentFolder];

        }




      //设置Log级别，开发阶段打印详细log

      [RCIMClient sharedRCIMClient].logLevel = RC_Log_Level_Info;
    
    
    return YES;
}

- (void)redirectNSlogToDocumentFolder {

  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,

                                                       NSUserDomainMask, YES);

  NSString *documentDirectory = [paths objectAtIndex:0];



  NSDate *currentDate = [NSDate date];

  NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];

  [dateformatter setDateFormat:@"MMddHHmmss"];

  NSString *formattedDate = [dateformatter stringFromDate:currentDate];



  NSString *fileName = [NSString stringWithFormat:@"rc%@.log", formattedDate];

  NSString *logFilePath =

  [documentDirectory stringByAppendingPathComponent:fileName];
  freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+",stdout);
   freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+",stderr);
}

#define DORAEMON_APPID @""
- (void)configDoraemon {
    #ifdef DEBUG
    [[DoraemonManager shareInstance] installWithPid:DORAEMON_APPID];
    #endif
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
    
    AppDelegate * app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return app;
}

@end
