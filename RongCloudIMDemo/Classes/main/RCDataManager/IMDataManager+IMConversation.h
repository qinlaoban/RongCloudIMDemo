//
//  IMDataManager+IMConversation.h
//  RongCloudIMDemo
//
//  Created by Qin on 2020/8/28.
//  Copyright © 2020 qin. All rights reserved.
//

#import "IMDataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMDataManager (IMConversation)
/// 获取最后消息
+ (void)getLastMessage:(NSString *)messageId;

@end

NS_ASSUME_NONNULL_END
