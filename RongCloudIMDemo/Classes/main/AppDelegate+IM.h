//
//  AppDelegate+IM.h
//  RongCloudIMDemo
//
//  Created by Qin on 2020/7/28.
//  Copyright © 2020 qin. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (IM)

-(void)initRongClould;
/// 通知授权
- (void)registerNotification;

@end

NS_ASSUME_NONNULL_END
