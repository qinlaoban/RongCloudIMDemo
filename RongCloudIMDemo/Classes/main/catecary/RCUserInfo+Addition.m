//
//  RCUserInfo+Addition.m
//
//  Created by Qin on 2020/7/21.
//  Copyright (c) 2020年 Qin. All rights reserved.
//

#import "RCUserInfo+Addition.h"
#import <objc/runtime.h>




@implementation RCUserInfo (Addition)
@dynamic QQ;
@dynamic sex;
@dynamic token;
- (instancetype)initWithUserId:(NSString *)userId name:(NSString *)username portrait:(NSString *)portrait QQ:(NSString *)QQ sex:(NSString *)sex{
    if (self = [super init]) {
        self.userId        =   userId;
        self.name          =   username;
        self.portraitUri   =   portrait;
        self.QQ         =   QQ;
        self.sex   =   sex;
        

    }
    return self;
}

- (instancetype)initWithUserId:(NSString *)userId name:(NSString *)username portrait:(NSString *)portrait QQ:(NSString *)QQ sex:(NSString *)sex token:(NSString *)token {
    if (self = [super init]) {
           self.userId        =   userId;
           self.name          =   username;
           self.portraitUri   =   portrait;
           self.QQ         =   QQ;
           self.sex   =   sex;
           self.token = token;

       }
       return self;
}
- (instancetype)initWithUserId:(NSString *)userId name:(NSString *)username portrait:(NSString *)portrait QQ:(NSString *)QQ sex:(NSString *)sex token:(NSString *)token type:(NSString *)type{
    if (self = [super init]) {
           self.userId        =   userId;
           self.name          =   username;
           self.portraitUri   =   portrait;
           self.QQ         =   QQ;
           self.sex   =   sex;
           self.token = token;
        self.type = type;
        
       }
       return self;
}


//添加属性扩展set方法
static char* const QQ = "QQ";
static char* const SEX = "SEX";
static char* const TOKEN = "TOKEN";
static char* const TYPE = "TYPE";
-(void)setQQ:(NSString *)newQQ{
    
    objc_setAssociatedObject(self,QQ,newQQ,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
-(void)setSex:(NSString *)newSex{
    
    objc_setAssociatedObject(self,SEX,newSex,OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
-(void)setToken:(NSString *)newToken{
    
    objc_setAssociatedObject(self,TOKEN,newToken,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setType:(NSString *)newType{
    
    objc_setAssociatedObject(self,TYPE,newType,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//添加属性扩展get方法
-(NSString *)QQ{
    return objc_getAssociatedObject(self,QQ);
}
-(NSString *)sex{
    return objc_getAssociatedObject(self,SEX);
}
-(NSString *)token{
    return objc_getAssociatedObject(self,TOKEN);
}
-(NSString *)type{
    return objc_getAssociatedObject(self,TYPE);
}

@end

