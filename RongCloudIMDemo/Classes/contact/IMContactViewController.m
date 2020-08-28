//
//  IMContactViewController.m
//  RCSupport
//
//  Created by Qin on 2020/7/15.
//  Copyright © 2002年 Qin. All rights reserved.
//

#import "IMContactViewController.h"
#import "AppDelegate.h"
#import "ContactCell.h"
#import "UIImageView+WebCache.h"
#import "RCUserInfo+Addition.h"
#import "IMConversationViewController.h"
#import "PersonCenterViewController.h"
#import "IMGroupListViewController.h"
@interface IMContactViewController ()<UITableViewDataSource,UITableViewDelegate>
  

@property(nonatomic,strong)NSArray *dataSourse;
@end

@implementation IMContactViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self.tableView registerNib:[UINib nibWithNibName:@"ContactCell" bundle:nil] forCellReuseIdentifier:@"ContactCell"];
    self.tableView.tableFooterView = [UIView new];
    
    _dataSourse = @[
        @[@"我的群组",
          @"我的聊天室",
        ],
        // 好友
        [AppDelegate shareAppDelegate].friendsArray
    ];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSourse.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return [AppDelegate shareAppDelegate].friendsArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }
    return 98;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NSArray * group = _dataSourse[0];
        UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"group"];
        cell.textLabel.text = group[indexPath.row];
        return cell;
    }
  
   
    ContactCell  *cell = (ContactCell *)[tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    RCUserInfo *aUserInfo = [AppDelegate shareAppDelegate].friendsArray[indexPath.row];
    [cell.portraitImageView sd_setImageWithURL:[NSURL URLWithString:aUserInfo.portraitUri] placeholderImage:[UIImage imageNamed:@"DefaultHeader"]];
    cell.userNameLabel.text = aUserInfo.name;
    cell.QQLabel.text = aUserInfo.QQ;
    cell.sexLabel.text = aUserInfo.sex;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
    
        if (indexPath.row == 0 ) {
            IMGroupListViewController * g = [[IMGroupListViewController alloc]init];
            [self.navigationController pushViewController:g animated:YES];
        }else {
            // 聊天室
        }
        return;
    }
    
  
    RCUserInfo *aUserInfo = [AppDelegate shareAppDelegate].friendsArray[indexPath.row];
    PersonCenterViewController *personCenterVC = [[PersonCenterViewController alloc]init];
    personCenterVC.showUserInfo = aUserInfo;
    personCenterVC.title = aUserInfo.name;
    personCenterVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personCenterVC animated:YES];
 
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"";
    }
    return @"我的好友";
}
@end
