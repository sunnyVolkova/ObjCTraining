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
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* role;

@optional
@property (nonatomic, copy) NSString* avatarImageUrl;
@property (nonatomic, copy) NSString* phoneNumber;

@end
