//
//  HouseTypeDescription.h
//  ObjCTraining
//
//  Created by RWuser on 23/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Property.h"
@interface HouseTypeDescription : NSObject<Property>
@property NSString* text;
@property NSString* imageName;
- (instancetype)initWithDescription: (NSString*) description imageName: (NSString*) imageName;
- (instancetype)initWithDescription: (NSString*) description;
@end
