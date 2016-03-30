//
//  ValidationManager.h
//  ObjCTraining
//
//  Created by Sunny on 29/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CheckInput)
+ (BOOL)isAddressValid: (NSString *) address;
+ (BOOL)isCityValid: (NSString *) city;
+ (BOOL)isStateValid: (NSString *) state;
+ (BOOL)isZipValid: (NSString *) zip;
+ (BOOL)isCountryValid: (NSString *) country;
@end
