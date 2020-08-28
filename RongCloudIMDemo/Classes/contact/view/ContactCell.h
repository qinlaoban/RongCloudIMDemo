//
//  ContactCell.h
//  RCSupport
//
//  Created by Qin on 2020/7/22.
//  Copyright © 2020年 Qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;



@property (weak, nonatomic) IBOutlet UILabel *sexLabel;


@property (weak, nonatomic) IBOutlet UILabel *QQLabel;

@end
