//
//  AppDelegate.h
//  RCSupport
//
//  Created by Qin on 2020/7/18.
//  Copyright (c) 2020年 Qin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IMRootTabbarViewController.h"
#import "IMDataManager.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain)IMRootTabbarViewController *tabbarVC;
@property(nonatomic,retain) NSMutableArray *friendsArray;
@property(nonatomic,retain) NSMutableArray *groupsArray;


/// func
+ (AppDelegate* )shareAppDelegate;
@end

