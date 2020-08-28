//
//  IMLoginViewController.m
//  RCSupport
//
//  Created by Qin on 2020/7/22.
//  Copyright © 2020年 Qin. All rights reserved.
//

#import "IMLoginViewController.h"
#import "RCUserInfo+Addition.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"

@interface IMLoginViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)NSArray *dataSource;

@end

@implementation IMLoginViewController


-(void)initLoacalTestData{
    
    
    _dataSource = [[NSMutableArray alloc]init];
    
   NSString * path = [[NSBundle mainBundle]pathForResource:@"contacts.plist" ofType:nil];
    _dataSource = [[NSArray alloc]initWithContentsOfFile:path];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择某个身份登录";
    
    [self initLoacalTestData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ContactCell" bundle:nil] forCellReuseIdentifier:@"ContactCell"];
 
 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 98;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContactCell  *cell = (ContactCell *)[tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    
    NSDictionary *aUserInfoDict = self.dataSource[indexPath.row];
    RCUserInfo *aUserInfo = [RCUserInfo modelWithDictionary:aUserInfoDict];

    [cell.portraitImageView sd_setImageWithURL:[NSURL URLWithString:aUserInfo.portraitUri] placeholderImage:[UIImage imageNamed:@"DefaultHeader"]];
    
    cell.userNameLabel.text = aUserInfo.name;
    cell.QQLabel.text = aUserInfo.QQ;
    cell.sexLabel.text = aUserInfo.sex;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     NSDictionary *aUserInfoDict = self.dataSource[indexPath.row];
      RCUserInfo *aUserInfo = [RCUserInfo modelWithDictionary:aUserInfoDict];

    
    [[IMDataManager shareManager] loginRongCloudWithUserInfo:aUserInfo complete:^{
        // 登录成功切换rootVC
               dispatch_async(dispatch_get_main_queue(), ^{
                   [AppDelegate shareAppDelegate].tabbarVC.modalPresentationStyle = UIModalPresentationFullScreen;

                   [self presentViewController:[AppDelegate shareAppDelegate].tabbarVC animated:YES completion:nil];
               });
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
