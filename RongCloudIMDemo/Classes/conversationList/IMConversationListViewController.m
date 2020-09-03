//
//  IMCustomConversationListController.m
//  RongCloudIMDemo
//
//  Created by Qin on 2020/7/27.
//  Copyright © 2020 qin. All rights reserved.
//

#import "IMConversationListViewController.h"
#import "IMConversationViewController.h"
#import "IMDataManager.h"
#import "RCUserInfo+Addition.h"
#import "IMSpecialCell.h"


@implementation IMConversationListViewController

- (void)configIMStatus {

    self.showConnectingStatusOnNavigatorBar = YES;
    // 设置头像形状
    [self setConversationAvatarStyle:RC_USER_AVATAR_RECTANGLE];

}
/// 初始化
- (instancetype)init {
    if (self = [super init]) {
        // 头像
        [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
        // 会话类型，默认值显示 个人 ,群，客服，系统

        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                            @(ConversationType_GROUP),
                                            @(ConversationType_CUSTOMERSERVICE),
                                            @(ConversationType_SYSTEM),
        ]];

        // 聚合会话类型
//        [self setDisplayConversationTypeArray:@[@(ConversationType_CUSTOMERSERVICE),
//                                                ]];

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[IMDataManager shareManager] refreshBadgeValue];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showConversationListWhileLogOut = NO;
    RCUserInfo *user = [RCIM sharedRCIM].currentUserInfo;
    self.title = [NSString stringWithFormat:@"%@的会话",user.name];
    
    [self configIMStatus];
    
    [self.conversationListTableView registerClass:[IMSpecialCell class] forCellReuseIdentifier:@"special"];
    
}


/// 点击cell，拿到cell对应的model，然后从model中拿到对应的RCUserInfo，然后赋值会话属性，进入会话
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath{

    IMConversationViewController *_conversationVC = [[IMConversationViewController alloc]init];
    RCUserInfo *aUserInfo = [[IMDataManager shareManager] getUserInfoFromUserId:model.targetId];
    _conversationVC.conversationType = model.conversationType;
   _conversationVC.targetId = model.targetId;
    _conversationVC.title =aUserInfo.name;
    
    [self.navigationController pushViewController:_conversationVC animated:YES];
   
}

/// 删除cell
- (void)didDeleteConversationCell:(RCConversationModel *)model {
    [[IMDataManager shareManager] refreshBadgeValue];

}

///  在会话列表中，收到新消息的回调
- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [[IMDataManager shareManager] refreshBadgeValue];
    [super didReceiveMessageNotification:notification];
    
}









@end
