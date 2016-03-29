//
//  FirstViewController.m
//  ObjCTraining
//
//  Created by RWuser on 23/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "AddPropertyViewController.h"
#import "PropertyTableViewCell.h"
#import "HouseTypeDescription.h"

@interface AddPropertyViewController ()
@property NSArray<HouseTypeDescription *> *datasource;
@end

@implementation AddPropertyViewController
static NSString *houseTypeCellIdentifier = @"PropertyTableViewCell";
static NSString *continueCellIdentifier = @"ContinueCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName: @"PropertyTableViewCell" bundle:nil] forCellReuseIdentifier:houseTypeCellIdentifier];
    [self initDataSource];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
}



#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _datasource.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PropertyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:houseTypeCellIdentifier forIndexPath:indexPath];
        HouseTypeDescription *desription = [_datasource objectAtIndex: indexPath.row];
        [cell setCellValuesWithProperty: desription];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:continueCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 168;
    } else {
        return 76;
    }
}

#pragma mark - Actions

- (IBAction)addYourOwnButtonPressed:(id)sender {
    NSLog(@"addYourOwnButtonPressed");
}

- (IBAction)addFromButtonPressed:(id)sender {
    NSLog(@"addFromButtonPressed");
}

- (IBAction)continueButtonPressed:(id)sender {
    NSLog(@"continueButtonPressed");
}

- (void) initDataSource {
    NSMutableArray *datasource = [NSMutableArray array];
    [datasource addObject:[[HouseTypeDescription alloc] initWithDescription: @"Primary Residense" imageName: @"house1"]];
    [datasource addObject:[[HouseTypeDescription alloc] initWithDescription: @"Single Family Home" imageName: @"house2"]];
    [datasource addObject:[[HouseTypeDescription alloc] initWithDescription: @"Condo" imageName: @"house3"]];
    [datasource addObject:[[HouseTypeDescription alloc] initWithDescription: @"Town House" imageName: @"house4"]];
    [datasource addObject:[[HouseTypeDescription alloc] initWithDescription: @"Second Home" imageName: @"house5"]];
    _datasource = [NSArray arrayWithArray:datasource];
}

@end
