//
//  HouseTypeTableViewCell+SetCellValues.m
//  ObjCTraining
//
//  Created by RWuser on 24/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "PropertyTableViewCell+ConfigureForProperty.h"
@implementation PropertyTableViewCell (ConfigureForProperty)
- (void)setCellValuesWithProperty: (id<Property>) property {
    self.name.text = property.text;
    if ([property respondsToSelector:@selector(imageName)]) {
        self.image.image = [UIImage imageNamed:property.imageName];
    }
}
@end
