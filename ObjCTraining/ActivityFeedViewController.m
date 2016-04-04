//
//  ActivityFeedViewController.m
//  ObjCTraining
//
//  Created by Sunny on 04/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "ActivityFeedViewController.h"
#import "ActivityFeedTableViewCell.h"
#import "ActivityFeedTableViewCell+ConfigureForLCFeed.h"
#import "LCFeed.h"

static NSString * const activityFeedCellIdentifier = @"ActivityFeedTableViewCell";

@interface ActivityFeedViewController()
@property NSMutableArray *feeds;
@end

@implementation ActivityFeedViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName: @"ActivityFeedTableViewCell" bundle:nil] forCellReuseIdentifier:activityFeedCellIdentifier];
    [self initDataSource];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
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
    NSArray *lcFeedSection = [self.feeds objectAtIndex: indexPath.section];
    LCFeed *lcFeed = [lcFeedSection objectAtIndex: indexPath.row];
    [cell setCellValuesWithLCFeed: lcFeed];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *HeaderCellIdentifier = @"SectionHeader";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
    }
    
    // Configure the cell title etc
    //[self configureHeaderCell:cell inSection:section];
    
    return cell;
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

- (NSMutableArray *)parseDataFromFile:(NSString*) fileName{
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
                NSLog(@"LCFeed initialization error.");
                return nil;
            }
        }
    }
    return resultArray;
}

@end
