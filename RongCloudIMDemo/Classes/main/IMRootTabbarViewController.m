


//
//  IMRootTabbarViewController.m
//  RCSupport
//
//  Created by Qin on 2020/7/22.
//  Copyright © 2020年 Qin. All rights reserved.
//

#import "IMRootTabbarViewController.h"
#import "IMNavgationController.h"
#import "IMContactViewController.h"

#import "IMConversationListViewController.h"
#import "IMChatRommController.h"
#import "IMIssueController.h"

#import "IMCustomConversationController.h"
#import "WMConversationListViewController.h"
@interface IMRootTabbarViewController ()

@end

@implementation IMRootTabbarViewController

+ (void)initialize {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSForegroundColorAttributeName] = [UIColor grayColor];
        attributes[NSFontAttributeName] = [UIFont systemFontOfSize:13];

    NSMutableDictionary *selectAttri = [NSMutableDictionary dictionary];
    selectAttri[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    selectAttri[NSFontAttributeName] = [UIFont systemFontOfSize:13];

    //通过appearance对tabBarItem的文字属性进行统一设置，这样所有的控制的tabBarItem的文字属性久都是这种样式的了
    UITabBarItem *tabbar = [UITabBarItem appearance];
    [tabbar setTitleTextAttributes:attributes forState:UIControlStateNormal];
   [tabbar setTitleTextAttributes:selectAttri forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 13.0, *)) {
           
        self.tabBar.tintColor = [UIColor darkGrayColor];
           self.tabBar.unselectedItemTintColor = [UIColor lightGrayColor];
           UITabBarItem *item = [UITabBarItem appearance];
           [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
           [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];
       }
    

     
    IMConversationListViewController *imConversationListVC = [[IMConversationListViewController alloc]init];
    [self addMyChildViewControllers:imConversationListVC title:@"会话列表" image:@"speech_recognition_22x22_" selectedImage:@"speech_recognition_selected_22x22_"];
    
    
    WMConversationListViewController *wcConversationListVC = [[WMConversationListViewController alloc]init];
    [self addMyChildViewControllers:wcConversationListVC title:@"自定义会话列表" image:@"speech_recognition_22x22_" selectedImage:@"speech_recognition_selected_22x22_"];
    

    IMContactViewController *FriendsListVC = [[IMContactViewController alloc]init];
     [self addMyChildViewControllers:FriendsListVC title:@"通讯录" image:@"dictionary_22x22_" selectedImage:@"dictionary_selected_22x22_"];
    
    
   
    IMChatRommController *room = [[IMChatRommController alloc]init];
    [self addMyChildViewControllers:room title:@"聊天室" image:@"dictionary_22x22_" selectedImage:@"dictionary_selected_22x22_"];


    IMIssueController *issueVC = [[IMIssueController alloc]init];
          [self addMyChildViewControllers:issueVC title:@"issue" image:@"speech_recognition_22x22_" selectedImage:@"speech_recognition_selected_22x22_"];
    
    
    
    
}
/// 添加controller
- (void)addMyChildViewControllers:(UIViewController *)controller title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImage{
    
  
    controller.tabBarItem.title =  title;
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    controller.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    IMNavgationController *nav = [[IMNavgationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
    
     
}



@end
