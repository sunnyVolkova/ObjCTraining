//
//  ActivityFeedTableViewCell+ConfigureForLCFeed.m
//  ObjCTraining
//
//  Created by RWuser on 04/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "ActivityFeedTableViewCell+ConfigureForFeed.h"

static NSString *const createdTimeFormat = @"HH:mm:ss";

@implementation ActivityFeedTableViewCell (ConfigureForFeed)
- (void)setCellValuesWithFeed:(LCFeed *)feed {
    if (feed == nil) {
        NSLog(@"feed is nil");
        return;
    }
    UIImage *image = [UIImage imageNamed:feed.imageName];
    self.actionImageView.image = image;

    self.descriptionTextLabel.text = feed.descriptionText;
    self.timeLabel.text = [self getTimeStringFromDate:feed.createdDate];
}

- (NSString *)getTimeStringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormat setDateFormat:createdTimeFormat];
    return [dateFormat stringFromDate:date];
}
@end
