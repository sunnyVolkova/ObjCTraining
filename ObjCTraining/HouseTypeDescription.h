//
//  HouseTypeDescription.h
//  ObjCTraining
//
//  Created by RWuser on 23/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HouseTypeDescription : NSObject
@property NSString* typeDescription;
@property NSString* imageName;
- (instancetype)initWithDescription: (NSString*) description imageName: (NSString*) imageName;
- (instancetype)initWithDescription: (NSString*) description;
@end
