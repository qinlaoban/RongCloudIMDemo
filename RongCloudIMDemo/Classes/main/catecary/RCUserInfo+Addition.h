//
//  RCUserInfo+Addition.h
//
//  Created by Qin on 2020/7/21.
//  Copyright (c) 2020年 Qin. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>
// 为RCUserInfo 扩展分类，
@interface RCUserInfo (Addition)

/** QQ*/
@property(nonatomic, strong) NSString *QQ;

/** sex*/
@property(nonatomic, strong) NSString *sex;

/** token*/
@property(nonatomic, strong) NSString *token;

/** type*/
@property(nonatomic, strong) NSString *type;

/**
 
 指派的初始化方法，根据给定字段初始化实例
 

 @param QQ               QQ
 @param sex             sex
 */
- (instancetype)initWithUserId:(NSString *)userId name:(NSString *)username portrait:(NSString *)portrait QQ:(NSString *)QQ sex:(NSString *)sex;

- (instancetype)initWithUserId:(NSString *)userId name:(NSString *)username portrait:(NSString *)portrait QQ:(NSString *)QQ sex:(NSString *)sex token:(NSString *)token;
@end
