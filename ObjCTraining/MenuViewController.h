//
//  MenuViewController.h
//  ObjCTraining
//
//  Created by RWuser on 13/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameTextLabel;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@end
