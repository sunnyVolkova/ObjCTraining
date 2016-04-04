//
//  ActivityFeedTableViewCell+ConfigureForLCFeed.m
//  ObjCTraining
//
//  Created by RWuser on 04/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "ActivityFeedTableViewCell+ConfigureForLCFeed.h"

@implementation ActivityFeedTableViewCell (ConfigureForLCFeed)
- (void)setCellValuesWithLCFeed: (LCFeed*) lcFeed {
    self.imageView.image = [UIImage imageNamed:lcFeed.imageName];
    self.descriptionTextLabel.text = lcFeed.descriptionText;
    self.timeLabel.text = lcFeed.updatedDate.description;
}
@end
