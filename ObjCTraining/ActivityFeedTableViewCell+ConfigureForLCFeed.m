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
    if(lcFeed == nil) {
        NSLog(@"lcFeed is nil");
        return;
    }
    if (lcFeed.imageName != nil) {
        UIImage *image = [UIImage imageNamed:lcFeed.imageName];
        if (image != nil) {
            self.actionImageView.image = image;
        }
    }
    self.descriptionTextLabel.text = lcFeed.descriptionText;
    self.timeLabel.text = lcFeed.updatedDate.description;
}
@end
