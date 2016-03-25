//
//  HouseTypeTableViewCell.m
//  ObjCTraining
//
//  Created by RWuser on 23/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "PropertyTableViewCell.h"
@implementation PropertyTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated]; 
    if(selected) {
        self.border.hidden = false;
    } else {
        self.border.hidden = true;
    }
}

@end
