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
#import "IMTestViewController.h"
#import "RCUserInfo+Addition.h"
#import "IMSpecialCell.h"
@interface IMConversationListViewController ()



@end

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
    RCUserInfo *user = [RCIM sharedRCIM].currentUserInfo;
    self.title = [NSString stringWithFormat:@"%@的会话",user.name];
    
    [self configIMStatus];
    
    [self.conversationListTableView registerClass:[IMSpecialCell class] forCellReuseIdentifier:@"special"];
    
}


- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath{
    
    //点击cell，拿到cell对应的model，然后从model中拿到对应的RCUserInfo，然后赋值会话属性，进入会话
    IMConversationViewController *_conversationVC = [[IMConversationViewController alloc]init];
    // 获取userinfo
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

//- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource {
//    NSLog(@"dataSource：%@",dataSource);
//
//    RCConversationModel *model = dataSource[0];
//    RCTextMessage *c = [RCTextMessage messageWithContent:@"huhu"];
//    model.lastestMessage = c;
//
//}

/// 自定cell

//-(NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource{
//    for (RCConversationModel *model in dataSource) {
//        for (RCUserInfo *user in [AppDelegate shareAppDelegate].friendsArray) {
//            NSLog(@"user type；%@",user.type);
//            if ([user.type isEqualToString:@"1"]) { // 1 为公务人员
//                model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
//            }
//        }
//    }
//    return dataSource;
//}
//// 自定义 cell
//-(RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//      RCConversationModel *model = self.conversationListDataSource[indexPath.row];
//     RCUserInfo *aUser = [AppDelegate shareAppDelegate].friendsArray[indexPath.row];
//    if (model.conversationModelType == RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION && [aUser.type isEqualToString:@"1"]) {
//
//        IMSpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"special"];
//        if (cell == nil) {
//            cell = [[IMSpecialCell alloc]initWithFrame:CGRectMake(0, 0, 400, 90)];
//        }
//
//        [cell setModel:model];
//
//        return cell;
//    }
//
//
//    return  [super rcConversationListTableView:tableView  cellForRowAtIndexPath:indexPath];
//}
//// 高度
//-(CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//     RCConversationModel *model = self.conversationListDataSource[indexPath.row];
//    if (model.conversationModelType == RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION) {
//
//        return 90;
//    }
//    return 44;
//}




@end
