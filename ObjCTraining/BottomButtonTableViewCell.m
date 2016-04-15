//
//  BottomButtonTableViewCell.m
//  ObjCTraining
//
//  Created by WeezLabs on 15/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "BottomButtonTableViewCell.h"

@implementation BottomButtonTableViewCell

- (IBAction)buttonTap:(UIButton *)sender {
    if (self.cellDidSelectBlock) {
        self.cellDidSelectBlock(sender);
    }
}

@end
