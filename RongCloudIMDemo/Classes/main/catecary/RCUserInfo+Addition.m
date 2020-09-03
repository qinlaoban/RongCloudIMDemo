//
//  RCUserInfo+Addition.m
//
//  Created by Qin on 2020/7/21.
//  Copyright (c) 2020年 Qin. All rights reserved.
//

#import "RCUserInfo+Addition.h"



@implementation RCUserInfo (Addition)


- (void)setQQ:(NSString *)object {

    objc_setAssociatedObject(self, @selector(QQ), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSex:(NSString *)object {

    objc_setAssociatedObject(self, @selector(sex), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setToken:(NSString *)object {

    objc_setAssociatedObject(self, @selector(token), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setType:(NSString *)object {

    objc_setAssociatedObject(self, @selector(type), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)QQ {

    return objc_getAssociatedObject(self, @selector(QQ));
}

- (NSString *)sex {

    return objc_getAssociatedObject(self, @selector(sex));
}

- (NSString *)token {

    return objc_getAssociatedObject(self, @selector(token));
}

- (NSString *)type {

    return objc_getAssociatedObject(self, @selector(type));
}


@end

