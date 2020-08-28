



//
//  IMConversationViewController.m
//  RCSupport
//
//  Created by Qin on 2020/7/22.
//  Copyright © 2020年 Qin. All rights reserved.
//

#import "IMConversationViewController.h"
#import "IMRCCustomMessage.h"
#import "RCCustomMessageCell.h"
#import "IMRCSettingViewController.h"
#import <RongSight/RongSight.h>
#import "TZImagePickerController.h"
// 主线程宏
#define rcd_dispatch_main_async_safe(block) if ([NSThread isMainThread]) { block(); } else { dispatch_async(dispatch_get_main_queue(), block);}
@interface IMConversationViewController ()<RCMessageCellDelegate,RCSightViewControllerDelegate,RCIMReceiveMessageDelegate,TZImagePickerControllerDelegate>

@end

@implementation IMConversationViewController

- (void)setNavigationItems {
    rcd_dispatch_main_async_safe(^{
        
        
        UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
        barButton.adjustsImageWhenHighlighted = NO;
        [barButton addTarget:self action:@selector(rightItemDoAction) forControlEvents:UIControlEventTouchUpInside];
        [barButton setImage:[UIImage imageNamed:@
                             "icon_group"] forState:UIControlStateNormal];
        [barButton setFrame:CGRectMake(0, 0, 40, 40)];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:barButton];
        
        self.navigationItem.rightBarButtonItem = rightItem;
        
        
    });
    
}

- (void)rightItemDoAction {}

- (void)addNotificationCenter {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(messageCellUpdateSendingStatusEvent:)
                                                 name:KNotificationMessageBaseCellUpdateSendingStatus
                                               object:nil];
    
}
//30001 30003
// 20604
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    
    [self setNavigationItems];
    
    [self configpPluginBoardView];
    
    [self registerCustomCell];
    
    self.chatSessionInputBarControl.recordButton.
  //  self.chatSessionInputBarControl.userInteractionEnabled = NO;
    
}
#pragma mark - pluginBoardView
///注册自定义视频消息Cell
- (void)registerCustomCell {
    
    [self registerClass:[RCCustomMessageCell class] forMessageClass:[IMRCCustomMessage class]];
}

#pragma mark - pluginBoardView

/// 设置插件面板
- (void)configpPluginBoardView {
    
    //在功能面板上插入一个Item，用来发送视频，并标记tag，方便区分
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"voice"] title:@"自定语音" atIndex:0 tag:200];
    
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"video"] title:@"发送图片" atIndex:1 tag:201];
    
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"video"] title:@"发送文件" atIndex:2 tag:202];
    
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"video"] title:@"自定义消息" atIndex:3 tag:203];
    
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"video"] title:@"发送小灰条" atIndex:4 tag:204];
    
      [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"video"] title:@"发送短视频" atIndex:5 tag:205];
    
    UIImage *imageFile = [RCKitUtility imageNamed:@"actionbar_file_icon" ofBundle:@"RongCloud.bundle"];
    
    RCPluginBoardView *pluginBoardView = self.chatSessionInputBarControl.pluginBoardView;
    
    [pluginBoardView insertItemWithImage:imageFile
     
                                   title:NSLocalizedStringFromTable(@"File", @"RongCloudKit", nil)
     
                                 atIndex:4
     
                                     tag:PLUGIN_BOARD_ITEM_FILE_TAG];

}

