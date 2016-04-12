//
//  ContactItem.m
//  ObjCTraining
//
//  Created by RWuser on 11/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "ContactItem.h"

@implementation ContactItem
- (instancetype)initWithName:(NSString*)name role:(NSString*)role {
    self = [super init];
    if (self) {
        self.name = name;
        self.role = role;
    }
    return self;
}

- (instancetype)initWithName:(NSString*)name role:(NSString*)role phoneNumber:(NSString*)phoneNumber avatarImageUrl:(NSString*)avatarImageUrl {
    self = [super init];
    if (self) {
        self.name = name;
        self.role = role;
        self.phoneNumber = phoneNumber;
        self.avatarImageUrl = avatarImageUrl;
    }
    return self;
}

@end
