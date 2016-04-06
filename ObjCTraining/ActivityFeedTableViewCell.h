//
//  ActivityFeedTableViewCell.h
//  ObjCTraining
//
//  Created by RWuser on 04/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityFeedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *actionImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionTextLabel;
@end
