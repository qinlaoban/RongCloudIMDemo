//
//  RCGroup+IMGroup.h
//  RongCloudIMDemo
//
//  Created by Qin on 2020/9/3.
//  Copyright © 2020 qin. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCGroup (IMGroup)

/// 该群组的 ids
@property (nonatomic,strong) NSArray *ids;


@end

NS_ASSUME_NONNULL_END
