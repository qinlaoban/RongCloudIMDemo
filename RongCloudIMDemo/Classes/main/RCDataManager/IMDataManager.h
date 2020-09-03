//
//  IMDataManager.h
//  RCSupport
//
//  Created by Qin on 2020/7/22.
//  Copyright © 2020年 Qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

/**
 *  IMDataManager类为核心管理融云一切逻辑的类，包括充当用户信息提供者的代理，
 *  同步好友列表，同步群组列表，登录融云服务器，刷新角标badgeValue等等
 *  IMDataManager类为自己写的类，和融云SDK无关（不要以为是SDK内部的类）
 */
@interface IMDataManager : NSObject<RCIMUserInfoDataSource,
                                    RCIMGroupInfoDataSource,
                                    RCIMSendMessageDelegate,
                                    RCIMReceiveMessageDelegate,
                                    RCIMConnectionStatusDelegate>

/// IMDataManager单例对象
+(IMDataManager *) shareManager;


#pragma mark - IMFUNC

/// 登录融云服务器（connect，用token去连接）
-(void)loginRongCloudWithUserInfo:(RCUserInfo *)userInfo complete:(nullable void (^)(void))complete;

///  userId 根据userid 获取用户用户信息
- (RCUserInfo *)getUserInfoFromUserId:(NSString *)userId;

///  刷新tabbar的角标
-(void) refreshBadgeValue;


@end
