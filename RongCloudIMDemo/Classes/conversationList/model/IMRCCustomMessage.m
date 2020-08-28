//
//  WMVideoMessage.m
//  RCSupport
//
//  Created by Qin on 2020/7/20.
//  Copyright © 2002年 Qin. All rights reserved.
//

#import "IMRCCustomMessage.h"

@implementation IMRCCustomMessage

+(instancetype)messageWithContent:(NSString *)content {
    
    
    IMRCCustomMessage *msg = [[IMRCCustomMessage alloc] init];
    if (msg) {
        msg.content = content;
    }
    
    return msg;
}

+(RCMessagePersistent)persistentFlag {
    return (MessagePersistent_ISPERSISTED | MessagePersistent_ISCOUNTED);
}

#pragma mark – NSCoding protocol methods
#define KEY_TXTMSG_CONTENT @"content"
#define KEY_TXTMSG_EXTRA @"extra"

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.content = [aDecoder decodeObjectForKey:KEY_TXTMSG_CONTENT];
        self.extra = [aDecoder decodeObjectForKey:KEY_TXTMSG_EXTRA]; }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.content forKey:KEY_TXTMSG_CONTENT];
    [aCoder encodeObject:self.extra forKey:KEY_TXTMSG_EXTRA];
    
}

#pragma mark – RCMessageCoding delegate methods

-(NSData *)encode {
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setValue:self.content forKey:@"content"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dataDict options:kNilOptions error:nil];
    return data;
}

-(void)decodeWithData:(NSData *)data {
    if (data) {
        __autoreleasing NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (dict) {
            self.content = dict[@"content"];
        }
    }
}

- (NSString *)conversationDigest
{
    RCUserInfo *user = [RCIM sharedRCIM].currentUserInfo;

    return [NSString stringWithFormat:@"%@ 发的自定义消息",user.userId];
    
}
+(NSString *)getObjectName {
    return RCLocalMessageTypeIdentifier;
}
#if ! __has_feature(objc_arc)
-(void)dealloc
{
    [super dealloc];
}
#endif//__has_feature(objc_arc)
@end

