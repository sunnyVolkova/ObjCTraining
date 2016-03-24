//
//  HouseTypeTableViewCell+SetCellValues.h
//  ObjCTraining
//
//  Created by RWuser on 24/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "PropertyTableViewCell.h"
#import "Property.h"
@interface PropertyTableViewCell (ConfigureForProperty)
- (void)setCellValuesWithProperty: (id<Property>) property;
@end
