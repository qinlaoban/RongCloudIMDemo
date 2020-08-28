


//
//  IMRCCustomMessageCell.m
//  RCSupport
//
//  Created by Qin on 2020/7/20.
//  Copyright © 2002年 Qin. All rights reserved.
//

#import "RCCustomMessageCell.h"
#import "IMRCCustomMessage.h"



@interface RCCustomMessageCell ()

@property(nonatomic,strong)UIButton *btn;

@end

@implementation RCCustomMessageCell
/*!
自定义消息Cell的Size

一般而言，Cell的高度应该是内容显示的高度再加上extraHeight的高度。
*/
+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight {

    return CGSizeMake(collectionViewWidth, 50+extraHeight);
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
        self.messageContentView.backgroundColor = [UIColor redColor];
        
        
    }
    return self;
}

- (void)initialize {
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blueColor];
    [button setFrame:CGRectMake(0, 0, 200, 30)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
 
    [self.messageContentView addSubview:button];
    
    
    

    
}

- (void)setDataModel:(RCMessageModel *)model {
    [super setDataModel:model];
    
    IMRCCustomMessage *message = (IMRCCustomMessage *)model.content;
    [_btn setTitle:message.content forState:UIControlStateNormal];
    
    [[RCIMClient sharedRCIMClient]deleteMessages:nil];

    [[RCIMClient sharedRCIMClient]clearConversations:nil];
}



//- (void)messageCellUpdateSendingStatusEvent:(NSNotification *)notification {
//    NSLog(@"notification：%@",[notification modelToJSONString]);
//}

@end
