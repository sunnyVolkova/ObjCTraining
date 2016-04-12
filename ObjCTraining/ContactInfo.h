//
//  ContactInfo.h
//  ObjCTraining
//
//  Created by RWuser on 11/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ContactInfo <NSObject>

@required
@property NSString* name;
@property NSString* role;

@optional
@property NSString* avatarImageUrl;
@property NSString* phoneNumber;

@end
