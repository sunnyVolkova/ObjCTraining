//
//  BottomButtonTableViewCell+ConfigureForTitle.m
//  ObjCTraining
//
//  Created by WeezLabs on 15/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "BottomButtonTableViewCell+ConfigureForTitle.h"

@implementation BottomButtonTableViewCell (ConfigureForTitle)
- (void)configureWithTitle:(NSString *)title {
    [self.button setTitle:title forState:UIControlStateNormal&UIControlStateHighlighted&UIControlStateSelected];
}
@end
