

//
//  ContactCell.m
//  RCSupport
//
//  Created by Qin on 2020/7/22.
//  Copyright © 2020年 Qin. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    if (@available(iOS 13.0, *)) {
        self.userNameLabel.textColor = [UIColor labelColor];
        self.QQLabel.textColor = [UIColor labelColor];
        self.sexLabel.textColor = [UIColor labelColor];
    } else {
        // Fallback on earlier versions
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
