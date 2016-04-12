//
//  ContactItem.h
//  ObjCTraining
//
//  Created by RWuser on 11/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactInfo.h"

@interface ContactItem : NSObject<ContactInfo>
@property NSString* name;
@property NSString* role;
@property NSString* phoneNumber;
@property NSString* avatarImageUrl;

- (instancetype)initWithName:(NSString*)name role:(NSString*)role;
- (instancetype)initWithName:(NSString*)name role:(NSString*)role phoneNumber:(NSString*)phoneNumber avatarImageUrl:(NSString*)avatarImageUrl;
@end
