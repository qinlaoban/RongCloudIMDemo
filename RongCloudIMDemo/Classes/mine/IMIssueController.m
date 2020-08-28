//
//  IMIssueController.m
//  RongCloudIMDemo
//
//  Created by Qin on 2020/8/4.
//  Copyright © 2020 qin. All rights reserved.
//

#import "IMIssueController.h"
#import "IMLoginViewController.h"
#import "IMIssue.h"
@interface IMIssueController ()
@property(nonatomic,strong)NSArray *datasourse;
@property(nonatomic,strong)NSArray *sections;

@end

@implementation IMIssueController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    _datasourse = @[
        
                    @"获取本地会话列表",
                    @"发送消息",
                    @"刷新用户信息",
                    @"获取用户ID",
                    @"发送图片",
                    @"获取视频信息IM",
                    @"获取本地消息",
                    @"发送自定义文本消息",
                  
    ];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"issue"];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasourse.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"issue" forIndexPath:indexPath];
    
    cell.textLabel.text = _datasourse[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            [IMIssue getConversationList];
            break;
        case 1:
            [IMIssue sendMessage];
            break;
            case 2:
            [IMIssue refreshUserInfoCache];
            break;
            case 3:
            [IMIssue getCurrentUserId];
            break;
            case 4:
            [IMIssue sendIMGMessage];
          case 5:
                [IMIssue getAVInfo];
            case 6:
            
            [IMIssue getHistoryMessages:1 targetId:@"110" oldestMessageId:1 count:10];
            break;
            case 7:
            
            [IMIssue sendCuntomTextMessage];
            break;
        default:
            break;
    }
   
}
@end