/// 功能面板点击事件的方法，通过tag区分点击到的哪个item
- (void)pluginBoardView:(RCPluginBoardView *)pluginBoardView clickedItemWithTag:(NSInteger)tag{
    
    

    
    if (tag == 200) {
     
        // kit 源码限制了
        NSString *path = [[NSBundle mainBundle] pathForResource:@"遇见" ofType:@"wav"];
        RCHQVoiceMessage *voiceMessage = [RCHQVoiceMessage messageWithPath:path duration:111];
        [self sendMediaMessage:voiceMessage pushContent:@"语音消息" appUpload:NO];
        
    } else if (tag == 201) {
        RCImageMessage *imgMsg = [RCImageMessage messageWithImage:[UIImage imageNamed:@"小黄人.jpg"]];
        [self sendMediaMessage:imgMsg pushContent:nil appUpload:NO];
    }else if (tag == 202) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"IM" ofType:@"txt"];
        RCFileMessage *file = [RCFileMessage messageWithFile:path];
        [self sendMediaMessage:file pushContent:@"文件" appUpload:NO];
        
    }else  if (tag == 203) {
        
        IMRCCustomMessage *meesage = [IMRCCustomMessage messageWithContent:@"123"];
        [self sendMessage:meesage pushContent:nil];
        
    }else  if (tag == 204) {
        
        RCInformationNotificationMessage *info = [RCInformationNotificationMessage notificationWithMessage:@"haha" extra:nil   ];
        [self sendMessage:info pushContent:nil];
 
    }else  if (tag == 205) {
        
        
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"fireworks" ofType:@".MP4"];

        // 图片为1m
        UIImage *thumbnail = [UIImage imageNamed:@"小黄人.jpg"];
        
        RCSightMessage *sightmessage = [RCSightMessage messageWithLocalPath:path thumbnail:thumbnail duration:15];
        
        [[RCIMClient sharedRCIMClient] sendMediaMessage:self.conversationType targetId:self.targetId content:sightmessage pushContent:nil pushData:nil progress:^(int progress, long messageId) {

            } success:^(long messageId) {

                RCMessage *message = [[RCIMClient sharedRCIMClient] getMessage:messageId];
                      NSLog(@"message.content:%@",[message.content modelToJSONString]);

            } error:^(RCErrorCode errorCode, long messageId) {
              RCMessage *message = [[RCIMClient sharedRCIMClient] getMessage:messageId];
                NSLog(@"message.errorCode:%@",[message.content modelToJSONString]);
            } cancel:^(long messageId) {

            }];
        
    }else if (tag == 10010) { // 相机å
        
        RCSightViewController *svc = [[RCSightViewController alloc] initWithCaptureMode:RCSightViewControllerCameraCaptureModeSight];
        svc.delegate = self;
        svc.modalPresentationStyle = UIModalPresentationFullScreen; // ios13 不是全屏
        [self presentViewController:svc animated:YES completion:nil];
    } else{
        // 需要调super方法，不然其他方法不可调用
        if (@available(iOS 13.0, *)) {
            self.modalPresentationStyle = UIModalPresentationAutomatic;
        }
        [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
        
    }
}

/// 当用户选择发送拍摄的静态图片时，调用该方法
- (void)sightViewController:(RCSightViewController *)sightVC didFinishCapturingStillImage:(UIImage *)image {
    RCImageMessage *imageMessage = [RCImageMessage messageWithImage:image];
    imageMessage.full = YES;
    imageMessage.originalImage = image;
    
    
    [self sendMediaMessage:imageMessage pushContent:nil appUpload:NO];
    
    [sightVC dismissViewControllerAnimated:YES completion:nil];
    
}

///  当用户选择发送录制的小视频时，调用该方法
- (void)sightViewController:(RCSightViewController *)sightVC
         didWriteSightAtURL:(NSURL *)url
                  thumbnail:(UIImage *)thumnail
                   duration:(NSUInteger)duration {
    
    
    [sightVC dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - RCConversation func

/*!
 即将在会话页面插入消息的回调

 @param message 消息实体
 @return        修改后的消息实体

 @discussion 此回调在消息准备插入数据源的时候会回调，您可以在此回调中对消息进行过滤和修改操作。
 如果此回调的返回值不为nil，SDK会将返回消息实体对应的消息Cell数据模型插入数据源，并在会话页面中显示。
 */
- (RCMessage *)willAppendAndDisplayMessage:(RCMessage *)message {
    if ([message.targetId isEqualToString:@"1002"]) {
        message.messageConfig.disableNotification = YES;
    }
    return message;
}
- (RCMessageContent *)willSendMessage:(RCMessageContent *)messageContent {
    
    return messageContent;
}

- (void)didSendMessage:(NSInteger)status content:(RCMessageContent *)messageContent {
    NSLog(@"className：%@",messageContent.className);
    
}

- (void)didLongTouchMessageCell:(RCMessageModel *)model inView:(UIView *)view {
    NSLog(@"didLongTouchMessageCell");
    [super didLongTouchMessageCell:model inView:view];
}

- (void)didTapMessageCell:(RCMessageModel *)model {
    
    [super didTapMessageCell:model];
    
}
/// 撤回消息
- (void)onRCIMMessageRecalled:(long)messageId {
    NSLog(@"onRCIMMessageRecalled:%ld",messageId);
}




///  打开大图。开发者可以重写，自己下载并且展示图片。默认使用内置controller
- (void)presentImagePreviewController:(RCMessageModel *)model {
    [super presentImagePreviewController:model];
}


/// 修改文本字体颜色：
- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell isKindOfClass:[RCTextMessageCell class]]) {
        
        RCTextMessageCell *newCell = (RCTextMessageCell *)cell;
        NSString *text = newCell.textLabel.text;
        NSRange range = [text rangeOfString:text];
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:newCell.textLabel.text];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        newCell.textLabel.attributedText = attributeStr;
    } else {
        [super willDisplayMessageCell:cell atIndexPath:indexPath];
    }
}


// 选择视频的回调
-(void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingVideo:(UIImage *)coverImage
                sourceAssets:(PHAsset *)asset{
    NSLog(@"sourceAssets:%@",asset);
}




@end

