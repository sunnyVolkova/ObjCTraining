//
//  ContactListTableViewCell+ConfigureForContactinfo.m
//  ObjCTraining
//
//  Created by RWuser on 11/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "ContactListTableViewCell+ConfigureForContactInfo.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ContactListTableViewCell (ConfigureForContactInfo)
- (void)setCellValuesWithContactInfo: (id<ContactInfo>) contactInfo {
    self.nameLabel.text = contactInfo.name;
    self.roleLabel.text = contactInfo.role;
    if ([contactInfo respondsToSelector:@selector(avatarImageUrl)]) {
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:contactInfo.avatarImageUrl]];
    } else {
        self.avatarImageView.image = nil;
    }
}
@end
