
//
//  IMGroupListViewController.m
//  RCSupport
//
//  Created by Qin on 2020/07/21.
//  Copyright © 2002年 Qin. All rights reserved.
//

#import "IMGroupListViewController.h"

#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "IMConversationViewController.h"
@interface IMGroupListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *groupsArray;
}


@end

@implementation IMGroupListViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        
        groupsArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    groupsArray = [AppDelegate shareAppDelegate].groupsArray;

    [self.tableView registerNib:[UINib nibWithNibName:@"ContactCell" bundle:nil] forCellReuseIdentifier:@"ContactCell"];
    self.tableView.tableFooterView = [UIView new];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return groupsArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 98;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactCell  *cell = (ContactCell *)[tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    RCGroup *aGroupInfo = groupsArray[indexPath.row];
    [cell.portraitImageView sd_setImageWithURL:[NSURL URLWithString:aGroupInfo.portraitUri] placeholderImage:[UIImage imageNamed:@"DefaultHeader"]];
    cell.userNameLabel.text = aGroupInfo.groupName;
    cell.QQLabel.text = [NSString stringWithFormat:@"ID= %@",aGroupInfo.groupId];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RCGroup *aGroupInfo = groupsArray[indexPath.row];
    IMConversationViewController *_conversationVC = [[IMConversationViewController alloc]init];
    _conversationVC.conversationType = ConversationType_GROUP;
    _conversationVC.targetId = aGroupInfo.groupId;
    _conversationVC.title = [NSString stringWithFormat:@"%@",aGroupInfo.groupName];
    [self.navigationController pushViewController:_conversationVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
