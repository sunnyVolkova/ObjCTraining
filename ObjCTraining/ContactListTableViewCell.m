//
//  ContactListTableViewCell.m
//  ObjCTraining
//
//  Created by RWuser on 11/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "ContactListTableViewCell.h"

@implementation ContactListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.phoneButton addTarget:self action:@selector(phoneButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.infoButton addTarget:self action:@selector(infoButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)phoneButtonDidTap:(id)sender {
    if (self.phoneButtonDidTapBlock) {
        self.phoneButtonDidTapBlock(sender);
    }
}

- (void)infoButtonDidTap:(id)sender {
    if (self.infoButtonDidTapBlock) {
        self.infoButtonDidTapBlock(sender);
    }
}
@end
