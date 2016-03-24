//
//  HouseTypeTableViewCell.m
//  ObjCTraining
//
//  Created by RWuser on 23/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "HouseTypeTableViewCell.h"
@interface HouseTypeTableViewCell ()

@end
@implementation HouseTypeTableViewCell
CGRect imageFrame;
- (void)awakeFromNib {
    
    // Initialization code
}

- (void)layoutSubviews{
    [super layoutSubviews];
    imageFrame = _typeImage.frame;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    CGFloat borderWidth = 4.0f;
    
    if(selected) {
        _typeImage.frame = CGRectInset(imageFrame, -borderWidth, -borderWidth);
        _typeImage.layer.borderColor = [UIColor colorWithRed:41.0f/255.0f green:181.0f/255.0f blue:100.0f/255.0f alpha:1.0f].CGColor;
        _typeImage.layer.borderWidth = borderWidth;
    } else {
        _typeImage.frame = imageFrame;
        _typeImage.layer.borderWidth = 0.0f;
    }
}

@end
