//
//  BottomButtonTableViewCell.h
//  ObjCTraining
//
//  Created by WeezLabs on 15/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomButtonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (copy, nonatomic) void (^cellDidSelectBlock)(id sender);
@end
