//
//  HouseTypeTableViewCell.m
//  ObjCTraining
//
//  Created by RWuser on 23/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "PropertyTableViewCell.h"
@implementation PropertyTableViewCell
CGRect imageFrame;

- (void)layoutSubviews {
    [super layoutSubviews];
    imageFrame = _image.frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    CGFloat borderWidth = 4.0f;
    
    if(selected) {
        _image.frame = CGRectInset(imageFrame, -borderWidth, -borderWidth);
        _image.layer.borderColor = [UIColor colorWithRed:41.0f/255.0f green:181.0f/255.0f blue:100.0f/255.0f alpha:1.0f].CGColor;
        _image.layer.borderWidth = borderWidth;
    } else {
        _image.frame = imageFrame;
        _image.layer.borderWidth = 0.0f;
    }
}

@end
