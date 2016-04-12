//
//  ContactListTableViewCell+ConfigureForContactinfo.h
//  ObjCTraining
//
//  Created by RWuser on 11/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "ContactListTableViewCell.h"
#import "ContactInfo.h"

@interface ContactListTableViewCell (ConfigureForContactInfo)
- (void)setCellValuesWithContactInfo: (id<ContactInfo>) contactInfo;
@end
