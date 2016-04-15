//
//  MenuItemTableViewCell+ConfigureForTitle.m
//  ObjCTraining
//
//  Created by WeezLabs on 15/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "MenuItemTableViewCell+ConfigureForTitle.h"

@implementation MenuItemTableViewCell (ConfigureForTitle)

- (void)configureWithTitle:(NSString *)title {
    self.titleTextLabel.text = title;
}

@end
