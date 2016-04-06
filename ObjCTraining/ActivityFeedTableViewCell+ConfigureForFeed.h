//
//  ActivityFeedTableViewCell+ConfigureForLCFeed.h
//  ObjCTraining
//
//  Created by RWuser on 04/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "ActivityFeedTableViewCell.h"
#import "LCFeed.h"

@interface ActivityFeedTableViewCell (ConfigureForFeed)
- (void)setCellValuesWithFeed:(LCFeed *)lcFeed;
@end
