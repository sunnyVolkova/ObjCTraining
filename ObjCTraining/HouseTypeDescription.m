//
//  HouseTypeDescription.m
//  ObjCTraining
//
//  Created by RWuser on 23/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "HouseTypeDescription.h"

@implementation HouseTypeDescription
- (instancetype)initWithDescription: (NSString*) description
{
    self = [super init];
    if (self) {
        self.text = description;
    }
    return self;
}

- (instancetype)initWithDescription: (NSString*) description imageName: (NSString*) imageName
{
    self = [super init];
    if (self) {
        self.text = description;
        self.imageName = imageName;
    }
    return self;
}

@end
