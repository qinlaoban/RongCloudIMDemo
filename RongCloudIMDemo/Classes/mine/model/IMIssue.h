//
//  IMIssue.h
//  RongCloudIMDemo
//
//  Created by Qin on 2020/8/19.
//  Copyright © 2020 qin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMIssue : NSObject

/// 获取本地会话列表
+ (void)getConversationList;
/// 退出登录
+ (void)logout;
/// 发送消息
+ (void)sendMessage;
/// 发送自定义文本消息
+ (void)sendCuntomTextMessage;
/// 发送图片消息
+ (void)sendIMGMessage;
/// 刷新用户信息
+(void)refreshUserInfoCache;
/// 刷新用户信息
+(void)getCurrentUserId;
/// 获取一些视频信息
+(void)getAVInfo;
/// 获取本地消息
+ (void)getHistoryMessages:(RCConversationType)conversationType
       targetId:(NSString *)targetId
oldestMessageId:(long)oldestMessageId
          count:(int)count;
/// 断开连接，退出登录
+ (void)disConneRCServer ;


@end

NS_ASSUME_NONNULL_END
