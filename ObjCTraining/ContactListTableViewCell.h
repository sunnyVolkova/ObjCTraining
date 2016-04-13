//
//  ContactListTableViewCell.h
//  ObjCTraining
//
//  Created by RWuser on 11/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (copy, nonatomic) void (^phoneButtonDidTapBlock)(id sender);
@property (copy, nonatomic) void (^infoButtonDidTapBlock)(id sender);
@end
