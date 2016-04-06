//
//  ActivityFeedViewController.m
//  ObjCTraining
//
//  Created by Sunny on 04/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "ActivityFeedViewController.h"
#import "ActivityFeedTableViewCell.h"
#import "ActivityFeedTableViewCell+ConfigureForFeed.h"
#import "LCFeed.h"

static NSString *const activityFeedCellIdentifier = @"ActivityFeedTableViewCell";
static NSString *const sectionHeaderDateFormat = @"MMMM d, yyyy";
static int const cellHeight = 70;
static int const sectionHeaderHeight = 46;

@interface ActivityFeedViewController ()
@property NSMutableArray *feeds;
@end

@implementation ActivityFeedViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = cellHeight;
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityFeedTableViewCell" bundle:nil] forCellReuseIdentifier:activityFeedCellIdentifier];
    [self initDataSource];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.feeds.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSMutableArray *)(self.feeds[section])).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:activityFeedCellIdentifier forIndexPath:indexPath];
    NSArray *feedsInSection = [self.feeds objectAtIndex:indexPath.section];
    LCFeed *feed = [feedsInSection objectAtIndex:indexPath.row];
    [cell setCellValuesWithFeed:feed];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    label.backgroundColor = [UIColor colorWithRed:146.0f/255.0f green:212.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    label.font = [UIFont systemFontOfSize:17];
    NSArray *feedsInSection = [self.feeds objectAtIndex:section];
    LCFeed *feed = [feedsInSection firstObject];
    if (feed != nil) {
        NSDate *date = feed.createdDate;
        label.text = [self getDateStringFromDate:date];
    }
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return sectionHeaderHeight;
}

#pragma mark - Prepare data source

- (void)initDataSource {
    NSArray *feeds = [self parseDataFromFile:@"ActivityFeedsDataSource"];
    NSMutableArray *resultArray = [NSMutableArray new];
    NSMutableOrderedSet *orderedDates = [NSMutableOrderedSet new];
    for (LCFeed *feed in feeds) {
        [orderedDates addObject:feed.createdDateString];
    }

    for (NSString *name in orderedDates) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"createdDateString = %@", name];
        NSArray *groupOfFeeds = [feeds filteredArrayUsingPredicate:predicate];
        [resultArray addObject:groupOfFeeds];
    }

    self.feeds = resultArray;
}

- (NSMutableArray *)parseDataFromFile:(NSString *)fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

    NSDictionary *dataDict = jsonDict[@"data"];
    NSMutableArray *resultArray = [NSMutableArray array];
    if (dataDict) {
        for (NSDictionary *feedDict in dataDict) {
            LCFeed *feed = [[LCFeed alloc] initWithDictionary:feedDict];
            if (feed) {
                [resultArray addObject:feed];
            }
            else {
                NSLog(@"Feed initialization error.");
                return nil;
            }
        }
    }
    return resultArray;
}

- (NSString *)getDateStringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormat setDateFormat:sectionHeaderDateFormat];
    return [dateFormat stringFromDate:date];
}
@end
