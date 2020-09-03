//
//  IMIssue.m
//  RongCloudIMDemo
//
//  Created by Qin on 2020/8/19.
//  Copyright © 2020 qin. All rights reserved.
//

#import "IMIssue.h"
#import <AVFoundation/AVFoundation.h>
#import "IMRCCustomMessage.h"
#import "IMLoginViewController.h"
@implementation IMIssue

+ (void)getConversationList {
    
   NSArray *conversationList = [[RCIMClient sharedRCIMClient] getConversationList:@[@(ConversationType_PRIVATE)]];
    
    NSLog(@"conversationList:%@",[conversationList modelToJSONString]);
}

+ (void)logout {
    [[RCIM sharedRCIM] logout];
}

+ (void)sendMessage {
    
    RCTextMessage *textMessage = [RCTextMessage messageWithContent:@"呵呵呵呵11"];
    RCMessage *message = [[RCMessage alloc]initWithType:1 targetId:@"1001" direction:MessageDirection_RECEIVE messageId:1 content:textMessage];
    
    [[RCIM sharedRCIM] sendMessage:message pushContent:nil pushData:nil successBlock:^(RCMessage *successMessage) {
        
    } errorBlock:^(RCErrorCode nErrorCode, RCMessage *errorMessage) {
        
    }];
}

+ (void)sendCuntomTextMessage {
     
      IMRCCustomMessage *textMessage = [IMRCCustomMessage messageWithContent:@"自定义文本消息"];
      RCMessage *message = [[RCMessage alloc]initWithType:1 targetId:@"1001" direction:1 messageId:1 content:textMessage];
      
      [[RCIM sharedRCIM] sendMessage:message pushContent:nil pushData:nil successBlock:^(RCMessage *successMessage) {
          NSLog(@"successMessage:%@",[successMessage modelToJSONString]);
      } errorBlock:^(RCErrorCode nErrorCode, RCMessage *errorMessage) {
          
      }];
}

+ (void)sendIMGMessage {
    RCImageMessage *imgMessage = [RCImageMessage messageWithImage:[UIImage imageNamed:@"小黄人.jpg"]];
    RCMessage *message = [[RCMessage alloc]initWithType:1 targetId:@"1002" direction:1 messageId:0 content:imgMessage];
    [[RCIM sharedRCIM] sendMediaMessage:message pushContent:nil pushData:nil
                               progress:^(int progress, RCMessage *progressMessage) {
        
    } successBlock:^(RCMessage *successMessage) {
        NSLog(@"successMessage:%@",[successMessage modelToJSONString]);
    } errorBlock:^(RCErrorCode nErrorCode, RCMessage *errorMessage) {
        NSLog(@"errorMessage:%@",[errorMessage modelToJSONString]);

    } cancel:^(RCMessage *cancelMessage) {
        
    }];
}

+(void)refreshUserInfoCache {
    
    
    RCUserInfo *userInfo = [[RCUserInfo alloc]initWithUserId:@"1002" name:@"社会人啊。。。" portrait:@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1990625098,3468619056&fm=11&gp=0.jpg"];
    
    [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:@"1002"];

}

+ (void)getCurrentUserId {
  [[RCIMClient sharedRCIMClient] getHistoryMessages:1 targetId:@"1002" oldestMessageId:@"105" count:100];
}
/// 获取一些视频信息
+(void)getAVInfo {
    // 视频 获取秒
    // 本地视频
    NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:@"test.mp4" ofType:nil]];
    AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:url options:nil];
    CMTime  time = [asset duration];
    int seconds =ceil(time.value/time.timescale);


    NSArray *array = asset.tracks;
    CGSize videoSize = CGSizeZero;

    for(AVAssetTrack  *track in array)
    {

        if([track.mediaType isEqualToString:AVMediaTypeVideo])
        {
              videoSize = track.naturalSize;
        }
    }

    NSLog(@"seconds:%d",seconds);
    NSLog(@"videoSize:%@",NSStringFromCGSize(videoSize));
}

+ (void)getHistoryMessages:(RCConversationType)conversationType targetId:(NSString *)targetId oldestMessageId:(long )oldestMessageId count:(int)count {
    
   NSArray *messages = [[RCIMClient sharedRCIMClient] getHistoryMessages:conversationType targetId:@"1001" oldestMessageId:oldestMessageId count:count];
    
  NSArray *latestMessages   =[[RCIMClient sharedRCIMClient] getLatestMessages:1 targetId:@"1001" count:100];
  NSLog(@"messages:%@",[messages modelToJSONString]);
    NSLog(@"latestMessages:%@",[latestMessages modelToJSONString]);
}

+ (void)disConneRCServer {
    [[RCIM sharedRCIM]logout];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [AppDelegate shareAppDelegate].window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[IMLoginViewController new]];
    });
}

@end
