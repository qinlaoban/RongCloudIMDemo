//
//  WMVideoMessage.h
//  RCSupport
//
//  Created by Qin on 2020/7/20.
//  Copyright © 2002年 Qin. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

#define RCLocalMessageTypeIdentifier @"IM:invitation"
@interface IMRCCustomMessage : RCMessageContent<NSCoding,RCMessageContentView>

@property(nonatomic,strong)NSString *content;
// 扩展字段，不作用于ui
@property(nonatomic, strong) NSString* extra;
+(instancetype)messageWithContent:(NSString *)content;

@end
