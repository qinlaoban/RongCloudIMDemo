//
//  RCGroup+IMGroup.m
//  RongCloudIMDemo
//
//  Created by Qin on 2020/9/3.
//  Copyright © 2020 qin. All rights reserved.
//

#import "RCGroup+IMGroup.h"

@implementation RCGroup (IMGroup)
- (void)setIds:(NSArray *)object {

    objc_setAssociatedObject(self, @selector(ids), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)ids {

    return objc_getAssociatedObject(self, @selector(ids));
}
@end
