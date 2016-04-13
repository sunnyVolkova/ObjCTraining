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
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* role;
@property (nonatomic, copy) NSString* phoneNumber;
@property (nonatomic, copy) NSString* avatarImageUrl;

- (instancetype)initWithName:(NSString*)name role:(NSString*)role;
- (instancetype)initWithName:(NSString*)name role:(NSString*)role phoneNumber:(NSString*)phoneNumber avatarImageUrl:(NSString*)avatarImageUrl;
@end
