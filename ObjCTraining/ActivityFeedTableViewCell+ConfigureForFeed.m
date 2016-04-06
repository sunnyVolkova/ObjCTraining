//
//  ActivityFeedTableViewCell+ConfigureForLCFeed.m
//  ObjCTraining
//
//  Created by RWuser on 04/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "ActivityFeedTableViewCell+ConfigureForFeed.h"

@implementation ActivityFeedTableViewCell (ConfigureForFeed)
- (void)setCellValuesWithFeed:(LCFeed *)feed {
    if (feed == nil) {
        NSLog(@"feed is nil");
        return;
    }
    UIImage *image = [UIImage imageNamed:feed.imageName];
    self.actionImageView.image = image;

    self.descriptionTextLabel.text = feed.descriptionText;
    self.timeLabel.text = [NSDateFormatter localizedStringFromDate:feed.createdDate dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
}
@end
